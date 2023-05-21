import 'dart:developer';

import 'package:dchat_client/db/prefs.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:dchat_client/web/websocket.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_database.dart';

class ChatList extends ConsumerWidget {
  final _serverController = TextEditingController();
  final _newChatController = TextEditingController();

  /// Constructs a [ChatListWithAppBar] widget.
  ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // try to connect websocket
    ref.watch(wsMessageHandler);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Conversations"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('New Chat'),
                  onTap: () {
                    _newChatController.text = '';
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('New Chat'),
                          content: TextField(
                            decoration:
                                const InputDecoration(labelText: 'Address'),
                            controller: _newChatController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // todo validate address
                                if (_newChatController.text.isNotEmpty) {
                                  final db = ref.watch(AppDatabase.provider);
                                  db.into(db.chats).insert(
                                      ChatsCompanion.insert(
                                          address: _newChatController.text),
                                      mode: InsertMode.insertOrIgnore);
                                }
                                Navigator.pop(context);
                                // todo route to chat detail
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
                PopupMenuItem(
                    child: const Text('Config Server'),
                    onTap: () {
                      _serverController.text = ref.watch(serverProvider) ?? '';
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Config Server'),
                            content: TextField(
                              decoration:
                                  const InputDecoration(labelText: 'Sever'),
                              controller: _serverController,
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  ref.watch(prefsProvider).setString(
                                      'server', _serverController.text);
                                  ref.invalidate(serverProvider);
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      });
                    }),
                PopupMenuItem(
                  child: const Text('My Address'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SimpleDialog(children: [
                                SelectableText(ref
                                    .watch(myAddressInfoProvider)
                                    .toAddress()),
                              ]));
                    });
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
              visible: !ref.watch(wsStateProvider),
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

class ChatCard extends ConsumerWidget {
  final Chat chat;

  ChatCard(this.chat) : super(key: ObjectKey(chat.address));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/chats/${chat.address}');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(chat.address),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  final db = ref.watch(AppDatabase.provider);
                  (db.delete(db.chats)
                        ..where((tbl) => tbl.address.equals(chat.address)))
                      .go();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
