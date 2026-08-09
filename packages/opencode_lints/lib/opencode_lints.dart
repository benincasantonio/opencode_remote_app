import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:opencode_lints/src/rules/avoid_raw_string_in_widgets.dart';
import 'package:opencode_lints/src/rules/avoid_widget_returning_methods.dart';
import 'package:opencode_lints/src/rules/file_size_signal.dart';
import 'package:opencode_lints/src/rules/models_are_dtos.dart';

/// Entry point for the `opencode_lints` custom_lint plugin.
PluginBase createPlugin() => _OpencodeLints();

class _OpencodeLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    FileSizeSignal.fromConfigs(configs),
    AvoidRawStringInWidgets.fromConfigs(configs),
    const AvoidWidgetReturningMethods(),
    const ModelsAreDtos(),
  ];
}
