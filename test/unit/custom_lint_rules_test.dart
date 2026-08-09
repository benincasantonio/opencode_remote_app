import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression guard: every opencode_lints rule has `// expect_lint` fixtures
/// in packages/opencode_lints/example. A clean `dart run custom_lint` there
/// means positive and negative cases all fire exactly where expected.
void main() {
  test(
    'opencode_lints example fixtures pass custom_lint',
    () async {
      final exampleDir = Directory('packages/opencode_lints/example');
      expect(exampleDir.existsSync(), isTrue);

      final result = await Process.run('dart', [
        'run',
        'custom_lint',
      ], workingDirectory: exampleDir.path);

      final output = '${result.stdout}\n${result.stderr}';
      expect(result.exitCode, 0, reason: 'custom_lint failed:\n$output');
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
