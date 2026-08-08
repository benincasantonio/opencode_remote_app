import 'package:flutter/material.dart';

/// Regression fixture for the `deprecated_member_use: error` analyzer rule.
///
/// This file is excluded from the default analysis (`analyzer.exclude` in
/// analysis_options.yaml) and is intentionally analyzed by
/// test/unit/core/analyzer_lint_regression_test.dart, which asserts that
/// `flutter analyze` reports a `deprecated_member_use` error for it.
///
/// Using [WillPopScope] (deprecated) is a regression marker: if the rule
/// escalation is ever removed, this fixture stops failing analysis and the
/// regression test fails.
class DeprecatedApiFixture extends StatelessWidget {
  const DeprecatedApiFixture({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: const SizedBox(),
    );
  }
}
