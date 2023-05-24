import 'dart:convert';

import 'package:pointycastle/ecc/api.dart';

class DChatUser {
  String? authority;
  ECPublicKey ecPub;
  ECPrivateKey ecPriv;

  DChatUser(this.authority, this.ecPriv, this.ecPub);

  String get ecPubString => base64Url.encode(ecPub.Q!.getEncoded(false));

  String get uriString => 'dc://${authority ?? ''}/$ecPubString';
}
