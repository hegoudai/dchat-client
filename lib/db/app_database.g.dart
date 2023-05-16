// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _fromAddressMeta =
      const VerificationMeta('fromAddress');
  @override
  late final GeneratedColumn<String> fromAddress = GeneratedColumn<String>(
      'from_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toAddressMeta =
      const VerificationMeta('toAddress');
  @override
  late final GeneratedColumn<String> toAddress = GeneratedColumn<String>(
      'to_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [content, createDate, fromAddress, toAddress];
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
    if (data.containsKey('from_address')) {
      context.handle(
          _fromAddressMeta,
          fromAddress.isAcceptableOrUnknown(
              data['from_address']!, _fromAddressMeta));
    } else if (isInserting) {
      context.missing(_fromAddressMeta);
    }
    if (data.containsKey('to_address')) {
      context.handle(_toAddressMeta,
          toAddress.isAcceptableOrUnknown(data['to_address']!, _toAddressMeta));
    } else if (isInserting) {
      context.missing(_toAddressMeta);
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
      fromAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_address'])!,
      toAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_address'])!,
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
  final String fromAddress;
  final String toAddress;
  const Message(
      {required this.content,
      this.createDate,
      required this.fromAddress,
      required this.toAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || createDate != null) {
      map['create_date'] = Variable<DateTime>(createDate);
    }
    map['from_address'] = Variable<String>(fromAddress);
    map['to_address'] = Variable<String>(toAddress);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      content: Value(content),
      createDate: createDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createDate),
      fromAddress: Value(fromAddress),
      toAddress: Value(toAddress),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      content: serializer.fromJson<String>(json['content']),
      createDate: serializer.fromJson<DateTime?>(json['createDate']),
      fromAddress: serializer.fromJson<String>(json['fromAddress']),
      toAddress: serializer.fromJson<String>(json['toAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
      'createDate': serializer.toJson<DateTime?>(createDate),
      'fromAddress': serializer.toJson<String>(fromAddress),
      'toAddress': serializer.toJson<String>(toAddress),
    };
  }

  Message copyWith(
          {String? content,
          Value<DateTime?> createDate = const Value.absent(),
          String? fromAddress,
          String? toAddress}) =>
      Message(
        content: content ?? this.content,
        createDate: createDate.present ? createDate.value : this.createDate,
        fromAddress: fromAddress ?? this.fromAddress,
        toAddress: toAddress ?? this.toAddress,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('content: $content, ')
          ..write('createDate: $createDate, ')
          ..write('fromAddress: $fromAddress, ')
          ..write('toAddress: $toAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(content, createDate, fromAddress, toAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.content == this.content &&
          other.createDate == this.createDate &&
          other.fromAddress == this.fromAddress &&
          other.toAddress == this.toAddress);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> content;
  final Value<DateTime?> createDate;
  final Value<String> fromAddress;
  final Value<String> toAddress;
  final Value<int> rowid;
  const MessagesCompanion({
    this.content = const Value.absent(),
    this.createDate = const Value.absent(),
    this.fromAddress = const Value.absent(),
    this.toAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String content,
    this.createDate = const Value.absent(),
    required String fromAddress,
    required String toAddress,
    this.rowid = const Value.absent(),
  })  : content = Value(content),
        fromAddress = Value(fromAddress),
        toAddress = Value(toAddress);
  static Insertable<Message> custom({
    Expression<String>? content,
    Expression<DateTime>? createDate,
    Expression<String>? fromAddress,
    Expression<String>? toAddress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (createDate != null) 'create_date': createDate,
      if (fromAddress != null) 'from_address': fromAddress,
      if (toAddress != null) 'to_address': toAddress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith(
      {Value<String>? content,
      Value<DateTime?>? createDate,
      Value<String>? fromAddress,
      Value<String>? toAddress,
      Value<int>? rowid}) {
    return MessagesCompanion(
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      fromAddress: fromAddress ?? this.fromAddress,
      toAddress: toAddress ?? this.toAddress,
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
    if (fromAddress.present) {
      map['from_address'] = Variable<String>(fromAddress.value);
    }
    if (toAddress.present) {
      map['to_address'] = Variable<String>(toAddress.value);
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
          ..write('fromAddress: $fromAddress, ')
          ..write('toAddress: $toAddress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [address];
  @override
  String get aliasedName => _alias ?? 'chats';
  @override
  String get actualTableName => 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final String address;
  const Chat({required this.address});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['address'] = Variable<String>(address);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      address: Value(address),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'address': serializer.toJson<String>(address),
    };
  }

  Chat copyWith({String? address}) => Chat(
        address: address ?? this.address,
      );
  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => address.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat && other.address == this.address);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> address;
  final Value<int> rowid;
  const ChatsCompanion({
    this.address = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String address,
    this.rowid = const Value.absent(),
  }) : address = Value(address);
  static Insertable<Chat> custom({
    Expression<String>? address,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (address != null) 'address': address,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith({Value<String>? address, Value<int>? rowid}) {
    return ChatsCompanion(
      address: address ?? this.address,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('address: $address, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [messages, chats];
}
