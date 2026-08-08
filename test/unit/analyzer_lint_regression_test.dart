import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression guard for the `deprecated_member_use: error` escalation in
/// analysis_options.yaml.
///
/// `test/fixtures/deprecated_api_fixture.dart` intentionally uses the
/// deprecated [WillPopScope] API and is excluded from the default analysis
/// scope. Analyzing that file explicitly must fail with a
/// `deprecated_member_use` error; if the escalation is removed, this test
/// fails.
void main() {
  test(
    'fixture using a deprecated Flutter API fails analysis',
    () async {
      final result = await Process.run(
        'flutter',
        ['analyze', '--no-pub', 'test/fixtures/deprecated_api_fixture.dart'],
        workingDirectory: Directory.current.path,
      );

      final output = '${result.stdout}\n${result.stderr}';

      expect(result.exitCode, isNot(0));
      expect(output, contains('deprecated_member_use'));
      expect(output, contains('WillPopScope'));
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
