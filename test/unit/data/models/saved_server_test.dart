import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';

void main() {
  group('SavedServer', () {
    test('displayName combines host and port', () {
      const server = SavedServer(id: '1', host: '192.168.1.10', port: 4096);
      expect(server.displayName, '192.168.1.10:4096');
    });

    test('defaults are applied', () {
      const server = SavedServer(id: '1', host: 'h', port: 1);
      expect(server.isDefault, isFalse);
      expect(server.lastConnectedAt, isNull);
    });

    test('toJson/fromJson round-trips all fields', () {
      final server = SavedServer(
        id: 'abc',
        host: 'example.com',
        port: 4096,
        isDefault: true,
        lastConnectedAt: DateTime.utc(2026, 8, 9, 12),
      );
      final roundTrip = SavedServer.fromJson(server.toJson());
      expect(roundTrip, server);
    });

    test('fromJson handles missing optional fields', () {
      final server = SavedServer.fromJson({
        'id': 'abc',
        'host': 'example.com',
        'port': 4096,
      });
      expect(server.isDefault, isFalse);
      expect(server.lastConnectedAt, isNull);
    });
  });
}
