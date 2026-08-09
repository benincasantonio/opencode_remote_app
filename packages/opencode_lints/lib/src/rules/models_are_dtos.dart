import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:opencode_lints/src/helpers.dart';

/// Enforces that files under `lib/data/models/` are immutable DTOs.
///
/// Flags:
/// - Classes that extend / implement / mix in `ChangeNotifier`,
///   `ValueNotifier`, or `Listenable`
/// - Non-final, non-static instance fields
class ModelsAreDtos extends DartLintRule {
  const ModelsAreDtos() : super(code: _code);

  static const ruleName = 'models_are_dtos';

  static const _code = LintCode(
    name: ruleName,
    problemMessage:
        'Models under lib/data/models/ must be immutable DTOs. '
        '{0}',
    correctionMessage:
        'Use freezed / final fields. Move mutable state out of data/models.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  static const _forbidden = TypeChecker.any([
    TypeChecker.fromName('ChangeNotifier', packageName: 'flutter'),
    TypeChecker.fromName('ValueNotifier', packageName: 'flutter'),
    TypeChecker.fromName('Listenable', packageName: 'flutter'),
  ]);

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    if (!isModelsPath(resolver.path) || isGeneratedPath(resolver.path)) {
      return;
    }

    context.registry.addClassDeclaration((node) {
      _checkInheritance(node, reporter);
      _checkMutableFields(node, reporter);
    });
  }

  void _checkInheritance(ClassDeclaration node, DiagnosticReporter reporter) {
    final element = node.declaredFragment?.element;
    if (element == null) {
      // Fallback for fixtures: check extends / with / implements by name.
      final names = <String>[
        if (node.extendsClause case final extendsClause?)
          extendsClause.superclass.name.lexeme,
        ...?node.withClause?.mixinTypes.map((t) => t.name.lexeme),
        ...?node.implementsClause?.interfaces.map((t) => t.name.lexeme),
      ];
      if (names.any(_isForbiddenName)) {
        reporter.atToken(
          node.name,
          code,
          arguments: ['Do not extend/implement ChangeNotifier or Listenable.'],
        );
      }
      return;
    }

    if (_forbidden.isAssignableFrom(element)) {
      reporter.atToken(
        node.name,
        code,
        arguments: ['Do not extend/implement ChangeNotifier or Listenable.'],
      );
    }
  }

  void _checkMutableFields(ClassDeclaration node, DiagnosticReporter reporter) {
    for (final member in node.members) {
      if (member is! FieldDeclaration) continue;
      if (member.isStatic) continue;
      if (member.fields.isFinal || member.fields.isConst) continue;
      for (final variable in member.fields.variables) {
        reporter.atToken(
          variable.name,
          code,
          arguments: ['Field "${variable.name.lexeme}" must be final.'],
        );
      }
    }
  }

  static bool _isForbiddenName(String name) =>
      name == 'ChangeNotifier' ||
      name == 'ValueNotifier' ||
      name == 'Listenable';
}
