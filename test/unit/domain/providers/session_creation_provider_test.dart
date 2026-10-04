import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';

import '../../../support/session_test_support.dart';

void main() {
  late FakeSessionRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeSessionRepository();
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        sessionRepositoryProvider.overrideWithValue(repository),
      ],
    );
    container.listen(sessionCreationProvider, (_, _) {});
    container.listen(sessionsListProvider, (_, _) {});
  });
  tearDown(() => container.dispose());

  test(
    'creation updates state and refreshes sessions only after success',
    () async {
      expect(await container.read(sessionsListProvider.future), isEmpty);
      await container.read(sessionCreationProvider.future);
      const input = CreateSessionInput(title: 'New', agent: 'build');
      final result = await container
          .read(sessionCreationProvider.notifier)
          .create(input);
      expect(result, createdSession);
      expect(repository.inputs, [input]);
      expect(container.read(sessionCreationProvider).value, createdSession);
      expect(await container.read(sessionsListProvider.future), [
        createdSession,
      ]);
      expect(repository.listCalls, 2);
    },
  );

  test('ignores concurrent submissions while a POST is pending', () async {
    final pending = Completer<Session>();
    repository.pendingCreation = pending.future;
    await container.read(sessionCreationProvider.future);
    final notifier = container.read(sessionCreationProvider.notifier);
    final request = notifier.create(const CreateSessionInput());
    expect(container.read(sessionCreationProvider).isLoading, isTrue);
    expect(await notifier.create(const CreateSessionInput()), isNull);
    expect(repository.inputs, hasLength(1));
    pending.complete(createdSession);
    expect(await request, createdSession);
  });

  test(
    'failure retains list, exposes error, and permits explicit retry',
    () async {
      await container.read(sessionsListProvider.future);
      await container.read(sessionCreationProvider.future);
      const error = NetworkException('offline');
      repository.createError = error;
      final notifier = container.read(sessionCreationProvider.notifier);
      expect(await notifier.create(const CreateSessionInput()), isNull);
      expect(container.read(sessionCreationProvider).error, same(error));
      await container.pump();
      expect(repository.listCalls, 1);
      expect(repository.inputs, hasLength(1));
      repository.createError = null;
      expect(await notifier.create(const CreateSessionInput()), createdSession);
      expect(repository.inputs, hasLength(2));
    },
  );

  test(
    'refresh failure does not turn a successful POST into creation failure',
    () async {
      await container.read(sessionsListProvider.future);
      await container.read(sessionCreationProvider.future);
      repository.listError = const NetworkException('refresh failed');
      expect(
        await container
            .read(sessionCreationProvider.notifier)
            .create(const CreateSessionInput()),
        createdSession,
      );
      await expectLater(
        container.read(sessionsListProvider.future),
        throwsA(isA<NetworkException>()),
      );
      expect(container.read(sessionCreationProvider).hasError, isFalse);
      expect(repository.inputs, hasLength(1));
    },
  );

  test('server change cancels pending work and ignores late success', () async {
    final pending = Completer<Session>();
    repository.pendingCreation = pending.future;
    await container.read(sessionsListProvider.future);
    await container.read(sessionCreationProvider.future);
    final request = container
        .read(sessionCreationProvider.notifier)
        .create(const CreateSessionInput());
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await container.pump();
    expect(repository.creationToken?.isCancelled, isTrue);
    pending.complete(createdSession);
    expect(await request, isNull);
    expect(container.read(sessionCreationProvider).value, isNull);
    expect(repository.listCalls, 1);
  });

  test(
    'disposing the action ignores a late failure without updating state',
    () async {
      final pending = Completer<Session>();
      repository.pendingCreation = pending.future;
      await container.read(sessionCreationProvider.future);
      final request = container
          .read(sessionCreationProvider.notifier)
          .create(const CreateSessionInput());
      container.invalidate(sessionCreationProvider);
      expect(repository.creationToken?.isCancelled, isTrue);
      pending.completeError(const NetworkException('late failure'));
      expect(await request, isNull);
      await container.pump();
      expect(container.read(sessionCreationProvider).hasError, isFalse);
    },
  );
}
