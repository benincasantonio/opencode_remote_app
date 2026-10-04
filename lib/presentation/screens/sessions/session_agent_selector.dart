import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/agent_providers.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import '../../widgets/loading_indicator/loading_indicator_size.dart';

class SessionAgentSelector extends ConsumerWidget {
  const SessionAgentSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String? value;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final agents = ref.watch(sessionAgentsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          initialValue: value ?? '',
          isExpanded: true,
          decoration: InputDecoration(labelText: l10n.sessionAgentLabel),
          items: [
            DropdownMenuItem(value: '', child: Text(l10n.serverDefaultAgent)),
            for (final agent in agents.value ?? [])
              DropdownMenuItem(
                value: agent.name,
                child: Text(agent.name, overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: agents.hasValue && onChanged != null
              ? (value) => onChanged?.call(value == '' ? null : value)
              : null,
        ),
        if (agents.isLoading) ...[
          const SizedBox(height: AppSizing.gapSmall),
          Semantics(
            liveRegion: true,
            label: l10n.loadingAgents,
            child: const LoadingIndicator(size: LoadingIndicatorSize.small),
          ),
        ],
        if (agents.hasError) ...[
          const SizedBox(height: AppSizing.gapSmall),
          Semantics(liveRegion: true, child: Text(l10n.agentsLoadError)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppButton(
              label: l10n.retry,
              variant: AppButtonVariant.ghost,
              onPressed: onChanged == null
                  ? null
                  : () => ref.invalidate(sessionAgentsProvider),
            ),
          ),
        ],
      ],
    );
  }
}
