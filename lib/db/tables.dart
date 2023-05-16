import 'package:drift/drift.dart';

@DataClassName('Chat')
class Chats extends Table {
  TextColumn get address => text()();
}

@DataClassName('Message')
class Messages extends Table {
  TextColumn get content => text()();
  DateTimeColumn get createDate => dateTime().nullable()();
  TextColumn get fromAddress => text()();
  TextColumn get toAddress => text()();
}
