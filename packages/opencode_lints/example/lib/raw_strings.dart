import 'package:flutter/material.dart';

import 'raw_string_stubs.dart';

/// Positive cases: must trigger avoid_raw_string_in_widgets.
class RawStringBadFixtures extends StatelessWidget {
  const RawStringBadFixtures({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // expect_lint: avoid_raw_string_in_widgets
        const Text('Hello'),
        // expect_lint: avoid_raw_string_in_widgets
        const AppButton(label: 'Save'),
        // expect_lint: avoid_raw_string_in_widgets
        const TerminalAppBar(title: 'OpenCode'),
        // expect_lint: avoid_raw_string_in_widgets
        const Tooltip(message: 'More info', child: Icon(Icons.info)),
      ],
    );
  }
}
