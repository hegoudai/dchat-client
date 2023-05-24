import 'dart:convert';
import 'dart:io';
import 'package:dchat_client/models/dchat_user.dart';
import 'package:dchat_client/models/message_encrypted.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
    http.Response response = await http.post(
        Uri.parse('http://${user.authority}/login'),
        // todo better method
        body: EncryptedMessage(
                content: 'login',
                fromPub: user.ecPubString,
                toPub: '',
                iv: '',
                signature: '',
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
    // todo encrypt the message and add signature
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
