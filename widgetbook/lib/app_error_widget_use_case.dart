import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppErrorWidget)
Widget defaultAppErrorWidget(BuildContext context) {
  return Scaffold(
    body: Center(
      child: AppErrorWidget(
        message: context.knobs.string(
          label: 'Message',
          initialValue: 'Something went wrong. Please try again.',
        ),
        compact: context.knobs.boolean(
          label: 'Compact mode',
          initialValue: false,
        ),
        onRetry: context.knobs.boolean(label: 'Has retry', initialValue: true)
            ? () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Retry tapped!')));
              }
            : null,
      ),
    ),
  );
}
