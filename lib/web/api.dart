import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/models/dchat_user.dart';
import 'package:dchat_client/models/message_encrypted.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:otp/otp.dart';

class ApiServices {
  String? _token;

  DChatUser user;

  ApiServices(this.user);

  // api header
  Map<String, String> commonHeader = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  Future<String?> get token async {
    return _token ?? await login();
  }

  Future<String?> login() async {
    // opt derive by ecPub
    var otp = OTP.generateTOTPCodeString(
        user.ecPubString, DateTime.now().millisecondsSinceEpoch,
        interval: 22);
    // sign opt for server to validate
    var otpSign = CryptoUtils.ecSignatureToBase64(
        CryptoUtils.ecSign(user.ecPriv, Uint8List.fromList(otp.codeUnits)));
    http.Response response = await http.post(
        Uri.parse('http://${user.authority}/login'),
        body: EncryptedMessage(
                content: 'login',
                fromPub: user.ecPubString,
                toPub: '',
                iv: '',
                signature: otpSign,
                authority: '')
            .toJsonString(),
        headers: commonHeader);
    if (response.statusCode == 200) {
      _token = "Bearer ${jsonDecode(response.body)['token']}";
      return _token;
    }

    return null;
  }

  Future<http.Response> send(String toServer, EncryptedMessage message) async {
    // todo handle response
    return await http.post(Uri.parse('http://$toServer/message/send'),
        body: message.toJsonString(), headers: commonHeader);
  }
}

final apiServicesProvider = Provider<ApiServices?>((ref) {
  final user = ref.watch(myInfosProvider);
  if (user.authority == null) {
    return null;
  }
  return ApiServices(user);
});
