import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../state.dart';

class MyURIDialog extends ConsumerWidget {
  const MyURIDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUri = ref.read(myInfosProvider).uriString;
    return SimpleDialog(children: [
      Container(
        alignment: Alignment.center,
        width: 300,
        height: 300,
        child: QrImageView(
          data: myUri,
          version: QrVersions.auto,
          size: 300.0,
        ),
      ),
      SelectableText(myUri),
    ]);
  }
}
