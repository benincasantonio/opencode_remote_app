import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/connect/connect_screen.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

void main() {
  testWidgets('ConnectScreen shows manual form fields', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ConnectScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Port'), findsOneWidget);
    expect(find.text('Username (optional)'), findsOneWidget);
    expect(find.text('Password (optional)'), findsOneWidget);
    expect(find.text('Connect'), findsWidgets);
    expect(find.text('Open mDNS Discovery'), findsOneWidget);
  });

  testWidgets('ConnectScreen shows auth error from connection state', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectionProvider.overrideWithValue(
            const AppConnectionState(
              status: ConnectionStatus.error,
              error: AuthException('Unauthorized', statusCode: 401),
            ),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ConnectScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Authentication failed. Check username and password.'),
      findsOneWidget,
    );
  });

  testWidgets('ConnectScreen disables connect while connecting', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectionProvider.overrideWithValue(
            const AppConnectionState(status: ConnectionStatus.connecting),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ConnectScreen(),
        ),
      ),
    );
    await tester.pump();

    final button = tester.widget<FilledButton>(
      find.ancestor(
        of: find.byType(CircularProgressIndicator),
        matching: find.byType(FilledButton),
      ),
    );
    expect(button.onPressed, isNull);
  });
}
