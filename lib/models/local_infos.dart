import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';

class LocalInfos {
  String? server;
  AsymmetricKeyPair keyPair;

  LocalInfos(this.server, this.keyPair);

  String? get myAddress {
    if (server == null) return null;
    var ecPub = keyPair.publicKey as ECPublicKey;
    var addressMap = {
      's': server,
      'p': base64Url.encode(ecPub.Q!.getEncoded(false))
    };
    return base64Url.encode(jsonEncode(addressMap).codeUnits);
  }

  ECPublicKey get ecPub => keyPair.publicKey as ECPublicKey;
  ECPrivateKey get ecPriv => keyPair.privateKey as ECPrivateKey;
}
