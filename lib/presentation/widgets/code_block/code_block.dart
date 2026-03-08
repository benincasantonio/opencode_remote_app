import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';

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

  SyntaxTheme _terminalSyntaxTheme() {
    return SyntaxTheme.vscodeDark().copyWith(
      backgroundColor: AppColors.surfaceVariant,
      linesCountColor: AppColors.textMuted,
      baseStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontFamily: 'JetBrains Mono',
        fontSize: 13,
      ),
      commentStyle: TextStyle(
        color: AppColors.textMuted,
        fontStyle: FontStyle.italic,
      ),
      keywordStyle: const TextStyle(color: AppColors.accentCyan),
      stringStyle: const TextStyle(color: AppColors.success),
      classStyle: const TextStyle(color: AppColors.warning),
      punctuationStyle: const TextStyle(color: AppColors.textSecondary),
      zoomIconColor: AppColors.primaryGreen,
    );
  }

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
          _buildCodeContent(),
          Positioned(top: 8, right: 8, child: _CopyButton(code: code)),
        ],
      ),
    );
  }

  Widget _buildCodeContent() {
    final codeView = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SyntaxView(
        code: code,
        syntax: language,
        syntaxTheme: _terminalSyntaxTheme(),
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
          child: codeView,
        ),
      );
    }

    return codeView;
  }
}

class _CopyButton extends StatefulWidget {
  final String code;

  const _CopyButton({required this.code});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));

    if (mounted) {
      setState(() {
        _copied = true;
      });

      _resetTimer?.cancel();
      _resetTimer = Timer(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _copied = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _copied ? Icons.check_rounded : Icons.copy_rounded,
        color: _copied ? AppColors.success : AppColors.textMuted,
        size: 18,
      ),
      onPressed: _handleCopy,
      tooltip: 'Copy code',
      splashRadius: 18,
    );
  }
}
