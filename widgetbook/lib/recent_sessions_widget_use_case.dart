import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/core/utils/context_extensions.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/presentation/screens/home/recent_sessions_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

enum RecentSessionsPreviewState { ready, empty, loading, error }

@widgetbook.UseCase(name: 'Default', type: RecentSessionsWidget)
Widget recentSessionsWidget(BuildContext context) {
  final state = context.knobs.object.dropdown<RecentSessionsPreviewState>(
    label: 'Sessions',
    options: RecentSessionsPreviewState.values,
    labelBuilder: (state) => state.name,
  );
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Fix authentication',
  );
  return ProviderScope(
    key: ValueKey((state, title)),
    retry: (_, _) => null,
    overrides: [
      sessionsListProvider.overrideWith(
        (ref) => switch (state) {
          RecentSessionsPreviewState.empty => [],
          RecentSessionsPreviewState.loading =>
            Completer<List<Session>>().future,
          RecentSessionsPreviewState.error => throw const NetworkException(
            'Preview error',
          ),
          RecentSessionsPreviewState.ready => [
            for (var i = 0; i < 5; i++)
              Session(
                id: 'preview_$i',
                slug: 'preview-$i',
                title: '$title $i',
                directory: '/project',
                projectID: 'global',
                version: '1',
                time: SessionTime(
                  created: 0,
                  updated: DateTime.now()
                      .subtract(Duration(minutes: i + 1))
                      .millisecondsSinceEpoch,
                ),
              ),
          ],
        },
      ),
    ],
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizing.gapLarge),
      child: RecentSessionsWidget(
        onViewAll: () => context.showSnackBar(context.l10n.viewAllSessions),
        onNewSession: () => context.showSnackBar(context.l10n.newSession),
      ),
    ),
  );
}
