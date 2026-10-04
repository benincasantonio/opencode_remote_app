import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';

import '../../../support/session_test_support.dart';

void main() {
  late FakeSessionRepository repository;
  late ProviderContainer container;
  final provider = sessionDeletionProvider(createdSession.id);
  setUp(() async {
    repository = FakeSessionRepository()..sessions = [createdSession];
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        sessionRepositoryProvider.overrideWithValue(repository),
      ],
    );
    container.listen(provider, (_, _) {});
    container.listen(sessionsListProvider, (_, _) {});
    await container.read(provider.future);
    await container.read(sessionsListProvider.future);
  });
  tearDown(() => container.dispose());

  test('success refreshes list and ignores repeated deletion', () async {
    expect(await container.read(provider.notifier).delete(), isTrue);
    expect(await container.read(sessionsListProvider.future), isEmpty);
    expect(await container.read(provider.notifier).delete(), isNull);
    expect(repository.deletedIds, [createdSession.id]);
    expect(repository.listCalls, 2);
  });

  test('failure preserves list and supports explicit retry', () async {
    repository.deleteError = const NetworkException('offline');
    expect(await container.read(provider.notifier).delete(), isFalse);
    expect(container.read(provider).hasError, isTrue);
    expect(await container.read(sessionsListProvider.future), [createdSession]);
    expect(repository.listCalls, 1);
    repository.deleteError = null;
    expect(await container.read(provider.notifier).delete(), isTrue);
  });

  test('pending deletion blocks duplicate requests', () async {
    final pending = Completer<void>();
    repository.pendingDeletion = pending.future;
    final request = container.read(provider.notifier).delete();
    expect(container.read(provider).isLoading, isTrue);
    expect(await container.read(provider.notifier).delete(), isNull);
    pending.complete();
    expect(await request, isTrue);
    expect(repository.deletedIds, [createdSession.id]);
  });

  test('server change cancels request and ignores late success', () async {
    final pending = Completer<void>();
    repository.pendingDeletion = pending.future;
    final request = container.read(provider.notifier).delete();
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await container.pump();
    expect(repository.deletionToken?.isCancelled, isTrue);
    pending.complete();
    expect(await request, isNull);
    expect(container.read(provider).value, isFalse);
    expect(repository.listCalls, 1);
  });

  test('disposed action ignores a late error', () async {
    final pending = Completer<void>();
    repository.pendingDeletion = pending.future;
    final request = container.read(provider.notifier).delete();
    container.invalidate(provider);
    pending.completeError(const NetworkException('offline'));
    expect(await request, isNull);
    expect(repository.deletionToken?.isCancelled, isTrue);
  });

  test('list refresh error does not repeat a successful deletion', () async {
    repository.listError = const NetworkException('refresh failed');
    expect(await container.read(provider.notifier).delete(), isTrue);
    await expectLater(
      container.read(sessionsListProvider.future),
      throwsA(isA<NetworkException>()),
    );
    expect(container.read(provider).hasError, isFalse);
    expect(repository.deletedIds, [createdSession.id]);
  });
}
