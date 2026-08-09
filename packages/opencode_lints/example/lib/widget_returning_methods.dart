import 'package:flutter/material.dart';

import 'use_case.dart';

// expect_lint: avoid_widget_returning_methods
Widget badTopLevelHelper(BuildContext context) => const Placeholder();

class WidgetReturningFixtures extends StatelessWidget {
  const WidgetReturningFixtures({super.key});

  // expect_lint: avoid_widget_returning_methods
  Widget _badPrivateHelper() => const Placeholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _badPrivateHelper(),
        Builder(builder: (context) => const Placeholder()),
      ],
    );
  }
}

@UseCase(name: 'Default', type: WidgetReturningFixtures)
Widget defaultWidgetReturningFixtures(BuildContext context) {
  return const WidgetReturningFixtures();
}
