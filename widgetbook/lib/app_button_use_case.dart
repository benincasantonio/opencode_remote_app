import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button_variant.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppButton)
Widget defaultAppButton(BuildContext context) {
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  return Scaffold(
    body: Center(
      child: AppButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Click Me'),
        variant: context.knobs.object.dropdown<AppButtonVariant>(
          label: 'Variant',
          options: AppButtonVariant.values,
          initialOption: AppButtonVariant.primary,
          labelBuilder: (v) => v.name,
        ),
        isLoading: context.knobs.boolean(
          label: 'Is Loading',
          initialValue: false,
        ),
        icon: showIcon ? Icons.send : null,
        onPressed: () {},
      ),
    ),
  );
}
