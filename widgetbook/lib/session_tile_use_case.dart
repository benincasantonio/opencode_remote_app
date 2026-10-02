import 'package:flutter/material.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_tile.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

enum SessionStatusVariant { idle, busy, retry }

@widgetbook.UseCase(name: 'Default', type: SessionTile)
Widget defaultSessionTile(BuildContext context) {
  final statusVariant = context.knobs.object.dropdown<SessionStatusVariant>(
    label: 'Status',
    options: SessionStatusVariant.values,
    initialOption: SessionStatusVariant.idle,
    labelBuilder: (s) => s.name,
  );

  final status = switch (statusVariant) {
    SessionStatusVariant.idle => const SessionStatus.idle(),
    SessionStatusVariant.busy => const SessionStatus.busy(),
    SessionStatusVariant.retry => const SessionStatus.retry(
      attempt: 1,
      message: 'Rate limit exceeded',
      next: 5000,
    ),
  };

  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Fix auth interceptor and token refresh logic',
  );

  final slug = context.knobs.string(
    label: 'Slug',
    initialValue: 'quick-canyon',
  );

  final directory = context.knobs.string(
    label: 'Directory',
    initialValue: '/Users/developer/projects/app',
  );

  final session = Session(
    id: 'ses_123456789',
    slug: slug,
    projectID: 'global',
    directory: directory,
    title: title,
    version: '1.0.0',
    time: SessionTime(
      created: DateTime.now()
          .subtract(const Duration(hours: 2))
          .millisecondsSinceEpoch,
      updated: DateTime.now()
          .subtract(const Duration(minutes: 5))
          .millisecondsSinceEpoch,
    ),
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: SessionTile(session: session, status: status),
  );
}
