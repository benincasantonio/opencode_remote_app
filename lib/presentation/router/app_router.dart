import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/providers/connection_providers.dart';
import '../screens/connect/connect_screen.dart';
import '../screens/home/home_screen.dart';

part 'app_router.g.dart';

/// Path for the connect screen (initial location when disconnected).
const connectPath = '/connect';

/// Path for the home dashboard after a successful connect.
const homePath = '/home';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(isConnectedProvider, (_, _) {
    refresh.value++;
  });
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: connectPath,
    refreshListenable: refresh,
    redirect: (context, state) {
      final connected = ref.read(isConnectedProvider);
      final onConnect = state.matchedLocation == connectPath;
      if (!connected && !onConnect) {
        return connectPath;
      }
      if (connected && onConnect) {
        return homePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: connectPath,
        builder: (context, state) => const ConnectScreen(),
      ),
      GoRoute(
        path: homePath,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
