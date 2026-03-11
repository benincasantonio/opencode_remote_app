import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator_size.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: LoadingIndicator)
Widget defaultLoadingIndicator(BuildContext context) {
  return Scaffold(
    body: Center(
      child: LoadingIndicator(
        size: context.knobs.object.dropdown<LoadingIndicatorSize>(
          label: 'Size',
          options: LoadingIndicatorSize.values,
          initialOption: LoadingIndicatorSize.large,
          labelBuilder: (s) => s.name,
        ),
        message: context.knobs.stringOrNull(
          label: 'Message',
          initialValue: 'Loading sessions...',
        ),
      ),
    ),
  );
}
