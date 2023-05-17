import 'package:dchat_client/screens/state.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';

class ChatDetail extends ConsumerStatefulWidget {
  const ChatDetail({required this.address, super.key});

  final String address;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatDetailState();
}

class _ChatDetailState extends ConsumerState<ChatDetail> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addToMessages() {
    if (_controller.text.isNotEmpty) {
      final database = ref.watch(AppDatabase.provider);
      final message = Message(
          content: _controller.text,
          toAddress: widget.address,
          fromAddress: ref.watch(myAddressProvider));
      database.messages.insertOne(message);
      // todo send message to server
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider(widget.address));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address),
      ),
      body: messages.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (data[index].toAddress != widget.address
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (data[index].toAddress != widget.address
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
