import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: CodeBlock)
Widget defaultCodeBlock(BuildContext context) {
  return Container(
    width: double.infinity,
    child: CodeBlock(
      code: context.knobs.string(
        label: 'Code',
        initialValue: 'void main() {\n  print("Hello, world!");\n}',
      ),
      language: context.knobs.list(
        label: 'Language',
        options: Syntax.values,
        initialOption: Syntax.DART,
        labelBuilder: (s) => s.name,
      ),
      showLineNumbers: context.knobs.boolean(
        label: 'Show line numbers',
        initialValue: true,
      ),
      maxHeight: context.knobs.doubleOrNull.input(
        label: 'Max height',
        initialValue: null,
      ),
    ),
  );
}
