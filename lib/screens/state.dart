import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/db/prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';

final chatsProvider = StreamProvider<List<Chat>>((ref) {
  final database = ref.watch(AppDatabase.provider);
  return database.select(database.chats).watch();
});

final serverProvider = Provider<String?>((ref) {
  final prefs = ref.watch(prefsProvider);
  return prefs.getString('server');
});

final ecKeyPairProvider = Provider<AsymmetricKeyPair>((ref) {
  final prefs = ref.watch(prefsProvider);
  final ecPrivPem = prefs.getString('ecPrivPem');
  if (ecPrivPem != null) {
    // get ec pair from prefs
    var priv = CryptoUtils.ecPrivateKeyFromPem(ecPrivPem);
    var params = ECDomainParameters('secp128r2');
    var pub = ECPublicKey(params.G * priv.d, params);
    return AsymmetricKeyPair(pub, priv);
  } else {
    // init ec key pair and save
    final pair = CryptoUtils.generateEcKeyPair(curve: 'secp128r2');
    prefs.setString('ecPrivPem',
        CryptoUtils.encodeEcPrivateKeyToPem(pair.privateKey as ECPrivateKey));
    return pair;
  }
});
