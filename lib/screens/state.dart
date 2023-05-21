import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/db/prefs.dart';
import 'package:dchat_client/models/address_infos.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';

final chatsProvider = StreamProvider<List<Chat>>((ref) {
  final database = ref.watch(AppDatabase.provider);
  return database.select(database.chats).watch();
});

final messagesProvider =
    StreamProvider.family.autoDispose<List<Message>, String>((ref, address) {
  final database = ref.watch(AppDatabase.provider);
  final myAddress = ref.watch(myAddressInfoProvider).toAddress();
  return (database.select(database.messages)
        ..where((tbl) =>
            (tbl.fromAddress.equals(address) &
                tbl.toAddress.equals(myAddress)) |
            (tbl.fromAddress.equals(myAddress) &
                tbl.toAddress.equals(address))))
      .watch();
});

final serverProvider = Provider<String?>((ref) {
  final prefs = ref.watch(prefsProvider);
  return prefs.getString('server');
});

final myAddressInfoProvider = Provider<AddressInfos>((ref) {
  final prefs = ref.watch(prefsProvider);
  final ecPrivPem = prefs.getString('ecPrivPem');
  final server = ref.watch(serverProvider);
  if (ecPrivPem != null) {
    // get ec pair from prefs
    var priv = CryptoUtils.ecPrivateKeyFromPem(ecPrivPem);
    var params = ECDomainParameters('secp128r2');
    var pub = ECPublicKey(params.G * priv.d, params);
    return AddressInfos(server, priv, pub);
  } else {
    // init ec key pair and save
    final pair = CryptoUtils.generateEcKeyPair(curve: 'secp128r2');
    prefs.setString('ecPrivPem',
        CryptoUtils.encodeEcPrivateKeyToPem(pair.privateKey as ECPrivateKey));
    return AddressInfos(
        server, pair.privateKey as ECPrivateKey, pair.publicKey as ECPublicKey);
  }
});
