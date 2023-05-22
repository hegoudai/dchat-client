import 'dart:convert';
import 'dart:io';
import 'package:dchat_client/models/address_infos.dart';
import 'package:dchat_client/models/message_encrypted.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String? _token;

  AddressInfos localInfos;

  ApiServices(this.localInfos);

  Future<String?> get token async {
    return _token ?? await login();
  }

  Future<String?> login() async {
    http.Response response = await http.post(
        Uri.parse('http://${localInfos.server}/login'),
        // todo better method
        body: EncryptedMessage(
                content: 'login',
                fromAddress: localInfos.toAddress(),
                toAddress: '',
                iv: '',
                signature: '')
            .toJsonString(),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      _token = "Bearer ${jsonDecode(response.body)['token']}";
      return _token;
    }

    return null;
  }

  Future<http.Response> send(String toServer, EncryptedMessage message) async {
    // todo encrypt the message and add signature
    return await http.post(Uri.parse('http://$toServer/message/send'),
        body: message.toJsonString(),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  }
}

final apiServicesProvider = Provider<ApiServices?>((ref) {
  final localInfos = ref.watch(myAddressInfoProvider);
  return ApiServices(localInfos);
});
