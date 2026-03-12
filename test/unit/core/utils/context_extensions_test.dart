import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/utils/context_extensions.dart';

void main() {
  group('BuildContextX', () {
    testWidgets('theme getter returns ThemeData', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.theme, isNotNull);
              expect(context.theme, isA<ThemeData>());
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('textTheme getter returns TextTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.textTheme, isNotNull);
              expect(context.textTheme, isA<TextTheme>());
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('colorScheme getter returns ColorScheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.colorScheme, isNotNull);
              expect(context.colorScheme, isA<ColorScheme>());
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('mediaQuery getter returns MediaQueryData', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.mediaQuery, isNotNull);
              expect(context.mediaQuery, isA<MediaQueryData>());
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
