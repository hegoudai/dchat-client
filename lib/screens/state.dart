import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';

final chatsProvider = StreamProvider<List<Chat>>((ref) {
  final database = ref.watch(AppDatabase.provider);
  return database.select(database.chats).watch();
});
