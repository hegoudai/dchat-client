import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/utils/crypto_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test aes-cbc', () {
    var key = CryptoUtils.getHashPlain(
        Uint8List.fromList(BigInt.from(11111).toRadixString(16).codeUnits));
    var iv = CryptoUtils.getSecureRandom().nextBytes(16);
    var message = 'I am a test message ,wuwuwuwuwuuwuwuwuwuwu';
    var encryptedMessage = aesCbcEncrypt(key, iv,
        CryptoUtils.addPKCS7Padding(Uint8List.fromList(message.codeUnits), 16));

    var decryptedMessage = String.fromCharCodes(CryptoUtils.removePKCS7Padding(
        aesCbcDecrypt(key, iv, encryptedMessage)));
    print(decryptedMessage);
    expect(decryptedMessage, equals(message));
  });
}
