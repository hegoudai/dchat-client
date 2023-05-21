import 'dart:convert';
import 'dart:developer';

import 'package:dchat_client/models/message_encrypted.dart';
import 'package:dchat_client/web/api.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../db/app_database.dart';
import '../screens/state.dart';

// handle ws channel message
final wsMessageHandler = Provider<void>((ref) async {
  final api = ref.watch(apiServicesProvider);
  if (api == null) {
    return;
  }

  final token = await api.token;
  // open the connection
  final channel = WebSocketChannel.connect(
      Uri.parse('ws://${api.localInfos.server}/chat?token=$token'));

  // change ws state when ready
  channel.ready
      .whenComplete(() => ref.read(wsStateProvider.notifier).state = true);

  // close channel on dispose
  ref.onDispose(() => channel.sink.close());

  // handle channel events
  channel.stream.listen(
    (event) {
      final value = event.toString();
      log('received value: $value');
      // write message to db
      final encryptedMessage = EncryptedMessage.fromJson(jsonDecode(value));
      final database = ref.watch(AppDatabase.provider);

      final chat = Chat(address: encryptedMessage.fromAddress);

      var myAddressInfos = ref.watch(myAddressInfoProvider);

      database
          .into(database.chats)
          .insert(chat, mode: InsertMode.insertOrIgnore);
      database
          .into(database.messages)
          .insert(encryptedMessage.toMessage(myAddressInfos.ecPriv!));
    },
    onError: (e) {
      log('error while listening ws: $e');
    },
    onDone: () {
      log('ws done');
      ref.read(wsStateProvider.notifier).state = false;
    },
  );
});

final wsStateProvider = StateProvider<bool>((_) => false);
