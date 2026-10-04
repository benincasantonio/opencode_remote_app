import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/domain/providers/agent_providers.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_agent_selector.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'session_preview.dart';

@widgetbook.UseCase(name: 'Default', type: SessionAgentSelector)
Widget sessionAgentSelector(BuildContext context) {
  final agents = context.knobs.object.dropdown<AgentPreviewState>(
    label: 'Agents',
    options: AgentPreviewState.values,
    labelBuilder: (state) => state.name,
  );
  final disabled = context.knobs.boolean(label: 'Disabled');
  String? selected;
  return ProviderScope(
    key: ValueKey(agents),
    retry: (_, _) => null,
    overrides: [
      sessionAgentsProvider.overrideWith((ref) => previewAgents(agents)),
    ],
    child: Padding(
      padding: const EdgeInsets.all(AppSizing.gapLarge),
      child: StatefulBuilder(
        builder: (context, setState) => SessionAgentSelector(
          value: selected,
          onChanged: disabled
              ? null
              : (value) => setState(() => selected = value),
        ),
      ),
    ),
  );
}
