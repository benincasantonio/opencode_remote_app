import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:opencode_remote_app/core/constants/syntax_theme_constants.dart';

class CodeBlockContent extends StatelessWidget {
  final String code;
  final Syntax language;
  final bool showLineNumbers;
  final double? maxHeight;

  const CodeBlockContent({
    super.key,
    required this.code,
    required this.language,
    required this.showLineNumbers,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final syntaxView = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SyntaxView(
        code: code,
        syntax: language,
        syntaxTheme: SyntaxThemeConstants.terminalSyntaxTheme(),
        withLinesCount: showLineNumbers,
        expanded: false,
        selectable: true,
        withZoom: false,
      ),
    );

    if (maxHeight != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight!),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: syntaxView,
        ),
      );
    }

    return syntaxView;
  }
}
