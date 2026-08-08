import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/check_widgetbook_registration.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('widgetbook_check_');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  Directory buildUseCaseFiles(List<String> names) {
    final libDir = Directory('${tempDir.path}/lib')..createSync();
    for (final name in names) {
      File('${libDir.path}/$name').writeAsStringSync('void _unused() {}');
    }
    return libDir;
  }

  test('returns empty when every use case is registered', () {
    final libDir = buildUseCaseFiles(['alpha_use_case.dart', 'beta_use_case.dart']);
    File('${libDir.path}/main.directories.g.dart').writeAsStringSync(
      "import 'package:widgetbook_workspace/alpha_use_case.dart' as a;\n"
      "import 'package:widgetbook_workspace/beta_use_case.dart' as b;\n",
    );

    expect(findUnregisteredUseCases(libDir), isEmpty);
  });

  test('reports a deliberately stale registration', () {
    final libDir = buildUseCaseFiles(['alpha_use_case.dart', 'beta_use_case.dart']);
    File('${libDir.path}/main.directories.g.dart').writeAsStringSync(
      "import 'package:widgetbook_workspace/alpha_use_case.dart' as a;\n",
    );

    final unregistered = findUnregisteredUseCases(libDir);
    expect(unregistered, hasLength(1));
    expect(unregistered.single, contains('beta_use_case.dart'));
  });

  test('reports every use case when the generated file is missing', () {
    final libDir = buildUseCaseFiles(['alpha_use_case.dart', 'beta_use_case.dart']);

    final unregistered = findUnregisteredUseCases(libDir);
    expect(unregistered, hasLength(2));
    expect(unregistered, everyElement(endsWith('_use_case.dart')));
  });

  test('returns empty when there are no use case files', () {
    final libDir = Directory('${tempDir.path}/lib')..createSync();

    expect(findUnregisteredUseCases(libDir), isEmpty);
  });

  test('only considers *_use_case.dart files', () {
    final libDir = buildUseCaseFiles(['alpha_use_case.dart']);
    File('${libDir.path}/helper_widget.dart').writeAsStringSync('void x() {}');
    File('${libDir.path}/main.directories.g.dart').writeAsStringSync('');

    final unregistered = findUnregisteredUseCases(libDir);
    expect(unregistered, hasLength(1));
    expect(unregistered.single, contains('alpha_use_case.dart'));
  });
}
