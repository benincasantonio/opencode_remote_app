import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/models.dart';

import 'fixtures.dart';

void main() {
  group('ServerHealth', () {
    test('parses the health fixture', () {
      final health = ServerHealth.fromJson(loadFixtureJson('server_health'));

      expect(health.healthy, isTrue);
      expect(health.version, '1.2.3');
    });

    test('round-trips through toJson', () {
      const health = ServerHealth(healthy: true, version: '9.9.9');
      final restored = ServerHealth.fromJson(health.toJson());

      expect(restored, health);
    });
  });
}
