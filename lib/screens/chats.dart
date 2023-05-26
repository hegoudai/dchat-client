import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dchat_client/db/prefs.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:dchat_client/web/websocket.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../db/app_database.dart';
import '../models/message_encrypted.dart';

class Chats extends ConsumerStatefulWidget {
  const Chats({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsState();
}

class _ChatsState extends ConsumerState<Chats> {
  final _serverController = TextEditingController();
  final _userInfoController = TextEditingController();
  final _newChatController = TextEditingController();
  WebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      // try to reconnect ws every ten seconds
      if (!ref.watch(wsStateProvider)) {
        ref.invalidate(wsChannelProvider);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _channel?.sink.close();
    _newChatController.dispose();
    _serverController.dispose();
    _userInfoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _handleWSMessage();
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
                                const InputDecoration(labelText: 'DCUri'),
                            controller: _newChatController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                if (_newChatController.text.isNotEmpty) {
                                  var uri =
                                      Uri.tryParse(_newChatController.text);
                                  if ((uri != null) & uri!.isScheme('dc')) {
                                    final db = ref.watch(AppDatabase.provider);
                                    db.into(db.chats).insert(
                                        ChatsCompanion.insert(
                                            pub: uri.pathSegments[0],
                                            authority: uri.authority),
                                        mode: InsertMode.insertOrReplace);
                                  }
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
                    child: const Text('User Config'),
                    onTap: () {
                      final user = ref.watch(myInfosProvider);
                      final uri = Uri.tryParse(user.uriString);
                      if (uri != null) {
                        _serverController.text =
                            '${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
                        _userInfoController.text = uri.userInfo;
                      } else {}
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('User Config'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration:
                                      const InputDecoration(labelText: 'Sever'),
                                  controller: _serverController,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                      labelText: 'UserInfo'),
                                  controller: _userInfoController,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  if (_serverController.text.isNotEmpty) {
                                    var authority =
                                        '${_userInfoController.text}@${_serverController.text}';
                                    ref
                                        .watch(prefsProvider)
                                        .setString('authority', authority);
                                    ref.invalidate(myAuthorityProvider);
                                  }
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
                  child: const Text('My URI'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SimpleDialog(children: [
                                SelectableText(
                                    ref.watch(myInfosProvider).uriString),
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

  void _handleWSMessage() {
    ref.watch(wsChannelProvider).when(
        loading: () {},
        error: (error, stackTrace) {
          log('Error while build websocket channel: $error');
          Future(() => ref.read(wsStateProvider.notifier).state = false);
        },
        data: (value) {
          if (value == _channel) {
            return;
          }

          _channel = value;
          _channel?.ready
              .then((_) => ref.read(wsStateProvider.notifier).state = true);
          _channel?.stream.listen((event) {
            final value = event.toString();
            log('received value: $value');
            // write message to db
            final encryptedMessage =
                EncryptedMessage.fromJson(jsonDecode(value));
            final database = ref.watch(AppDatabase.provider);

            final chat = Chat(
                pub: encryptedMessage.fromPub,
                authority: encryptedMessage.authority);

            var myAddressInfos = ref.watch(myInfosProvider);

            database
                .into(database.chats)
                .insert(chat, mode: InsertMode.insertOrReplace);
            database
                .into(database.messages)
                .insert(encryptedMessage.toMessage(myAddressInfos.ecPriv));
          }, onError: (e) {
            log('error while listening ws: $e');
          }, onDone: () {
            log('ws done');
            Future(() => ref.read(wsStateProvider.notifier).state = false);
          });
        });
  }
}

class ChatCard extends ConsumerWidget {
  final Chat chat;

  ChatCard(this.chat) : super(key: ObjectKey(chat.pub));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push('/chats/${chat.pub}?authority=${chat.authority}');
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
                    Text(chat.authority),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  final db = ref.watch(AppDatabase.provider);
                  (db.delete(db.chats)
                        ..where((tbl) => tbl.pub.equals(chat.pub)))
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
