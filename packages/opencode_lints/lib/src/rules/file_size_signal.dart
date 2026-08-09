import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:opencode_lints/src/helpers.dart';

/// Shared ignore-comment scanner for file_size_signal suppressions.
class FileSizeIgnore {
  FileSizeIgnore._();

  static const ruleName = 'file_size_signal';

  /// Matches both `// ignore:` and `// ignore_for_file:` comments.
  static final regex = RegExp(
    r'//\s*ignore(?:_for_file)?\s*:\s*(.+)$',
    multiLine: true,
  );

  /// Finds the first ignore comment that lists [ruleName].
  static FileSizeSuppression? find(String source) {
    for (final match in regex.allMatches(source)) {
      final codesPart = match.group(1)!;
      final segments = codesPart.split(',').map((e) => e.trim()).toList();
      if (segments.isEmpty) continue;

      for (var i = 0; i < segments.length; i++) {
        final segment = segments[i];
        if (segment == ruleName || segment.startsWith('$ruleName ')) {
          final hasCommaReason =
              i + 1 < segments.length &&
              segments.sublist(i + 1).any((s) => s.isNotEmpty);
          final codeOffset = match.start + match.group(0)!.indexOf(ruleName);
          return FileSizeSuppression(
            hasReason: hasCommaReason,
            codeOffset: codeOffset,
          );
        }
      }
    }
    return null;
  }
}

class FileSizeSuppression {
  const FileSizeSuppression({
    required this.hasReason,
    required this.codeOffset,
  });

  final bool hasReason;
  final int codeOffset;
}

/// Warns when a `lib/` source file exceeds [maxLines] lines.
///
/// Suppress with a mandatory reason after the comma:
/// ```dart
/// // ignore_for_file: file_size_signal, legacy chat screen pending split
/// ```
///
/// A bare ignore is caught by [FileSizeSignalMissingReason] (a separate rule
/// so custom_lint's ignore_for_file filter does not skip the check).
class FileSizeSignal extends DartLintRule {
  FileSizeSignal({required this.maxLines}) : super(code: _code);

  factory FileSizeSignal.fromConfigs(CustomLintConfigs configs) {
    final options = configs.rules[ruleName];
    final raw = options?.json['max_lines'];
    final maxLines = raw is int ? raw : defaultMaxLines;
    return FileSizeSignal(maxLines: maxLines);
  }

  static const ruleName = FileSizeIgnore.ruleName;
  static const defaultMaxLines = 400;

  static const _code = LintCode(
    name: ruleName,
    problemMessage:
        'File exceeds {0} lines ({1} lines). Consider splitting it.',
    correctionMessage:
        'Extract widgets/helpers into separate files, or suppress with '
        '// ignore_for_file: file_size_signal, <reason>',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  final int maxLines;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    if (!isLibPath(resolver.path) || isGeneratedPath(resolver.path)) {
      return;
    }

    context.registry.addCompilationUnit((node) {
      final lineCount = resolver.lineInfo.lineCount;
      if (lineCount <= maxLines) return;

      // Custom reason-bearing ignores are handled by custom_lint's built-in
      // ignore_for_file filter (which skips this rule). Bare ignores are
      // reported by FileSizeSignalMissingReason.
      final source = resolver.source.contents.data;
      final offset = resolver.lineInfo.getOffsetOfLine(maxLines);
      final lineLength = lineCount > maxLines + 1
          ? resolver.lineInfo.getOffsetOfLine(maxLines + 1) - offset - 1
          : source.length - offset;
      reporter.atOffset(
        diagnosticCode: code,
        offset: offset,
        length: lineLength.clamp(1, source.length - offset),
        arguments: [maxLines, lineCount],
      );
    });
  }
}

/// Flags `// ignore_for_file: file_size_signal` (and line ignores) that omit
/// the mandatory reason after the comma.
///
/// Must be a separate [DartLintRule] so that a bare
/// `ignore_for_file: file_size_signal` does not prevent this check from
/// running (custom_lint skips rules whose [LintRule.code] is listed).
class FileSizeSignalMissingReason extends DartLintRule {
  FileSizeSignalMissingReason({required this.maxLines}) : super(code: _code);

  factory FileSizeSignalMissingReason.fromConfigs(CustomLintConfigs configs) {
    // Reuse file_size_signal's max_lines config.
    final options = configs.rules[FileSizeIgnore.ruleName];
    final raw = options?.json['max_lines'];
    final maxLines = raw is int ? raw : FileSizeSignal.defaultMaxLines;
    return FileSizeSignalMissingReason(maxLines: maxLines);
  }

  static const ruleName = 'file_size_signal_missing_reason';

  static const _code = LintCode(
    name: ruleName,
    problemMessage:
        'Ignoring file_size_signal requires a reason after the comma.',
    correctionMessage: 'Use // ignore_for_file: file_size_signal, <reason>',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  final int maxLines;

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    if (!isLibPath(resolver.path) || isGeneratedPath(resolver.path)) {
      return;
    }

    context.registry.addCompilationUnit((node) {
      final lineCount = resolver.lineInfo.lineCount;
      // Only enforce the reason when the file would actually trip the signal.
      if (lineCount <= maxLines) return;

      final source = resolver.source.contents.data;
      final suppression = FileSizeIgnore.find(source);
      if (suppression == null || suppression.hasReason) return;

      reporter.atOffset(
        diagnosticCode: code,
        offset: suppression.codeOffset,
        length: FileSizeIgnore.ruleName.length,
      );
    });
  }
}
