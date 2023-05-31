import 'dart:io';

import 'package:dchat_client/db/app_database.dart';
import 'package:dchat_client/screens/chat_detail.dart';
import 'package:dchat_client/screens/chats.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final deepLinkProvider = StreamProvider<Uri?>((ref) {
  if (!kIsWeb) {
    if (Platform.isAndroid | Platform.isIOS) {
      // deep link only supported android and ios
      return uriLinkStream;
    }
  }
  return const Stream.empty();
});

final routerProvider = Provider<GoRouter>((ref) {
  var isDlHandled = false;
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final dlUri = ref.watch(deepLinkProvider).value;
      if (dlUri == null) {
        return null;
      }
      if (isDlHandled) {
        return null;
      }
      // handle dlUri
      isDlHandled = true;
      final db = ref.watch(AppDatabase.provider);
      db.into(db.chats).insert(
          ChatsCompanion.insert(
              pub: dlUri.pathSegments[0], authority: dlUri.authority),
          mode: InsertMode.insertOrIgnore);
      return '/${dlUri.pathSegments[0]}?authority=${dlUri.authority}';
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const Chats(),
        routes: <RouteBase>[
          GoRoute(
            path: ':pub',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return ChatDetail(
                chat: Chat(
                    pub: state.pathParameters['pub']!,
                    authority: state.queryParameters['authority']!),
              );
            },
          ),
        ],
      ),
    ],
  );
});
