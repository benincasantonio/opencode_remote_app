import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/session.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/session_providers.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import 'session_agent_selector.dart';

class NewSessionDialog extends ConsumerStatefulWidget {
  const NewSessionDialog({super.key});

  @override
  ConsumerState<NewSessionDialog> createState() => _NewSessionDialogState();
}

class _NewSessionDialogState extends ConsumerState<NewSessionDialog> {
  final _titleController = TextEditingController();
  String? _agent;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final title = _titleController.text.trim();
    final session = await ref
        .read(sessionCreationProvider.notifier)
        .create(
          CreateSessionInput(
            title: title.isEmpty ? null : title,
            agent: _agent,
          ),
        );
    if (mounted && session != null) Navigator.of(context).pop(session);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final creation = ref.watch(sessionCreationProvider);
    final isLoading = creation.isLoading;
    ref.listen(
      connectionProvider.select((value) => (value.isConnected, value.baseUrl)),
      (previous, next) {
        // A dialog opened for one connection must not submit to another server.
        final route = ModalRoute.of(context);
        if (previous != next && route != null && route.isActive) {
          // Remove this dialog even when its agent menu is the top route.
          Navigator.of(context).removeRoute(route);
        }
      },
    );

    return PopScope(
      canPop: !isLoading,
      child: AlertDialog(
        scrollable: true,
        title: Text(l10n.newSession),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              autofocus: true,
              enabled: !isLoading,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: l10n.sessionTitleLabel),
              onSubmitted: isLoading ? null : (_) => _create(),
            ),
            const SizedBox(height: AppSizing.gapLarge),
            SessionAgentSelector(
              value: _agent,
              onChanged: isLoading
                  ? null
                  : (value) => setState(() => _agent = value),
            ),
            if (creation.hasError) ...[
              const SizedBox(height: AppSizing.gapLarge),
              Semantics(liveRegion: true, child: Text(l10n.createSessionError)),
            ],
          ],
        ),
        actions: [
          AppButton(
            label: l10n.cancel,
            variant: AppButtonVariant.ghost,
            onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          ),
          AppButton(
            label: isLoading ? l10n.creatingSession : l10n.createSession,
            variant: AppButtonVariant.secondary,
            isLoading: isLoading,
            onPressed: _create,
          ),
        ],
      ),
    );
  }
}
