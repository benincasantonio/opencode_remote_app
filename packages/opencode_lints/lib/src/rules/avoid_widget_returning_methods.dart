import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Flags methods and top-level functions that return `Widget` (or a subtype /
/// `List<Widget>`). Extract a dedicated widget class instead.
///
/// Exemptions:
/// - `build` methods in Widget / State subclasses
/// - Members annotated with `@override`
/// - Closures / anonymous function expressions (e.g. `builder:` callbacks)
/// - Declarations annotated with `@UseCase` (widgetbook)
class AvoidWidgetReturningMethods extends DartLintRule {
  const AvoidWidgetReturningMethods() : super(code: _code);

  static const ruleName = 'avoid_widget_returning_methods';

  static const _code = LintCode(
    name: ruleName,
    problemMessage:
        'Do not return Widget from methods. Extract a dedicated widget class.',
    correctionMessage:
        'Create a StatelessWidget / StatefulWidget instead of a '
        'Widget-returning helper method.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  static const _widgetChecker = TypeChecker.fromName(
    'Widget',
    packageName: 'flutter',
  );

  static const _useCaseChecker = TypeChecker.fromName(
    'UseCase',
    packageName: 'widgetbook_annotation',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      if (_shouldSkipMethod(node)) return;
      if (_returnsWidget(node.returnType)) {
        reporter.atToken(node.name, code);
      }
    });

    context.registry.addFunctionDeclaration((node) {
      if (_hasUseCaseAnnotation(node.metadata)) return;
      if (_returnsWidget(node.returnType)) {
        reporter.atToken(node.name, code);
      }
    });
  }

  bool _shouldSkipMethod(MethodDeclaration node) {
    // Closures are FunctionExpression nodes, not MethodDeclaration — already
    // excluded by the registry choice. Skip @override and build().
    if (node.name.lexeme == 'build') return true;
    if (node.metadata.any((a) => a.name.name == 'override')) return true;
    if (_hasUseCaseAnnotation(node.metadata)) return true;
    return false;
  }

  bool _hasUseCaseAnnotation(NodeList<Annotation> metadata) {
    for (final annotation in metadata) {
      final element = annotation.elementAnnotation;
      if (element == null) continue;
      final value = element.computeConstantValue();
      final type = value?.type;
      if (type != null && _useCaseChecker.isExactlyType(type)) {
        return true;
      }
      // Fallback: name match (annotation may not resolve in fixtures).
      if (annotation.name.name == 'UseCase' ||
          annotation.name.name.endsWith('.UseCase')) {
        return true;
      }
    }
    return false;
  }

  bool _returnsWidget(TypeAnnotation? returnType) {
    if (returnType == null) return false;

    final type = returnType.type;
    if (type == null) {
      // Unresolved — fall back to source text heuristics for fixtures that
      // don't pull in Flutter strongly.
      final source = returnType.toSource();
      return source == 'Widget' ||
          source == 'Widget?' ||
          source.startsWith('List<Widget');
    }

    if (_widgetChecker.isAssignableFromType(type)) return true;

    if (type is InterfaceType && type.element.name == 'List') {
      if (type.typeArguments.isEmpty) return false;
      return _widgetChecker.isAssignableFromType(type.typeArguments.first);
    }

    return false;
  }
}
