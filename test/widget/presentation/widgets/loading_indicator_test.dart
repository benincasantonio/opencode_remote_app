import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator_size.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('renders CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingIndicator())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('large variant with message renders text', (tester) async {
      const testMessage = 'Loading sessions...';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LoadingIndicator(message: testMessage)),
        ),
      );

      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('large variant without message hides text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingIndicator())),
      );

      expect(find.text('Loading sessions...'), findsNothing);
    });

    testWidgets('small variant hides message even if provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(
              size: LoadingIndicatorSize.small,
              message: 'This should not show',
            ),
          ),
        ),
      );

      expect(find.text('This should not show'), findsNothing);
    });

    testWidgets('verify primary green color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingIndicator())),
      );

      final circularProgressIndicator = tester
          .widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          );

      expect(circularProgressIndicator.color, AppColors.primaryGreen);
    });

    testWidgets('small variant renders smaller spinner', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(size: LoadingIndicatorSize.small),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 20.0);
      expect(sizedBox.height, 20.0);
    });

    testWidgets('large variant renders larger spinner', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingIndicator(size: LoadingIndicatorSize.large),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, 40.0);
      expect(sizedBox.height, 40.0);
    });
  });
}
