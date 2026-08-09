import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/app.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/presentation/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });
  testWidgets('App boots at /connect', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Connect'), findsWidgets);
    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Open mDNS Discovery'), findsOneWidget);
  });

  testWidgets(
    'GoRouter redirects unknown paths to /connect when disconnected',
    (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
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
      ProviderScope(
        overrides: [isConnectedProvider.overrideWithValue(true)],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(MaterialApp));
    final router = ProviderScope.containerOf(context).read(appRouterProvider);

    expect(router.state.uri.path, homePath);
    expect(find.text('Home'), findsWidgets);
  });
}
