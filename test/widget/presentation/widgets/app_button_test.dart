import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders label text', (tester) async {
      const testLabel = 'My Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(label: testLabel, onPressed: () {}),
          ),
        ),
      );

      expect(find.text(testLabel), findsOneWidget);
    });

    testWidgets('triggers onPressed when tapped', (tester) async {
      bool onPressedCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Click Me',
              onPressed: () => onPressedCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(onPressedCalled, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('disables button when isLoading is true', (tester) async {
      bool onPressedCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Loading',
              onPressed: () => onPressedCalled = true,
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(onPressedCalled, isFalse);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'With Icon',
              onPressed: () {},
              icon: Icons.add,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('does not render icon when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Loading',
              onPressed: () {},
              icon: Icons.add,
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('disables button when onPressed is null', (tester) async {
      bool onPressedCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppButton(label: 'Disabled', onPressed: null)),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(onPressedCalled, isFalse);
    });
  });
}
