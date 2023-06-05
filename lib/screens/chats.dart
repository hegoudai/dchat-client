import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dchat_client/screens/chats/my_uri_dialog.dart';
import 'package:dchat_client/screens/chats/new_chat_dialog.dart';
import 'package:dchat_client/screens/chats/user_config_dialog.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:dchat_client/web/websocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';
import '../models/message_encrypted.dart';
import 'chats/chat_card.dart';

class Chats extends ConsumerStatefulWidget {
  const Chats({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsState();
}

class _ChatsState extends ConsumerState<Chats> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // try to handle
      for (String msg in ref.read(wsManagerProvider.notifier).fetchData()) {
        log('received value: $msg');
        // write message to db
        final encryptedMessage = EncryptedMessage.fromJson(jsonDecode(msg));
        final database = ref.watch(AppDatabase.provider);

        var myAddressInfos = ref.watch(myInfosProvider);
        var message = encryptedMessage.toMessage(myAddressInfos.ecPriv);
        database.insertOrReplaceChat(encryptedMessage.fromPub,
            encryptedMessage.authority, message.content);
        database.into(database.messages).insert(message);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDialog(Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => widget,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Conversations"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('New Chat'),
                  onTap: () {
                    _showDialog(const NewChatDialog());
                  },
                ),
                PopupMenuItem(
                    child: const Text('User Config'),
                    onTap: () {
                      _showDialog(const UserConfigDialog());
                    }),
                PopupMenuItem(
                  child: const Text('My URI'),
                  onTap: () {
                    _showDialog(const MyURIDialog());
                  },
                )
              ],
              icon: const Icon(Icons.add_circle),
              tooltip: 'actions',
            ),
          ],
        ),
        body: Column(
          children: [
            Visibility(
              visible: !ref.watch(wsManagerProvider),
              child: const Text('Can not connect to server!'),
            ),
            ref.watch(chatsProvider).when(
                  data: (data) {
                    return data.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ChatCard(data.elementAt(index));
                            })
                        : const Expanded(
                            child: Center(
                                child: Text(
                              'No chats yet',
                              textAlign: TextAlign.center,
                            )),
                          );
                  },
                  error: (e, s) {
                    log('Error while reading chats from database: $e');
                    return Text(e.toString());
                  },
                  loading: () => const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ));
  }
}
