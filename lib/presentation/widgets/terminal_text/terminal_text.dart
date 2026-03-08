import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';

class TerminalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool selectable;

  const TerminalText({
    super.key,
    required this.text,
    this.style,
    this.color,
    this.fontSize,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  });

  TextStyle _resolvedStyle() {
    TextStyle resolved = AppTypography.bodyMedium;
    if (color != null) {
      resolved = resolved.copyWith(color: color);
    }
    if (fontSize != null) {
      resolved = resolved.copyWith(fontSize: fontSize);
    }
    if (style != null) {
      resolved = resolved.merge(style);
    }
    return resolved;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _resolvedStyle();
    if (selectable) {
      return SelectableText(text, style: effectiveStyle, maxLines: maxLines);
    }
    return Text(
      text,
      style: effectiveStyle,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
