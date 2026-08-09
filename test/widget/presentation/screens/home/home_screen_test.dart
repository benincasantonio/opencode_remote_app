import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/home/home_screen.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

void main() {
  testWidgets('HomeScreen shows server identity and health/version', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectionProvider.overrideWithValue(
            const AppConnectionState(
              status: ConnectionStatus.connected,
              baseUrl: 'http://192.168.1.10:4096',
              displayName: '192.168.1.10:4096',
              health: ServerHealth(healthy: true, version: '1.2.3'),
            ),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('192.168.1.10:4096'), findsOneWidget);
    expect(find.text('Healthy'), findsOneWidget);
    expect(find.text('Version 1.2.3'), findsOneWidget);
  });
}
