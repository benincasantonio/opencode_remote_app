import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';

import '../../../support/session_test_support.dart';

void main() {
  group('Session Providers', () {
    test(
      'sessionsListProvider returns sessions sorted by updated descending',
      () async {
        final fakeRepo = FakeSessionRepository();
        fakeRepo.sessions = [
          const Session(
            id: 'ses_old',
            slug: 'slug-old',
            projectID: 'global',
            directory: '/dir',
            title: 'Older session',
            version: '1.0',
            time: SessionTime(created: 1000, updated: 2000),
          ),
          const Session(
            id: 'ses_newest',
            slug: 'slug-new',
            projectID: 'global',
            directory: '/dir',
            title: 'Newest session',
            version: '1.0',
            time: SessionTime(created: 1000, updated: 5000),
          ),
          const Session(
            id: 'ses_middle',
            slug: 'slug-mid',
            projectID: 'global',
            directory: '/dir',
            title: 'Middle session',
            version: '1.0',
            time: SessionTime(created: 1000, updated: 3500),
          ),
        ];

        final container = ProviderContainer(
          overrides: [sessionRepositoryProvider.overrideWithValue(fakeRepo)],
        );
        addTearDown(container.dispose);

        final result = await container.read(sessionsListProvider.future);

        expect(result.map((s) => s.id).toList(), [
          'ses_newest',
          'ses_middle',
          'ses_old',
        ]);
      },
    );

    test('sessionStatusesProvider returns the statuses map', () async {
      final fakeRepo = FakeSessionRepository();
      fakeRepo.statuses = {
        'ses_1': const SessionStatus.idle(),
        'ses_2': const SessionStatus.busy(),
      };

      final container = ProviderContainer(
        overrides: [sessionRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      final result = await container.read(sessionStatusesProvider.future);

      expect(result, {
        'ses_1': const SessionStatus.idle(),
        'ses_2': const SessionStatus.busy(),
      });
    });
  });
}
