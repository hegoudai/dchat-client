import 'package:dchat_client/screens/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/chats',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/chats',
        builder: (context, state) => ChatList(),
        routes: <RouteBase>[
          GoRoute(
            path: ':address',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              // todo chat details
              return const Placeholder();
            },
          ),
        ],
      ),
    ],
  );
});
