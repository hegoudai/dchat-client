import 'package:dchat_client/web/api.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final wsChannelProvider = FutureProvider<WebSocketChannel>((ref) async {
  final api = ref.watch(apiServicesProvider);
  if (api == null) {
    throw 'User server is empty';
  }

  final token = await api.token;
  // open the connection
  final channel = WebSocketChannel.connect(
      Uri.parse('ws://${api.user.authority}/chat?token=$token'));

  ref.onDispose(() => channel.sink.close());
  return channel;
});
