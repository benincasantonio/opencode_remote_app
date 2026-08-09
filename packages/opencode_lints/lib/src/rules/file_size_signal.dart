import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:opencode_lints/src/helpers.dart';

/// Warns when a `lib/` source file exceeds [maxLines] lines.
///
/// Signal, not law: severity is warning so oversized files stay visible
/// without forcing a split.
class FileSizeSignal extends DartLintRule {
  FileSizeSignal({required this.maxLines}) : super(code: _code);

  factory FileSizeSignal.fromConfigs(CustomLintConfigs configs) {
    final options = configs.rules[ruleName];
    final raw = options?.json['max_lines'];
    final maxLines = raw is int ? raw : defaultMaxLines;
    return FileSizeSignal(maxLines: maxLines);
  }

  static const ruleName = 'file_size_signal';
  static const defaultMaxLines = 400;

  static const _code = LintCode(
    name: ruleName,
    problemMessage:
        'File exceeds {0} lines ({1} lines). Consider splitting it.',
    correctionMessage:
        'Extract widgets/helpers into separate files when it '
        'improves clarity — do not split solely to silence this warning.',
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
