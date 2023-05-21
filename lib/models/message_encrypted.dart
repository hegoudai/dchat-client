import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/models/address_infos.dart';
import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../utils/crypto_utils.dart';

class EncryptedMessage extends Message {
  String iv;
  String signature;
  EncryptedMessage(
      {required super.content,
      required super.fromAddress,
      required super.toAddress,
      required this.iv,
      required this.signature});

  factory EncryptedMessage.fromJson(Map<String, dynamic> json) {
    return EncryptedMessage(
        content: json['content'],
        fromAddress: json['fromAddress'],
        toAddress: json['toAddress'],
        iv: json['iv'],
        signature: json['signature']);
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) =>
      <String, dynamic>{
        'content': content,
        'createDate': createDate,
        'fromAddress': fromAddress,
        'toAddress': toAddress,
        'iv': iv,
        'signature': signature
      };

  // encrypt message
  factory EncryptedMessage.fromMessage(Message message, ECPrivateKey ecPriv) {
    var toInfos = AddressInfos.fromAdress(message.toAddress);
    // todo extract this to some other place
    var sessionKey =
        (ECDHBasicAgreement()..init(ecPriv)).calculateAgreement(toInfos.ecPub);
    // key derive from ecdh
    var key = CryptoUtils.getHashPlain(
        Uint8List.fromList(sessionKey.toRadixString(16).codeUnits));
    // message random iv
    var iv = CryptoUtils.getSecureRandom().nextBytes(16);
    var paddedText = CryptoUtils.addPKCS7Padding(
        Uint8List.fromList(utf8.encode(message.content)), 16);
    var encryptedContent = aesCbcEncrypt(key, iv, paddedText);
    var sig = CryptoUtils.ecSignatureToBase64(
        CryptoUtils.ecSign(ecPriv, CryptoUtils.getHashPlain(encryptedContent)));
    return EncryptedMessage(
        content: HexUtils.encode(encryptedContent),
        fromAddress: message.fromAddress,
        toAddress: message.toAddress,
        iv: HexUtils.encode(iv),
        signature: sig);
  }

  // decrypt message
  Message toMessage(ECPrivateKey ecPriv) {
    var fromInfos = AddressInfos.fromAdress(fromAddress);
    var sessionKey = (ECDHBasicAgreement()..init(ecPriv))
        .calculateAgreement(fromInfos.ecPub);
    var key = CryptoUtils.getHashPlain(
        Uint8List.fromList(sessionKey.toRadixString(16).codeUnits));
    var ivBytes = HexUtils.decode(iv);
    var rawContent = utf8.decode(CryptoUtils.removePKCS7Padding(
        aesCbcDecrypt(key, ivBytes, HexUtils.decode(content))));
    return Message(
        content: rawContent, fromAddress: fromAddress, toAddress: toAddress);
  }
}
