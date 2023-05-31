import 'package:drift/drift.dart';

@DataClassName('Chat')
class Chats extends Table with AutoIncrementingPrimaryKey {
  TextColumn get pub => text()();
  TextColumn get authority => text()();
  TextColumn get remark => text().nullable()();
  TextColumn get newestMessage => text().nullable()();
  IntColumn get unreadCount =>
      integer().nullable().withDefault(const Constant(0))();
}

@DataClassName('Message')
class Messages extends Table with AutoIncrementingPrimaryKey {
  TextColumn get content => text()();
  DateTimeColumn get createDate => dateTime().nullable()();
  TextColumn get fromPub => text()();
  TextColumn get toPub => text()();
}

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().nullable().autoIncrement()();
}
