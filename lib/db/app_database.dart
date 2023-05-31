import 'package:dchat_client/db/tables.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

@DriftDatabase(tables: [Messages, Chats], include: {'sql.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: ((m, from, to) async {}),
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        if (details.wasCreated) {
          await batch((batch) => {});
        }
      },
    );
  }

  static final StateProvider<AppDatabase> provider = StateProvider((ref) {
    final database = AppDatabase();
    ref.onDispose(database.close);

    return database;
  });

  Future<void> deleteChatAndMessages(String chatPub, String myPub) {
    return transaction(() async {
      await deleteChat(chatPub);

      await deleteMessages(chatPub, myPub);
    });
  }
}
