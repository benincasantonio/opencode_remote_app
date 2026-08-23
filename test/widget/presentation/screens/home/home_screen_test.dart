import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/home/home_screen.dart';
import 'package:opencode_remote_app/presentation/screens/home/server_status_widget.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_badge.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

void main() {
  const healthy = ServerHealth(healthy: true, version: '1.2.3');
  const unhealthy = ServerHealth(healthy: false, version: '1.2.3');

  AppConnectionState connectedState({
    ServerHealth? health = healthy,
    String displayName = '192.168.1.10:4096',
    String baseUrl = 'http://192.168.1.10:4096',
  }) {
    return AppConnectionState(
      status: ConnectionStatus.connected,
      baseUrl: baseUrl,
      displayName: displayName,
      health: health,
    );
  }

  Future<void> pumpHome(
    WidgetTester tester,
    Stream<ServerHealth> healthStream,
    AppConnectionState connection,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectionProvider.overrideWithValue(connection),
          healthPollingProvider.overrideWith((ref) => healthStream),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pump();
  }

  int badgeCount(WidgetTester tester, String label) {
    return find
        .descendant(
          of: find.byType(ConnectionBadge),
          matching: find.text(label),
        )
        .evaluate()
        .length;
  }

  StreamController<ServerHealth> openController() {
    final controller = StreamController<ServerHealth>();
    addTearDown(controller.close);
    return controller;
  }

  testWidgets('uses the connect snapshot during the initial polling frame', (
    tester,
  ) async {
    final controller = openController();

    await pumpHome(tester, controller.stream, connectedState());

    expect(find.text('192.168.1.10:4096'), findsOneWidget);
    expect(find.text('Healthy'), findsOneWidget);
    expect(find.text('Version 1.2.3'), findsOneWidget);
  });

  testWidgets('updates card and app-bar badge from healthy to unhealthy', (
    tester,
  ) async {
    final controller = openController();

    await pumpHome(tester, controller.stream, connectedState());
    expect(badgeCount(tester, 'Connected'), 2);

    controller.add(unhealthy);
    await tester.pumpAndSettle();

    expect(badgeCount(tester, 'Unhealthy'), 2);
    expect(find.text('Unhealthy'), findsNWidgets(3));
  });

  testWidgets(
    'shows Error after a stream failure without leaving Home and keeps '
    'the last version visible',
    (tester) async {
      final controller = openController();

      await pumpHome(tester, controller.stream, connectedState());

      controller.add(healthy);
      await tester.pumpAndSettle();
      controller.addError(const NetworkException('down'));
      await tester.pumpAndSettle();

      expect(badgeCount(tester, 'Error'), 2);
      expect(find.text('Health information unavailable'), findsOneWidget);
      expect(find.text('Version 1.2.3'), findsOneWidget);
      expect(find.text('Home'), findsWidgets);
    },
  );

  testWidgets('recovers both card and app-bar badge after a later success', (
    tester,
  ) async {
    final controller = openController();

    await pumpHome(tester, controller.stream, connectedState());

    controller.addError(const NetworkException('down'));
    await tester.pumpAndSettle();
    expect(badgeCount(tester, 'Error'), 2);

    controller.add(healthy);
    await tester.pumpAndSettle();

    expect(badgeCount(tester, 'Connected'), 2);
    expect(find.text('Healthy'), findsOneWidget);
  });

  testWidgets('prefers displayName over baseUrl', (tester) async {
    final controller = openController();

    await pumpHome(
      tester,
      controller.stream,
      connectedState(
        displayName: 'my-server:4096',
        baseUrl: 'http://9.9.9.9:4096',
      ),
    );

    expect(find.text('my-server:4096'), findsOneWidget);
    expect(find.text('9.9.9.9:4096'), findsNothing);
  });

  testWidgets('contains one status card and no timestamp or manual refresh', (
    tester,
  ) async {
    final controller = openController();

    await pumpHome(tester, controller.stream, connectedState());

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ServerStatusWidget), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
  });
}
