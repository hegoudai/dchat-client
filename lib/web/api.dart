import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:dchat_client/models/local_infos.dart';
import 'package:dchat_client/screens/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../db/app_database.dart';

class ApiServices {
  String? _token;

  LocalInfos localInfos;

  ApiServices(this.localInfos);

  Future<String?> get token async {
    return _token ?? await login();
  }

  Future<String?> login() async {
    http.Response response =
        await http.post(Uri.parse('http://${localInfos.server}/login'),
            body: jsonEncode({
              'address': localInfos.myAddress,
              'signature': CryptoUtils.ecSignatureToBase64(CryptoUtils.ecSign(
                  localInfos.ecPriv,
                  Uint8List.fromList(localInfos.myAddress!.codeUnits)))
            }),
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      _token = "Bearer ${jsonDecode(response.body)['token']}";
      return _token;
    }

    return null;
  }

  Future<http.Response> send(String toServer, Message message) async {
    // todo encrypt the message and add signature
    return await http.post(Uri.parse('http://$toServer/message/send'),
        body: message.toJsonString(),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  }
}

final apiServicesProvider = Provider<ApiServices?>((ref) {
  final localInfos = ref.watch(localInfoProvider);
  return ApiServices(localInfos);
});
