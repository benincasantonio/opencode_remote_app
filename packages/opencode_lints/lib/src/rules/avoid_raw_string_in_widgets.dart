import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:opencode_lints/src/helpers.dart';

/// Flags non-empty simple string literals passed to user-facing widget
/// constructors (i18n enforcement).
///
/// Built-in targets:
/// - `Text` / `SelectableText` — first positional argument
/// - `Tooltip.message` — named argument
///
/// Extra targets come from analysis_options.yaml:
/// ```yaml
/// - avoid_raw_string_in_widgets:
///     targets:
///       AppButton: [label]
///       TerminalAppBar: [title]
/// ```
///
/// Interpolated strings (data, not copy) and empty strings are allowed.
class AvoidRawStringInWidgets extends DartLintRule {
  AvoidRawStringInWidgets({required this.extraTargets}) : super(code: _code);

  factory AvoidRawStringInWidgets.fromConfigs(CustomLintConfigs configs) {
    final options = configs.rules[ruleName];
    final raw = options?.json['targets'];
    final targets = <String, List<String>>{};
    if (raw is Map) {
      for (final entry in raw.entries) {
        final key = entry.key;
        final value = entry.value;
        if (key is! String) continue;
        if (value is List) {
          targets[key] = value.whereType<String>().toList();
        } else if (value is String) {
          targets[key] = [value];
        }
      }
    }
    return AvoidRawStringInWidgets(extraTargets: targets);
  }

  static const ruleName = 'avoid_raw_string_in_widgets';

  static const _code = LintCode(
    name: ruleName,
    problemMessage:
        'Do not hardcode user-facing strings in widgets. Use context.l10n.',
    correctionMessage:
        'Move the string to an ARB file and reference it via AppLocalizations.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  /// Extra widget → named-arg list from config.
  final Map<String, List<String>> extraTargets;

  static const _positionalTargets = {'Text', 'SelectableText'};
  static const _namedBuiltIns = {
    'Tooltip': ['message'],
  };

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    if (!isLibPath(resolver.path)) return;

    context.registry.addInstanceCreationExpression((node) {
      final typeName = node.constructorName.type.name.lexeme;

      // Positional first-arg targets (Text, SelectableText).
      if (_positionalTargets.contains(typeName)) {
        final args = node.argumentList.arguments;
        if (args.isNotEmpty) {
          final first = args.first;
          if (first is! NamedExpression) {
            _flagIfSimpleNonEmpty(first, reporter);
          }
        }
      }

      // Built-in named targets (Tooltip.message).
      final builtInNamed = _namedBuiltIns[typeName];
      if (builtInNamed != null) {
        _checkNamedArgs(node, builtInNamed, reporter);
      }

      // Configured extra targets.
      final extraNamed = extraTargets[typeName];
      if (extraNamed != null) {
        _checkNamedArgs(node, extraNamed, reporter);
      }
    });
  }

  void _checkNamedArgs(
    InstanceCreationExpression node,
    List<String> names,
    DiagnosticReporter reporter,
  ) {
    for (final arg in node.argumentList.arguments) {
      if (arg is! NamedExpression) continue;
      if (!names.contains(arg.name.label.name)) continue;
      _flagIfSimpleNonEmpty(arg.expression, reporter);
    }
  }

  void _flagIfSimpleNonEmpty(
    Expression expression,
    DiagnosticReporter reporter,
  ) {
    if (expression is! SimpleStringLiteral) return;
    final value = expression.value;
    if (value.isEmpty) return;
    // Decorative punctuation/symbols (e.g. '·', '—') are not user-facing copy.
    if (!_containsLetter.hasMatch(value)) return;
    reporter.atNode(expression, code);
  }

  static final _containsLetter = RegExp(r'\p{L}', unicode: true);
}
