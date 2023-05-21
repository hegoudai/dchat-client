import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as ecc_fp;

// copy from basic_utils
BigInt _decodeBigIntWithSign(int sign, List<int> magnitude) {
  if (sign == 0) {
    return BigInt.zero;
  }

  BigInt result;

  if (magnitude.length == 1) {
    result = BigInt.from(magnitude[0]);
  } else {
    result = BigInt.from(0);
    for (var i = 0; i < magnitude.length; i++) {
      var item = magnitude[magnitude.length - i - 1];
      result |= (BigInt.from(item) << (8 * i));
    }
  }

  if (result != BigInt.zero) {
    if (sign < 0) {
      result = result.toSigned(result.bitLength);
    } else {
      result = result.toUnsigned(result.bitLength);
    }
  }
  return result;
}

// pub point bytes to pub key
ECPublicKey ecPubFromBytes(Uint8List pubBytes) {
  if (pubBytes.elementAt(0) == 0) {
    pubBytes = pubBytes.sublist(1);
  }
  var x = pubBytes.sublist(1, (pubBytes.length / 2).round());
  var y = pubBytes.sublist(1 + x.length, pubBytes.length);
  var params = ECDomainParameters('secp128r2');
  var bigX = _decodeBigIntWithSign(1, x);
  var bigY = _decodeBigIntWithSign(1, y);
  return ECPublicKey(
      ecc_fp.ECPoint(
          params.curve as ecc_fp.ECCurve,
          params.curve.fromBigInteger(bigX) as ecc_fp.ECFieldElement?,
          params.curve.fromBigInteger(bigY) as ecc_fp.ECFieldElement?,
          false),
      params);
}

// encrypt data by aes, copy from pc-dart example
Uint8List aesCbcEncrypt(
    Uint8List key, Uint8List iv, Uint8List paddedPlaintext) {
  assert([128, 192, 256].contains(key.length * 8));
  assert(128 == iv.length * 8);
  assert(0 == paddedPlaintext.length % 16);

  // Create a CBC block cipher with AES, and initialize with key and IV

  final cbc = CBCBlockCipher(AESEngine())
    ..init(true, ParametersWithIV(KeyParameter(key), iv)); // true=encrypt

  // Encrypt the plaintext block-by-block

  final cipherText = Uint8List(paddedPlaintext.length); // allocate space

  var offset = 0;
  while (offset < paddedPlaintext.length) {
    offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
  }
  assert(offset == paddedPlaintext.length);

  return cipherText;
}

// decryt data by aes, copy from pc-dart example
Uint8List aesCbcDecrypt(Uint8List key, Uint8List iv, Uint8List cipherText) {
  assert([128, 192, 256].contains(key.length * 8));
  assert(128 == iv.length * 8);
  assert(0 == cipherText.length % 16);

  // Create a CBC block cipher with AES, and initialize with key and IV

  final cbc = CBCBlockCipher(AESEngine())
    ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

  // Decrypt the cipherText block-by-block

  final paddedPlainText = Uint8List(cipherText.length); // allocate space

  var offset = 0;
  while (offset < cipherText.length) {
    offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
  }
  assert(offset == cipherText.length);

  return paddedPlainText;
}
