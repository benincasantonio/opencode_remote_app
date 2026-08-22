import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/utils/utils.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';
import 'package:opencode_remote_app/data/repositories/saved_server_repository.dart';
import 'package:opencode_remote_app/domain/providers/saved_server_providers.dart';

import '../../../helpers/fake_saved_server_storage.dart';

/// Flushes the microtask chains of the async repository fakes.
Future<void> settle(ProviderContainer container) async {
  for (var i = 0; i < 50; i++) {
    await container.pump();
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  group('SavedServers', () {
    late FakeServerStorage storage;
    late SavedServerRepository repository;
    late ProviderContainer container;

    setUp(() {
      storage = FakeServerStorage();
      repository = SavedServerRepository(storage, FakeCredentialStorage());
      container = ProviderContainer(
        overrides: [
          savedServerRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
    });

    test('build loads the persisted servers', () async {
      storage.saveAll([SavedServer(id: '1', host: 'a', port: 1)]);
      container.read(savedServersProvider);
      await settle(container);
      final servers = container.read(savedServersProvider).dataOrNull;
      expect(servers, hasLength(1));
      expect(servers?.single.host, 'a');
    });

    test('build exposes an empty list when nothing is saved', () async {
      container.read(savedServersProvider);
      await settle(container);
      expect(container.read(savedServersProvider).dataOrNull, isEmpty);
    });

    test('delete removes the server from state', () async {
      storage.saveAll([SavedServer(id: '1', host: 'a', port: 1)]);
      container.read(savedServersProvider);
      await settle(container);
      await container.read(savedServersProvider.notifier).delete('1');
      container.read(savedServersProvider);
      await settle(container);
      expect(container.read(savedServersProvider).dataOrNull, isEmpty);
    });

    test('setDefault marks the server and clears the others', () async {
      storage.saveAll([
        SavedServer(id: '1', host: 'a', port: 1, isDefault: true),
        SavedServer(id: '2', host: 'b', port: 2),
      ]);
      container.read(savedServersProvider);
      await settle(container);
      await container.read(savedServersProvider.notifier).setDefault('2');
      container.read(savedServersProvider);
      await settle(container);
      final servers = container.read(savedServersProvider).dataOrNull!;
      expect(servers.firstWhere((s) => s.id == '2').isDefault, isTrue);
      expect(servers.firstWhere((s) => s.id == '1').isDefault, isFalse);
    });
  });
}
