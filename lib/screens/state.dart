import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/db/prefs.dart';
import 'package:dchat_client/models/dchat_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';

final chatsProvider = StreamProvider<List<Chat>>((ref) {
  final database = ref.watch(AppDatabase.provider);
  return database.select(database.chats).watch();
});

final messagesProvider =
    StreamProvider.family.autoDispose<List<Message>, String>((ref, pub) {
  final database = ref.watch(AppDatabase.provider);
  final myPub = ref.watch(myInfosProvider).ecPubString;
  // todo page query
  return database.selectMessages(pub, myPub).watch();
});

final myAuthorityProvider = Provider<String?>((ref) {
  final prefs = ref.watch(prefsProvider);
  return prefs.getString('authority');
});

final myInfosProvider = Provider<DChatUser>((ref) {
  final prefs = ref.watch(prefsProvider);
  final ecPrivPem = prefs.getString('ecPrivPem');
  final authority = ref.watch(myAuthorityProvider);
  if (ecPrivPem != null) {
    // get ec pair from prefs
    var priv = CryptoUtils.ecPrivateKeyFromPem(ecPrivPem);
    var params = ECDomainParameters('secp128r2');
    var pub = ECPublicKey(params.G * priv.d, params);
    return DChatUser(authority, priv, pub);
  } else {
    // init ec key pair and save
    final pair = CryptoUtils.generateEcKeyPair(curve: 'secp128r2');
    prefs.setString('ecPrivPem',
        CryptoUtils.encodeEcPrivateKeyToPem(pair.privateKey as ECPrivateKey));
    return DChatUser(authority, pair.privateKey as ECPrivateKey,
        pair.publicKey as ECPublicKey);
  }
});

// websocket connect state
final wsStateProvider = StateProvider<bool>((_) => true);
