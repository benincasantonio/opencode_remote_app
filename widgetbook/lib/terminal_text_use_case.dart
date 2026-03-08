import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/terminal_text/terminal_text.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TerminalText)
Widget defaultTerminalText(BuildContext context) {
  return TerminalText(
    text: context.knobs.string(
      label: 'Text',
      initialValue: '> Hello, OpenCode Terminal',
    ),
    color: context.knobs.colorOrNull(
      label: 'Color',
      initialValue: AppColors.textPrimary,
    ),
    fontSize: context.knobs.doubleOrNull.input(
      label: 'Font size',
      initialValue: null,
    ),
    maxLines: context.knobs.intOrNull.input(
      label: 'Max lines',
      initialValue: null,
    ),
    selectable: context.knobs.boolean(label: 'Selectable', initialValue: false),
  );
}
