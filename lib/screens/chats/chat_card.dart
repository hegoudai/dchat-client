import 'package:dchat_client/screens/chats/chat_edit_dialog.dart';
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
        GoRouter.of(context).push(
            '/${chat.pub}?authority=${chat.authority}${chat.remark == null ? '' : '&remark=${chat.remark}'}');
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
                    Text(chat.remark ?? chat.authority),
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
                icon: const Icon(Icons.edit),
                color: Colors.blue,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) => ChatEditDialog(
                      chat: chat,
                    ),
                  );
                },
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
