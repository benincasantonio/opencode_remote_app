import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';

void main() {
  group('AppErrorCompactMode', () {
    testWidgets('compact mode renders smaller error icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(
              message: 'Error',
              onRetry: () {},
              compact: true,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon, isNotNull);
      expect(icon.size, 20);
    });

    testWidgets('compact mode uses IconButton for retry', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(
              message: 'Error',
              onRetry: () {},
              compact: true,
            ),
          ),
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('compact mode triggers onRetry callback', (tester) async {
      bool onRetryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(
              message: 'Error',
              onRetry: () => onRetryCalled = true,
              compact: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(onRetryCalled, isTrue);
    });
  });
}
