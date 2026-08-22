import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/app.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/discovery_providers.dart';
import 'package:opencode_remote_app/presentation/router/app_router.dart';
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
