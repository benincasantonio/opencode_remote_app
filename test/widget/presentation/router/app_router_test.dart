import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/app.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/discovery_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/presentation/router/app_router.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/services/discovered_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App boots at /connect', (tester) async {
    await tester.pumpWidget(_TestApp(overrides: const []));
    await tester.pumpAndSettle();

    expect(find.text('Connect'), findsWidgets);
    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Servers on your network'), findsOneWidget);
  });

  testWidgets(
    'GoRouter redirects unknown paths to /connect when disconnected',
    (tester) async {
      await tester.pumpWidget(_TestApp(overrides: const []));
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(MaterialApp));
      final container = ProviderScope.containerOf(context);
      final router = container.read(appRouterProvider);

      router.go('/nowhere');
      await tester.pumpAndSettle();

      expect(router.state.uri.path, connectPath);
      expect(find.text('Host'), findsOneWidget);
    },
  );

  testWidgets('redirects to /home when connected', (tester) async {
    await tester.pumpWidget(
      _TestApp(overrides: [isConnectedProvider.overrideWithValue(true)]),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(MaterialApp));
    final router = ProviderScope.containerOf(context).read(appRouterProvider);

    expect(router.state.uri.path, homePath);
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets(
    'disconnect stays on Home until confirmed, then returns to /connect '
    'without touching saved-server persistence',
    (tester) async {
      await tester.pumpWidget(
        _TestApp(
          overrides: [
            connectionProvider.overrideWith(() => _ConnectedNotifier()),
            healthPollingProvider.overrideWith(
              (ref) => const Stream<ServerHealth>.empty(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(MaterialApp));
      final container = ProviderScope.containerOf(context);
      final router = container.read(appRouterProvider);
      expect(router.state.uri.path, homePath);

      await tester.tap(find.widgetWithText(AppButton, 'Disconnect'));
      await tester.pumpAndSettle();

      expect(find.text('Disconnect from server?'), findsOneWidget);
      expect(router.state.uri.path, homePath);

      await tester.tap(find.widgetWithText(AppButton, 'Disconnect').last);
      await tester.pumpAndSettle();

      expect(router.state.uri.path, connectPath);
      expect(find.text('Host'), findsOneWidget);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('saved_servers_v1'), isNull);
    },
  );
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.overrides});

  final List<dynamic> overrides;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        discoveredServersProvider.overrideWith(
          (ref) => const Stream<List<DiscoveredServer>>.empty(),
        ),
        ...overrides,
      ],
      child: const App(),
    );
  }
}

class _ConnectedNotifier extends Connection {
  @override
  AppConnectionState build() {
    return const AppConnectionState(
      status: ConnectionStatus.connected,
      baseUrl: 'http://192.168.1.10:4096',
      displayName: '192.168.1.10:4096',
      health: ServerHealth(healthy: true, version: '1.2.3'),
    );
  }
}
