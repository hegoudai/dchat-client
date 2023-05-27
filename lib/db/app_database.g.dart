// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pubMeta = const VerificationMeta('pub');
  @override
  late final GeneratedColumn<String> pub = GeneratedColumn<String>(
      'pub', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorityMeta =
      const VerificationMeta('authority');
  @override
  late final GeneratedColumn<String> authority = GeneratedColumn<String>(
      'authority', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [pub, authority];
  @override
  String get aliasedName => _alias ?? 'chats';
  @override
  String get actualTableName => 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pub')) {
      context.handle(
          _pubMeta, pub.isAcceptableOrUnknown(data['pub']!, _pubMeta));
    } else if (isInserting) {
      context.missing(_pubMeta);
    }
    if (data.containsKey('authority')) {
      context.handle(_authorityMeta,
          authority.isAcceptableOrUnknown(data['authority']!, _authorityMeta));
    } else if (isInserting) {
      context.missing(_authorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pub};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      pub: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pub'])!,
      authority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}authority'])!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final String pub;
  final String authority;
  const Chat({required this.pub, required this.authority});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pub'] = Variable<String>(pub);
    map['authority'] = Variable<String>(authority);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      pub: Value(pub),
      authority: Value(authority),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      pub: serializer.fromJson<String>(json['pub']),
      authority: serializer.fromJson<String>(json['authority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pub': serializer.toJson<String>(pub),
      'authority': serializer.toJson<String>(authority),
    };
  }

  Chat copyWith({String? pub, String? authority}) => Chat(
        pub: pub ?? this.pub,
        authority: authority ?? this.authority,
      );
  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('pub: $pub, ')
          ..write('authority: $authority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pub, authority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.pub == this.pub &&
          other.authority == this.authority);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> pub;
  final Value<String> authority;
  final Value<int> rowid;
  const ChatsCompanion({
    this.pub = const Value.absent(),
    this.authority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String pub,
    required String authority,
    this.rowid = const Value.absent(),
  })  : pub = Value(pub),
        authority = Value(authority);
  static Insertable<Chat> custom({
    Expression<String>? pub,
    Expression<String>? authority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pub != null) 'pub': pub,
      if (authority != null) 'authority': authority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith(
      {Value<String>? pub, Value<String>? authority, Value<int>? rowid}) {
    return ChatsCompanion(
      pub: pub ?? this.pub,
      authority: authority ?? this.authority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pub.present) {
      map['pub'] = Variable<String>(pub.value);
    }
    if (authority.present) {
      map['authority'] = Variable<String>(authority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('pub: $pub, ')
          ..write('authority: $authority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createDateMeta =
      const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
      'create_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _fromPubMeta =
      const VerificationMeta('fromPub');
  @override
  late final GeneratedColumn<String> fromPub = GeneratedColumn<String>(
      'from_pub', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toPubMeta = const VerificationMeta('toPub');
  @override
  late final GeneratedColumn<String> toPub = GeneratedColumn<String>(
      'to_pub', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [content, createDate, fromPub, toPub];
  @override
  String get aliasedName => _alias ?? 'messages';
  @override
  String get actualTableName => 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    }
    if (data.containsKey('from_pub')) {
      context.handle(_fromPubMeta,
          fromPub.isAcceptableOrUnknown(data['from_pub']!, _fromPubMeta));
    } else if (isInserting) {
      context.missing(_fromPubMeta);
    }
    if (data.containsKey('to_pub')) {
      context.handle(
          _toPubMeta, toPub.isAcceptableOrUnknown(data['to_pub']!, _toPubMeta));
    } else if (isInserting) {
      context.missing(_toPubMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_date']),
      fromPub: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_pub'])!,
      toPub: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_pub'])!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String content;
  final DateTime? createDate;
  final String fromPub;
  final String toPub;
  const Message(
      {required this.content,
      this.createDate,
      required this.fromPub,
      required this.toPub});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || createDate != null) {
      map['create_date'] = Variable<DateTime>(createDate);
    }
    map['from_pub'] = Variable<String>(fromPub);
    map['to_pub'] = Variable<String>(toPub);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      content: Value(content),
      createDate: createDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createDate),
      fromPub: Value(fromPub),
      toPub: Value(toPub),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      content: serializer.fromJson<String>(json['content']),
      createDate: serializer.fromJson<DateTime?>(json['createDate']),
      fromPub: serializer.fromJson<String>(json['fromPub']),
      toPub: serializer.fromJson<String>(json['toPub']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
      'createDate': serializer.toJson<DateTime?>(createDate),
      'fromPub': serializer.toJson<String>(fromPub),
      'toPub': serializer.toJson<String>(toPub),
    };
  }

  Message copyWith(
          {String? content,
          Value<DateTime?> createDate = const Value.absent(),
          String? fromPub,
          String? toPub}) =>
      Message(
        content: content ?? this.content,
        createDate: createDate.present ? createDate.value : this.createDate,
        fromPub: fromPub ?? this.fromPub,
        toPub: toPub ?? this.toPub,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('content: $content, ')
          ..write('createDate: $createDate, ')
          ..write('fromPub: $fromPub, ')
          ..write('toPub: $toPub')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(content, createDate, fromPub, toPub);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.content == this.content &&
          other.createDate == this.createDate &&
          other.fromPub == this.fromPub &&
          other.toPub == this.toPub);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> content;
  final Value<DateTime?> createDate;
  final Value<String> fromPub;
  final Value<String> toPub;
  final Value<int> rowid;
  const MessagesCompanion({
    this.content = const Value.absent(),
    this.createDate = const Value.absent(),
    this.fromPub = const Value.absent(),
    this.toPub = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String content,
    this.createDate = const Value.absent(),
    required String fromPub,
    required String toPub,
    this.rowid = const Value.absent(),
  })  : content = Value(content),
        fromPub = Value(fromPub),
        toPub = Value(toPub);
  static Insertable<Message> custom({
    Expression<String>? content,
    Expression<DateTime>? createDate,
    Expression<String>? fromPub,
    Expression<String>? toPub,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (createDate != null) 'create_date': createDate,
      if (fromPub != null) 'from_pub': fromPub,
      if (toPub != null) 'to_pub': toPub,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith(
      {Value<String>? content,
      Value<DateTime?>? createDate,
      Value<String>? fromPub,
      Value<String>? toPub,
      Value<int>? rowid}) {
    return MessagesCompanion(
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      fromPub: fromPub ?? this.fromPub,
      toPub: toPub ?? this.toPub,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    if (fromPub.present) {
      map['from_pub'] = Variable<String>(fromPub.value);
    }
    if (toPub.present) {
      map['to_pub'] = Variable<String>(toPub.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('content: $content, ')
          ..write('createDate: $createDate, ')
          ..write('fromPub: $fromPub, ')
          ..write('toPub: $toPub, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ChatsTable chats = $ChatsTable(this);
  late final Index chatsPub =
      Index('chats_pub', 'CREATE INDEX chats_pub ON chats (pub)');
  late final $MessagesTable messages = $MessagesTable(this);
  late final Index messagesIndex = Index('messages_index',
      'CREATE INDEX messages_index ON messages (from_pub, to_pub)');
  Future<int> deleteChat(String pub) {
    return customUpdate(
      'DELETE FROM chats WHERE pub = ?1',
      variables: [Variable<String>(pub)],
      updates: {chats},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteMessages(String chatPub, String myPub) {
    return customUpdate(
      'DELETE FROM messages WHERE(from_pub = ?1 AND to_pub = ?2)OR(from_pub = ?2 AND to_pub = ?1)',
      variables: [Variable<String>(chatPub), Variable<String>(myPub)],
      updates: {messages},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<Message> selectMessages(String chatPub, String myPub) {
    return customSelect(
        'SELECT * FROM messages WHERE(from_pub = ?1 AND to_pub = ?2)OR(from_pub = ?2 AND to_pub = ?1)ORDER BY create_date DESC',
        variables: [
          Variable<String>(chatPub),
          Variable<String>(myPub)
        ],
        readsFrom: {
          messages,
        }).asyncMap(messages.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chats, chatsPub, messages, messagesIndex];
}
