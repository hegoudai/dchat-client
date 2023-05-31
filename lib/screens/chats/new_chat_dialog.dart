import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/app_database.dart';

class NewChatDialog extends ConsumerStatefulWidget {
  const NewChatDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<NewChatDialog> createState() => _NewChatDialogState();
}

class _NewChatDialogState extends ConsumerState<NewChatDialog> {
  final TextEditingController _newChatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _newChatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Chat'),
      content: TextField(
        decoration: const InputDecoration(labelText: 'DCUri'),
        controller: _newChatController,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (_newChatController.text.isNotEmpty) {
              var uri = Uri.tryParse(_newChatController.text);
              if ((uri != null) & uri!.isScheme('dc')) {
                final db = ref.watch(AppDatabase.provider);
                db.into(db.chats).insert(
                    ChatsCompanion.insert(
                        pub: uri.pathSegments[0], authority: uri.authority),
                    mode: InsertMode.insertOrIgnore);
              }
            }
            Navigator.pop(context);
            // todo route to chat detail
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
