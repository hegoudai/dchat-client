import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../db/app_database.dart';
import '../state.dart';

class ChatCard extends ConsumerWidget {
  final Chat chat;

  ChatCard(this.chat) : super(key: ObjectKey(chat.pub));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(AppDatabase.provider).readChat(chat.pub);
        GoRouter.of(context).push('/${chat.pub}?authority=${chat.authority}');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(chat.authority),
                    Visibility(
                      visible: chat.unreadCount != 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  final db = ref.watch(AppDatabase.provider);
                  final myPub = ref.watch(myInfosProvider).ecPubString;
                  db.deleteChatAndMessages(chat.pub, myPub);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}