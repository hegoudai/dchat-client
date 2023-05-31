import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state.dart';

class MyURIDialog extends ConsumerWidget {
  const MyURIDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(children: [
      SelectableText(ref.watch(myInfosProvider).uriString),
    ]);
  }
}
