import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block_content.dart';
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block_copy_button.dart';

class CodeBlock extends StatelessWidget {
  final String code;
  final Syntax language;
  final bool showLineNumbers;
  final double? maxHeight;

  const CodeBlock({
    super.key,
    required this.code,
    this.language = Syntax.DART,
    this.showLineNumbers = true,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          CodeBlockContent(
            code: code,
            language: language,
            showLineNumbers: showLineNumbers,
            maxHeight: maxHeight,
          ),
          Positioned(top: 8, right: 8, child: CodeBlockCopyButton(code: code)),
        ],
      ),
    );
  }
}
