import 'package:dchat_client/web/api.dart';
import 'package:dchat_client/web/websocket_manager.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
