import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/presentation/widgets/app_bar/terminal_app_bar.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_badge.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

void main() {
  group('TerminalAppBar', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(appBar: TerminalAppBar(title: 'My Title')),
        ),
      );

      expect(find.text('My Title'), findsOneWidget);
    });

    testWidgets('shows ConnectionBadge when enabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const TerminalAppBar(
              title: 'Test',
              showConnectionBadge: true,
              connectionStatus: ConnectionStatus.connected,
            ),
          ),
        ),
      );

      expect(find.byType(ConnectionBadge), findsOneWidget);
    });

    testWidgets('hides ConnectionBadge when disabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const TerminalAppBar(
              title: 'Test',
              showConnectionBadge: false,
            ),
          ),
        ),
      );

      expect(find.byType(ConnectionBadge), findsNothing);
    });

    testWidgets('renders custom leading widget', (tester) async {
      const customLeading = Icon(Icons.menu);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: TerminalAppBar(title: 'Test', leading: customLeading),
          ),
        ),
      );

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('renders custom actions', (tester) async {
      const customAction = Icon(Icons.settings);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: TerminalAppBar(
              title: 'Test',
              actions: const [customAction],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('implements PreferredSizeWidget', (tester) async {
      const appBar = TerminalAppBar(title: 'Test');

      expect(appBar, isA<PreferredSizeWidget>());
      expect(appBar.preferredSize, const Size.fromHeight(kToolbarHeight));
    });

    testWidgets('passes serverName to ConnectionBadge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const TerminalAppBar(
              title: 'Test',
              showConnectionBadge: true,
              connectionStatus: ConnectionStatus.connected,
              serverName: 'my-server',
            ),
          ),
        ),
      );

      expect(find.text('my-server'), findsOneWidget);
    });

    testWidgets('passes connectionStatus to ConnectionBadge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const TerminalAppBar(
              title: 'Test',
              showConnectionBadge: true,
              connectionStatus: ConnectionStatus.connecting,
            ),
          ),
        ),
      );

      final connectionBadge = tester.widget<ConnectionBadge>(
        find.byType(ConnectionBadge),
      );
      expect(connectionBadge.status, ConnectionStatus.connecting);
    });
  });
}
