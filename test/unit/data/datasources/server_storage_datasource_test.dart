import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_storage_datasource.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ServerStorageDatasource', () {
    late ServerStorageDatasource datasource;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      datasource = ServerStorageDatasource();
    });

    test('getAll returns empty when nothing was saved', () async {
      expect(await datasource.getAll(), isEmpty);
    });

    test('saveAll then getAll round-trips', () async {
      final server = SavedServer(
        id: '1',
        host: 'example.com',
        port: 4096,
        isDefault: true,
      );
      await datasource.saveAll([server]);
      expect(await datasource.getAll(), [server]);
    });

    test('saveAll replaces the previous list', () async {
      await datasource.saveAll([
        SavedServer(id: '1', host: 'a', port: 1),
      ]);
      await datasource.saveAll([
        SavedServer(id: '2', host: 'b', port: 2),
        SavedServer(id: '3', host: 'c', port: 3),
      ]);
      final servers = await datasource.getAll();
      expect(servers.map((s) => s.id), ['2', '3']);
    });

    test('corrupted payload throws CacheException', () async {
      SharedPreferences.setMockInitialValues({'saved_servers_v1': 'nope'});
      expect(
        () => datasource.getAll(),
        throwsA(isA<CacheException>()),
      );
    });

    test('malformed list entry throws CacheException', () async {
      SharedPreferences.setMockInitialValues({
        'saved_servers_v1': '[{"host": "missing-fields"}]',
      });
      expect(
        () => datasource.getAll(),
        throwsA(isA<CacheException>()),
      );
    });
  });
}
