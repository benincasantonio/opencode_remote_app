import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block.dart';

void main() {
  group('CodeBlock', () {
    testWidgets('renders code text', (WidgetTester tester) async {
      const testCode = 'hello';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: testCode)),
        ),
      );

      expect(find.text(testCode), findsOneWidget);
    });

    testWidgets('copy button present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: 'test')),
        ),
      );

      expect(find.byIcon(Icons.copy_rounded), findsOneWidget);
    });

    testWidgets('copy button is clickable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: 'test')),
        ),
      );

      expect(find.byIcon(Icons.copy_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.copy_rounded));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.copy_rounded), findsOneWidget);
    });

    testWidgets('copy button copies code to clipboard', (
      WidgetTester tester,
    ) async {
      const testCode = 'test code';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: testCode)),
        ),
      );

      await tester.tap(find.byIcon(Icons.copy_rounded));
      await tester.pump();
      await tester.pumpAndSettle();

      final clipboardData = await Clipboard.getData('text/plain');
      expect(clipboardData?.text, testCode);
    });

    testWidgets('line numbers toggle', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: 'test', showLineNumbers: false)),
        ),
      );

      final syntaxViewFinder = find.byType(SyntaxView);
      expect(syntaxViewFinder, findsOneWidget);

      final syntaxView = tester.widget(syntaxViewFinder) as SyntaxView;
      expect(syntaxView.withLinesCount, isFalse);
    });

    testWidgets('maxHeight constraint applies ConstrainedBox', (
      WidgetTester tester,
    ) async {
      const maxHeight = 100.0;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CodeBlock(code: 'test', maxHeight: maxHeight),
          ),
        ),
      );

      final constrainedBoxFinder = find.byType(ConstrainedBox);
      final constrainedBoxes = tester
          .widgetList(constrainedBoxFinder)
          .whereType<ConstrainedBox>();

      expect(
        constrainedBoxes.any((box) => box.constraints.maxHeight == maxHeight),
        isTrue,
      );
    });

    testWidgets('horizontal scrolling for long lines', (
      WidgetTester tester,
    ) async {
      const longCode =
          'very_long_line_that_should_scroll_horizontally_without_wrapping_to_the_next_line_very_long_line';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: longCode)),
        ),
      );

      final horizontalScrollFinder = find.byType(SingleChildScrollView);
      expect(horizontalScrollFinder, findsWidgets);

      final horizontalScrolls = tester
          .widgetList(horizontalScrollFinder)
          .whereType<SingleChildScrollView>();
      expect(
        horizontalScrolls.any(
          (scroll) => scroll.scrollDirection == Axis.horizontal,
        ),
        isTrue,
      );
    });

    testWidgets('vertical scrolling when maxHeight is set', (
      WidgetTester tester,
    ) async {
      const multiLineCode = '''
line 1
line 2
line 3
line 4
line 5
line 6
line 7
line 8
line 9
line 10
      ''';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CodeBlock(code: multiLineCode, maxHeight: 100)),
        ),
      );

      final verticalScrollFinder = find.byType(SingleChildScrollView);
      expect(verticalScrollFinder, findsWidgets);

      final verticalScrolls = tester
          .widgetList(verticalScrollFinder)
          .whereType<SingleChildScrollView>();
      expect(
        verticalScrolls.any(
          (scroll) => scroll.scrollDirection == Axis.vertical,
        ),
        isTrue,
      );
    });
  });
}
