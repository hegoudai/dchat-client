import 'dart:io';

import 'package:dchat_client/models/message_encrypted.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:dchat_client/web/api.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/app_database.dart';

class ChatDetail extends ConsumerStatefulWidget {
  const ChatDetail({required this.chat, super.key});

  final Chat chat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatDetailState();
}

class _ChatDetailState extends ConsumerState<ChatDetail> {
  final _controller = TextEditingController();
  String? _dbRemark;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // try to load remark from db if remark is null
      if (widget.chat.remark == null) {
        final db = ref.watch(AppDatabase.provider);
        final dbChat = await (db.select(db.chats)
              ..where((tbl) => tbl.pub.equals(widget.chat.pub)))
            .getSingleOrNull();
        _dbRemark = dbChat?.remark;
      }
    });
  }

  @override
  void dispose() {
    ref.watch(AppDatabase.provider).readChat(widget.chat.pub);
    _controller.dispose();
    super.dispose();
  }

  void _addToMessages() async {
    // todo check server config first
    final content = _controller.text;
    _controller.clear();
    if (content.isNotEmpty) {
      final database = ref.watch(AppDatabase.provider);
      final message = Message(
          createDate: DateTime.now(),
          content: content,
          toPub: widget.chat.pub,
          fromPub: ref.watch(myInfosProvider).ecPubString);
      database.messages.insertOne(message);

      var myAddressInfos = ref.watch(myInfosProvider);

      // send message to server
      try {
        var resp = await ref.watch(apiServicesProvider)?.send(
            widget.chat.authority,
            EncryptedMessage.fromMessage(message, myAddressInfos));
        switch (resp?.statusCode) {
          case HttpStatus.ok:
            // message sent, do nothing
            break;
          case HttpStatus.accepted:
            _showToast('Message sent, but user is offline');
            break;
          default:
            _showToast('Unkown status code: ${resp?.statusCode}');
            break;
        }
      } on Exception {
        _showToast('Unable to access ${widget.chat.authority} server');
      }
    }
  }

  void _showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider(widget.chat.pub));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.remark ?? _dbRemark ?? widget.chat.authority),
      ),
      body: messages.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: ListView.builder(
                reverse: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (data[index].toPub != widget.chat.pub
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (data[index].toPub != widget.chat.pub
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          data[index].content,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomSheet: Material(
        elevation: 12,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Type something...'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _addToMessages(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: _addToMessages,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
