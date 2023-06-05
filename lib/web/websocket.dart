import 'package:dchat_client/web/api.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager extends StateNotifier<bool> {
  WebSocketChannel? _webSocket;
  final List<String> _buffer = [];
  ApiServices? _apiServices;

  WebSocketManager(super.state);

  Future<void> send(String message) async {
    if (_webSocket != null && state) {
      _webSocket!.sink.add(message);
    } else {
      throw 'The WebSocketManager is trying to send a message, but the connection is not open.';
    }
  }

  Future<void> openWebSocketConnection(ApiServices apiServices) async {
    if (state) {
      return;
    }
    _apiServices = apiServices;
    final token = await apiServices.token;
    try {
      _webSocket = WebSocketChannel.connect(
          Uri.parse('ws://${apiServices.user.authority}/chat?token=$token'));
      _webSocket?.ready.then((value) => state = true);
      _webSocket!.stream.listen(
        (data) {
          _buffer.add(data);
        },
        onDone: () {
          state = false;
        },
        onError: (error) {
          state = false;
        },
      );
    } catch (e) {
      state = false;
    }
  }

  void reConnect() {
    if (_apiServices == null || state) {
      return;
    }
    openWebSocketConnection(_apiServices!);
  }

  void closeWebSocketConnection() {
    _webSocket?.sink.close();
    state = false;
  }

  List<String> fetchData() {
    if (!state) {
      // try reconnect if not connected
      reConnect();
      return [];
    }

    List<String> fetchedData = List<String>.from(_buffer);
    _buffer.clear();
    return fetchedData;
  }
}

final wsManagerProvider = StateNotifierProvider<WebSocketManager, bool>((ref) {
  final api = ref.watch(apiServicesProvider);
  if (api == null) {
    return WebSocketManager(false);
  }

  // open the connection
  final wsManager = WebSocketManager(false);
  wsManager.openWebSocketConnection(api);
  ref.onDispose(() => wsManager.closeWebSocketConnection());
  return wsManager;
});
