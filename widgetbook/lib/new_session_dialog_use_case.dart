import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opencode_remote_app/core/utils/context_extensions.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/agent_providers.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/new_session_dialog.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'session_preview.dart';

@widgetbook.UseCase(name: 'Default', type: NewSessionDialog)
Widget newSessionDialog(BuildContext context) {
  final agents = context.knobs.object.dropdown<AgentPreviewState>(
    label: 'Agents',
    options: AgentPreviewState.values,
    labelBuilder: (state) => state.name,
  );
  final creation = context.knobs.object.dropdown<CreationPreviewState>(
    label: 'Creation',
    options: CreationPreviewState.values,
    labelBuilder: (state) => state.name,
  );
  return Center(
    child: OutlinedButton(
      onPressed: () => showDialog<Session>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ProviderScope(
          retry: (_, _) => null,
          overrides: [
            connectionProvider.overrideWithValue(const AppConnectionState()),
            sessionAgentsProvider.overrideWith((ref) => previewAgents(agents)),
            sessionCreationProvider.overrideWith(
              () => PreviewSessionCreation(creation),
            ),
          ],
          child: const NewSessionDialog(),
        ),
      ),
      child: Text(context.l10n.newSession),
    ),
  );
}
