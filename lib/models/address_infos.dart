import 'dart:convert';

import 'package:dchat_client/utils/crypto_utils.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/ecc/api.dart';

class AddressInfos {
  String? server;
  ECPublicKey ecPub;
  ECPrivateKey? ecPriv;

  AddressInfos(this.server, this.ecPriv, this.ecPub);

  factory AddressInfos.fromAdress(String address) {
    var result = ASN1Parser(base64Url.decode(address));
    var topSeq = result.nextObject() as ASN1Sequence;
    var toServer = topSeq.elements![0] as ASN1UTF8String;
    var pubBitStr = topSeq.elements![1] as ASN1BitString;
    var pubRecover = ecPubFromBytes(pubBitStr.valueBytes!);
    return AddressInfos(toServer.utf8StringValue, null, pubRecover);
  }

  String toAddress() {
    var outer = ASN1Sequence();
    outer.add(ASN1UTF8String(utf8StringValue: server ?? ' '));
    outer.add(ASN1BitString(stringValues: ecPub.Q!.getEncoded(false)));
    return base64Url.encode(outer.encode());
  }
}
