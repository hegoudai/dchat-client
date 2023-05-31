// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
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
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _newestMessageMeta =
      const VerificationMeta('newestMessage');
  @override
  late final GeneratedColumn<String> newestMessage = GeneratedColumn<String>(
      'newest_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unreadCountMeta =
      const VerificationMeta('unreadCount');
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
      'unread_count', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, pub, authority, remark, newestMessage, unreadCount];
  @override
  String get aliasedName => _alias ?? 'chats';
  @override
  String get actualTableName => 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    if (data.containsKey('newest_message')) {
      context.handle(
          _newestMessageMeta,
          newestMessage.isAcceptableOrUnknown(
              data['newest_message']!, _newestMessageMeta));
    }
    if (data.containsKey('unread_count')) {
      context.handle(
          _unreadCountMeta,
          unreadCount.isAcceptableOrUnknown(
              data['unread_count']!, _unreadCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      pub: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pub'])!,
      authority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}authority'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      newestMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}newest_message']),
      unreadCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread_count']),
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final int? id;
  final String pub;
  final String authority;
  final String? remark;
  final String? newestMessage;
  final int? unreadCount;
  const Chat(
      {this.id,
      required this.pub,
      required this.authority,
      this.remark,
      this.newestMessage,
      this.unreadCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['pub'] = Variable<String>(pub);
    map['authority'] = Variable<String>(authority);
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    if (!nullToAbsent || newestMessage != null) {
      map['newest_message'] = Variable<String>(newestMessage);
    }
    if (!nullToAbsent || unreadCount != null) {
      map['unread_count'] = Variable<int>(unreadCount);
    }
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      pub: Value(pub),
      authority: Value(authority),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      newestMessage: newestMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(newestMessage),
      unreadCount: unreadCount == null && nullToAbsent
          ? const Value.absent()
          : Value(unreadCount),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<int?>(json['id']),
      pub: serializer.fromJson<String>(json['pub']),
      authority: serializer.fromJson<String>(json['authority']),
      remark: serializer.fromJson<String?>(json['remark']),
      newestMessage: serializer.fromJson<String?>(json['newestMessage']),
      unreadCount: serializer.fromJson<int?>(json['unreadCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'pub': serializer.toJson<String>(pub),
      'authority': serializer.toJson<String>(authority),
      'remark': serializer.toJson<String?>(remark),
      'newestMessage': serializer.toJson<String?>(newestMessage),
      'unreadCount': serializer.toJson<int?>(unreadCount),
    };
  }

  Chat copyWith(
          {Value<int?> id = const Value.absent(),
          String? pub,
          String? authority,
          Value<String?> remark = const Value.absent(),
          Value<String?> newestMessage = const Value.absent(),
          Value<int?> unreadCount = const Value.absent()}) =>
      Chat(
        id: id.present ? id.value : this.id,
        pub: pub ?? this.pub,
        authority: authority ?? this.authority,
        remark: remark.present ? remark.value : this.remark,
        newestMessage:
            newestMessage.present ? newestMessage.value : this.newestMessage,
        unreadCount: unreadCount.present ? unreadCount.value : this.unreadCount,
      );
  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('pub: $pub, ')
          ..write('authority: $authority, ')
          ..write('remark: $remark, ')
          ..write('newestMessage: $newestMessage, ')
          ..write('unreadCount: $unreadCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pub, authority, remark, newestMessage, unreadCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.pub == this.pub &&
          other.authority == this.authority &&
          other.remark == this.remark &&
          other.newestMessage == this.newestMessage &&
          other.unreadCount == this.unreadCount);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<int?> id;
  final Value<String> pub;
  final Value<String> authority;
  final Value<String?> remark;
  final Value<String?> newestMessage;
  final Value<int?> unreadCount;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.pub = const Value.absent(),
    this.authority = const Value.absent(),
    this.remark = const Value.absent(),
    this.newestMessage = const Value.absent(),
    this.unreadCount = const Value.absent(),
  });
  ChatsCompanion.insert({
    this.id = const Value.absent(),
    required String pub,
    required String authority,
    this.remark = const Value.absent(),
    this.newestMessage = const Value.absent(),
    this.unreadCount = const Value.absent(),
  })  : pub = Value(pub),
        authority = Value(authority);
  static Insertable<Chat> custom({
    Expression<int>? id,
    Expression<String>? pub,
    Expression<String>? authority,
    Expression<String>? remark,
    Expression<String>? newestMessage,
    Expression<int>? unreadCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pub != null) 'pub': pub,
      if (authority != null) 'authority': authority,
      if (remark != null) 'remark': remark,
      if (newestMessage != null) 'newest_message': newestMessage,
      if (unreadCount != null) 'unread_count': unreadCount,
    });
  }

  ChatsCompanion copyWith(
      {Value<int?>? id,
      Value<String>? pub,
      Value<String>? authority,
      Value<String?>? remark,
      Value<String?>? newestMessage,
      Value<int?>? unreadCount}) {
    return ChatsCompanion(
      id: id ?? this.id,
      pub: pub ?? this.pub,
      authority: authority ?? this.authority,
      remark: remark ?? this.remark,
      newestMessage: newestMessage ?? this.newestMessage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pub.present) {
      map['pub'] = Variable<String>(pub.value);
    }
    if (authority.present) {
      map['authority'] = Variable<String>(authority.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (newestMessage.present) {
      map['newest_message'] = Variable<String>(newestMessage.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('pub: $pub, ')
          ..write('authority: $authority, ')
          ..write('remark: $remark, ')
          ..write('newestMessage: $newestMessage, ')
          ..write('unreadCount: $unreadCount')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
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
  List<GeneratedColumn> get $columns =>
      [id, content, createDate, fromPub, toPub];
  @override
  String get aliasedName => _alias ?? 'messages';
  @override
  String get actualTableName => 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  final int? id;
  final String content;
  final DateTime? createDate;
  final String fromPub;
  final String toPub;
  const Message(
      {this.id,
      required this.content,
      this.createDate,
      required this.fromPub,
      required this.toPub});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
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
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
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
      id: serializer.fromJson<int?>(json['id']),
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
      'id': serializer.toJson<int?>(id),
      'content': serializer.toJson<String>(content),
      'createDate': serializer.toJson<DateTime?>(createDate),
      'fromPub': serializer.toJson<String>(fromPub),
      'toPub': serializer.toJson<String>(toPub),
    };
  }

  Message copyWith(
          {Value<int?> id = const Value.absent(),
          String? content,
          Value<DateTime?> createDate = const Value.absent(),
          String? fromPub,
          String? toPub}) =>
      Message(
        id: id.present ? id.value : this.id,
        content: content ?? this.content,
        createDate: createDate.present ? createDate.value : this.createDate,
        fromPub: fromPub ?? this.fromPub,
        toPub: toPub ?? this.toPub,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createDate: $createDate, ')
          ..write('fromPub: $fromPub, ')
          ..write('toPub: $toPub')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, createDate, fromPub, toPub);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.content == this.content &&
          other.createDate == this.createDate &&
          other.fromPub == this.fromPub &&
          other.toPub == this.toPub);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int?> id;
  final Value<String> content;
  final Value<DateTime?> createDate;
  final Value<String> fromPub;
  final Value<String> toPub;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.createDate = const Value.absent(),
    this.fromPub = const Value.absent(),
    this.toPub = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.createDate = const Value.absent(),
    required String fromPub,
    required String toPub,
  })  : content = Value(content),
        fromPub = Value(fromPub),
        toPub = Value(toPub);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<DateTime>? createDate,
    Expression<String>? fromPub,
    Expression<String>? toPub,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (createDate != null) 'create_date': createDate,
      if (fromPub != null) 'from_pub': fromPub,
      if (toPub != null) 'to_pub': toPub,
    });
  }

  MessagesCompanion copyWith(
      {Value<int?>? id,
      Value<String>? content,
      Value<DateTime?>? createDate,
      Value<String>? fromPub,
      Value<String>? toPub}) {
    return MessagesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      fromPub: fromPub ?? this.fromPub,
      toPub: toPub ?? this.toPub,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createDate: $createDate, ')
          ..write('fromPub: $fromPub, ')
          ..write('toPub: $toPub')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ChatsTable chats = $ChatsTable(this);
  late final Index chatsIndex =
      Index('chats_index', 'CREATE UNIQUE INDEX chats_index ON chats (pub)');
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

  Future<int> insertOrReplaceChat(
      String pub, String authority, String newestMessage) {
    return customInsert(
      'REPLACE INTO chats (pub, authority, newest_message, unread_count, remark) VALUES (?1, ?2, ?3, COALESCE((SELECT unread_count + 1 FROM chats WHERE pub = ?1), 0), (SELECT remark FROM chats WHERE pub = ?1))',
      variables: [
        Variable<String>(pub),
        Variable<String>(authority),
        Variable<String>(newestMessage)
      ],
      updates: {chats},
    );
  }

  Future<int> readChat(String pub) {
    return customUpdate(
      'UPDATE chats SET unread_count = 0 WHERE pub = ?1',
      variables: [Variable<String>(pub)],
      updates: {chats},
      updateKind: UpdateKind.update,
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
        'SELECT * FROM messages WHERE(from_pub = ?1 AND to_pub = ?2)OR(from_pub = ?2 AND to_pub = ?1)ORDER BY id DESC',
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
      [chats, chatsIndex, messages, messagesIndex];
}
