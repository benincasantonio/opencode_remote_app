import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/context_extensions.dart';
import '../../../data/models/session.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/session_providers.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import '../../widgets/loading_indicator/loading_indicator_size.dart';

class SessionDeleteButton extends ConsumerWidget {
  const SessionDeleteButton({super.key, required this.session});

  final Session session;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final connection = ref.read(connectionProvider);
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(l10n.deleteSession),
        content: Text(
          l10n.deleteSessionConfirmation(
            session.title.trim().isEmpty ? session.slug : session.title,
          ),
        ),
        actions: [
          AppButton(
            label: l10n.cancel,
            variant: AppButtonVariant.ghost,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          AppButton(
            label: l10n.deleteSession,
            variant: AppButtonVariant.destructive,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (!context.mounted || confirmed != true) return;
    // A confirmation for one server must never delete from another server.
    final current = ref.read(connectionProvider);
    if (current.baseUrl != connection.baseUrl || !current.isConnected) return;
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(sessionDeletionProvider(session.id).notifier)
        .delete();
    if (result == null || !messenger.mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(result ? l10n.sessionDeleted : l10n.deleteSessionError),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletion = ref.watch(sessionDeletionProvider(session.id));
    return IconButton(
      tooltip: context.l10n.deleteSession,
      onPressed: deletion.isLoading || deletion.value == true
          ? null
          : () => _delete(context, ref),
      icon: deletion.isLoading
          ? const LoadingIndicator(size: LoadingIndicatorSize.small)
          : const Icon(Icons.delete_outline),
    );
  }
}
