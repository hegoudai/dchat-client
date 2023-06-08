import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/models/dchat_user.dart';
import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../utils/crypto_utils.dart';

class EncryptedMessage extends Message {
  String iv;
  String signature;
  String authority;
  EncryptedMessage(
      {required super.content,
      required super.fromPub,
      required super.toPub,
      required this.iv,
      required this.signature,
      required this.authority});

  factory EncryptedMessage.fromJson(Map<String, dynamic> json) {
    return EncryptedMessage(
        content: json['content'],
        fromPub: json['fromPub'],
        toPub: json['toPub'],
        iv: json['iv'],
        signature: json['signature'],
        authority: json['authority']);
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) =>
      <String, dynamic>{
        'content': content,
        'createDate': createDate,
        'fromPub': fromPub,
        'toPub': toPub,
        'iv': iv,
        'signature': signature,
        'authority': authority
      };

  // encrypt message
  factory EncryptedMessage.fromMessage(Message message, DChatUser user) {
    var ecPub = ecPubFromBytes(base64Url.decode(message.toPub));
    var sessionKey =
        (ECDHBasicAgreement()..init(user.ecPriv)).calculateAgreement(ecPub);
    // key derive from ecdh
    var key = CryptoUtils.getHashPlain(
        Uint8List.fromList(sessionKey.toRadixString(16).codeUnits));
    // message random iv
    var iv = CryptoUtils.getSecureRandom().nextBytes(16);
    var paddedText = CryptoUtils.addPKCS7Padding(
        Uint8List.fromList(utf8.encode(message.content)), 16);
    var encryptedContent = HexUtils.encode(aesCbcEncrypt(key, iv, paddedText));
    var sig = CryptoUtils.ecSignatureToBase64(CryptoUtils.ecSign(
        user.ecPriv,
        CryptoUtils.getHashPlain(
            Uint8List.fromList(utf8.encode(encryptedContent)))));
    return EncryptedMessage(
        content: encryptedContent,
        fromPub: message.fromPub,
        toPub: message.toPub,
        iv: HexUtils.encode(iv),
        signature: sig,
        authority: user.authority!);
  }

  // decrypt message
  Message toMessage(ECPrivateKey ecPriv) {
    var sessionKey = (ECDHBasicAgreement()..init(ecPriv))
        .calculateAgreement(ecPubFromBytes(base64Url.decode(fromPub)));
    var key = CryptoUtils.getHashPlain(
        Uint8List.fromList(sessionKey.toRadixString(16).codeUnits));
    var ivBytes = HexUtils.decode(iv);
    var rawContent = utf8.decode(CryptoUtils.removePKCS7Padding(
        aesCbcDecrypt(key, ivBytes, HexUtils.decode(content))));
    return Message(
        content: rawContent,
        fromPub: fromPub,
        toPub: toPub,
        createDate: DateTime.now());
  }
}
