import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_delete_button.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'session_preview.dart';

@widgetbook.UseCase(name: 'Default', type: SessionDeleteButton)
Widget sessionDeleteButton(BuildContext context) {
  final result = context.knobs.object.dropdown<CreationPreviewState>(
    label: 'Deletion',
    options: CreationPreviewState.values,
    labelBuilder: (state) => state.name,
  );
  return ProviderScope(
    overrides: [
      connectionProvider.overrideWithValue(
        const AppConnectionState(
          status: ConnectionStatus.connected,
          baseUrl: 'http://preview',
        ),
      ),
      sessionDeletionProvider(
        'preview',
      ).overrideWith(() => PreviewSessionDeletion(result)),
    ],
    child: const Scaffold(
      body: Center(
        child: SessionDeleteButton(
          session: Session(
            id: 'preview',
            slug: 'preview',
            projectID: 'global',
            directory: '/project',
            title: 'Example session',
            version: '1',
            time: SessionTime(created: 0, updated: 0),
          ),
        ),
      ),
    ),
  );
}
