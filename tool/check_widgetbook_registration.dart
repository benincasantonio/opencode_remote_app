import 'dart:io';

const _defaultWidgetbookLibDir = 'widgetbook/lib';
const _useCaseSuffix = '_use_case.dart';
const _generatedFileName = 'main.directories.g.dart';

/// Returns the relative paths of `*_use_case.dart` files under
/// [widgetbookLibDir] that are not registered in `main.directories.g.dart`.
List<String> findUnregisteredUseCases(Directory widgetbookLibDir) {
  final useCaseFiles = widgetbookLibDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith(_useCaseSuffix))
      .toList()
      ..sort((a, b) => a.path.compareTo(b.path));
  if (useCaseFiles.isEmpty) {
    return const [];
  }
  final generatedFile = File('${widgetbookLibDir.path}/$_generatedFileName');
  if (!generatedFile.existsSync()) {
    return useCaseFiles.map((file) => file.path).toList();
  }
  final generated = generatedFile.readAsStringSync();
  return useCaseFiles
      .where(
        (file) => !generated.contains(file.uri.pathSegments.last),
      )
      .map((file) => file.path)
      .toList();
}

Future<void> main(List<String> args) async {
  final widgetbookLibDir =
      Directory(args.isNotEmpty ? args.first : _defaultWidgetbookLibDir);
  final unregistered = findUnregisteredUseCases(widgetbookLibDir);
  if (unregistered.isEmpty) {
    stdout.writeln('OK: all widgetbook use cases are registered.');
    return;
  }
  stderr.writeln(
    'ERROR: widgetbook use cases missing from $_generatedFileName:',
  );
  for (final path in unregistered) {
    stderr.writeln('  $path');
  }
  stderr.writeln('Run `make generate` to regenerate widgetbook files.');
  exit(1);
}
