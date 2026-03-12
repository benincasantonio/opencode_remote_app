import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block.dart';

class MarkdownCodeBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final codeText = element.textContent;

    String matchedLang = 'TEXT';
    final classNames = element.attributes['class'];
    if (classNames != null) {
      final langClass = classNames
          .split(' ')
          .firstWhere((c) => c.startsWith('language-'), orElse: () => '');
      if (langClass.isNotEmpty) {
        matchedLang = langClass.substring(9).toUpperCase();
      }
    }

    final syntax = Syntax.values.cast<Syntax?>().firstWhere(
      (s) => s?.name.toUpperCase() == matchedLang,
      orElse: () => Syntax.DART,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CodeBlock(
        code: codeText.trimRight(),
        language: syntax ?? Syntax.DART,
        showLineNumbers: true,
      ),
    );
  }
}
