import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/prefs.dart';
import '../state.dart';

class UserConfigDialog extends ConsumerStatefulWidget {
  const UserConfigDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<UserConfigDialog> createState() => _UserConfigDialogState();
}

class _UserConfigDialogState extends ConsumerState<UserConfigDialog> {
  final _serverController = TextEditingController();
  final _userInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = ref.read(myInfosProvider);
    final uri = Uri.tryParse(user.uriString);
    if (uri != null) {
      _serverController.text =
          '${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      _userInfoController.text = uri.userInfo;
    }
  }

  @override
  void dispose() {
    _serverController.dispose();
    _userInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User Config'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Sever'),
            controller: _serverController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'UserInfo'),
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
              ref.watch(prefsProvider).setString('authority', authority);
              ref.invalidate(myAuthorityProvider);
            }
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
