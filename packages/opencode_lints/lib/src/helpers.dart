import 'package:path/path.dart' as p;

/// Returns true when [path] is under a `lib/` directory.
bool isLibPath(String path) {
  final segments = p.split(p.normalize(path));
  return segments.contains('lib');
}

/// Returns true when [path] is a generated `.g.dart` or `.freezed.dart` file.
bool isGeneratedPath(String path) {
  final name = p.basename(path);
  return name.endsWith('.g.dart') || name.endsWith('.freezed.dart');
}

/// Returns true when [path] is under `lib/data/models/`.
bool isModelsPath(String path) {
  final segments = p.split(p.normalize(path));
  final libIndex = segments.indexOf('lib');
  if (libIndex < 0) return false;
  if (libIndex + 2 >= segments.length) return false;
  return segments[libIndex + 1] == 'data' && segments[libIndex + 2] == 'models';
}
