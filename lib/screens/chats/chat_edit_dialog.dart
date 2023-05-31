import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/app_database.dart';

class ChatEditDialog extends ConsumerStatefulWidget {
  final Chat chat;
  const ChatEditDialog({Key? key, required this.chat}) : super(key: key);

  @override
  ConsumerState<ChatEditDialog> createState() => _ChatEditDialogState();
}

class _ChatEditDialogState extends ConsumerState<ChatEditDialog> {
  final _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _remarkController.text = widget.chat.remark ?? '';
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Chat'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Remark'),
            controller: _remarkController,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (_remarkController.text.isNotEmpty) {
              final editedChat =
                  widget.chat.copyWith(remark: Value(_remarkController.text));
              ref.read(AppDatabase.provider).chats.replaceOne(editedChat);
            }
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
