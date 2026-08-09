// ignore_for_file: file_size_signal, fixture exercises other rules
import 'package:flutter/material.dart';

/// Annotation stand-in for widgetbook's @UseCase (name-matched by the rule).
class UseCase {
  const UseCase({required this.name, required this.type});

  final String name;
  final Type type;
}

// expect_lint: avoid_widget_returning_methods
Widget badTopLevelHelper(BuildContext context) {
  return const Placeholder();
}

class WidgetReturningFixtures extends StatelessWidget {
  const WidgetReturningFixtures({super.key});

  // expect_lint: avoid_widget_returning_methods
  Widget _badPrivateHelper() {
    return const Placeholder();
  }

  // Allowed: build override.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _badPrivateHelper(),
        // Allowed: closure / builder callback.
        Builder(builder: (context) => const Placeholder()),
      ],
    );
  }
}

// Allowed: @UseCase-annotated top-level function (widgetbook pattern).
@UseCase(name: 'Default', type: WidgetReturningFixtures)
Widget defaultWidgetReturningFixtures(BuildContext context) {
  return const WidgetReturningFixtures();
}
