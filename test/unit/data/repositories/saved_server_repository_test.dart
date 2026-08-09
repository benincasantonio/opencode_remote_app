import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';
import 'package:opencode_remote_app/data/repositories/saved_server_repository.dart';

import '../../../helpers/fake_saved_server_storage.dart';

void main() {
  group('SavedServerRepository', () {
    late FakeServerStorage storage;
    late FakeCredentialStorage credentials;
    late SavedServerRepository repository;

    SavedServer server({
      String id = '1',
      String host = 'example.com',
      int port = 4096,
      bool isDefault = false,
      DateTime? lastConnectedAt,
    }) {
      return SavedServer(
        id: id,
        host: host,
        port: port,
        isDefault: isDefault,
        lastConnectedAt: lastConnectedAt,
      );
    }

    setUp(() {
      storage = FakeServerStorage();
      credentials = FakeCredentialStorage();
      repository = SavedServerRepository(storage, credentials);
    });

    group('getAll', () {
      test('returns empty when nothing is saved', () async {
        expect(await repository.getAll(), isEmpty);
      });

      test('returns saved servers', () async {
        final saved = server();
        storage.saveAll([saved]);
        expect(await repository.getAll(), [saved]);
      });
    });

    group('getDefault', () {
      test('returns null when nothing is saved', () async {
        expect(await repository.getDefault(), isNull);
      });

      test('returns the explicitly marked default', () async {
        storage.saveAll([
          server(id: 'a', isDefault: false),
          server(id: 'b', isDefault: true),
        ]);
        expect((await repository.getDefault())?.id, 'b');
      });

      test('falls back to the most recently connected when no default', () async {
        storage.saveAll([
          server(id: 'old', lastConnectedAt: DateTime(2026, 1, 1)),
          server(id: 'new', lastConnectedAt: DateTime(2026, 8, 1)),
        ]);
        expect((await repository.getDefault())?.id, 'new');
      });
    });

    group('save', () {
      test('creates a new server and stores credentials', () async {
        final saved = await repository.save(
          host: '  example.com ',
          port: 4096,
          username: 'u',
          password: 'p',
        );
        expect(saved.host, 'example.com');
        expect(saved.isDefault, isTrue, reason: 'first saved server');
        expect(await repository.getAll(), [saved]);
        expect((await repository.getCredentials(saved.id))?.username, 'u');
        expect((await repository.getCredentials(saved.id))?.password, 'p');
      });

      test('upserts by host:port keeping id and credentials', () async {
        await repository.save(host: 'a', port: 1, username: 'u', password: 'p');
        final updated = await repository.save(
          host: 'a',
          port: 1,
          username: 'u2',
          password: 'p2',
        );
        expect((await repository.getAll()).length, 1);
        expect((await repository.getAll()).single.id, updated.id);
        expect((await repository.getCredentials(updated.id))?.username, 'u2');
      });

      test('does not make a new default when one exists', () async {
        await repository.save(host: 'a', port: 1);
        await repository.save(host: 'b', port: 2);
        final servers = await repository.getAll();
        expect(servers.first.isDefault, isTrue);
        expect(servers.last.isDefault, isFalse);
      });

      test('clears stored credentials when connecting without auth', () async {
        final saved = await repository.save(
          host: 'a',
          port: 1,
          username: 'u',
          password: 'p',
        );
        await repository.save(host: 'a', port: 1);
        expect(await repository.getCredentials(saved.id), isNull);
      });
    });

    group('delete', () {
      test('removes server and credentials', () async {
        final saved = await repository.save(
          host: 'a',
          port: 1,
          username: 'u',
          password: 'p',
        );
        await repository.delete(saved.id);
        expect(await repository.getAll(), isEmpty);
        expect(await repository.getCredentials(saved.id), isNull);
      });

      test('promotes the first remaining server when deleting the default',
          () async {
        await repository.save(host: 'a', port: 1);
        await repository.save(host: 'b', port: 2);
        final servers = await repository.getAll();
        await repository.delete(servers.first.id);
        final remaining = await repository.getAll();
        expect(remaining.single.isDefault, isTrue);
      });
    });

    group('setDefault', () {
      test('marks the given server and clears the others', () async {
        await repository.save(host: 'a', port: 1);
        await repository.save(host: 'b', port: 2);
        await repository.save(host: 'c', port: 3);
        final servers = await repository.getAll();
        await repository.setDefault(servers.last.id);
        final updated = await repository.getAll();
        expect(updated.where((s) => s.isDefault).map((s) => s.id), [
          servers.last.id,
        ]);
      });
    });
  });
}
