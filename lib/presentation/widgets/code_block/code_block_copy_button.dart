import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';

class CodeBlockCopyButton extends StatefulWidget {
  final String code;

  const CodeBlockCopyButton({super.key, required this.code});

  @override
  State<CodeBlockCopyButton> createState() => _CodeBlockCopyButtonState();
}

class _CodeBlockCopyButtonState extends State<CodeBlockCopyButton> {
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
        size: AppSizing.iconSmall,
      ),
      onPressed: _handleCopy,
      tooltip: 'Copy code',
      splashRadius: AppSizing.iconSmall,
    );
  }
}
