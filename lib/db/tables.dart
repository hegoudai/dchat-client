import 'package:drift/drift.dart';

@DataClassName('Chat')
class Chats extends Table {
  TextColumn get pub => text()();
  TextColumn get authority => text()();

  @override
  Set<Column> get primaryKey => {pub};
}

@DataClassName('Message')
class Messages extends Table {
  TextColumn get content => text()();
  DateTimeColumn get createDate => dateTime().nullable()();
  TextColumn get fromPub => text()();
  TextColumn get toPub => text()();
}
