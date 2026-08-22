import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/datasources/credential_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  final store = <String, String>{};

  group('SecureCredentialStorage', () {
    late SecureCredentialStorage storage;

    setUp(() {
      store.clear();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        final args = call.arguments as Map<Object?, Object?>;
        switch (call.method) {
          case 'read':
            return store[args['key'] as String?];
          case 'write':
            store[args['key'] as String] = args['value'] as String;
            return null;
          case 'delete':
            store.remove(args['key'] as String);
            return null;
          default:
            return null;
        }
      });
      storage = SecureCredentialStorage();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('get returns null when nothing is stored', () async {
      expect(await storage.get('server-1'), isNull);
    });

    test('save then get returns credentials', () async {
      await storage.save('server-1', (username: 'u', password: 'p'));
      final credentials = await storage.get('server-1');
      expect(credentials?.username, 'u');
      expect(credentials?.password, 'p');
    });

    test('save ignores null fields', () async {
      await storage.save('server-1', (username: 'u', password: null));
      final credentials = await storage.get('server-1');
      expect(credentials?.username, 'u');
      expect(credentials?.password, isNull);
    });

    test('credentials are scoped per server id', () async {
      await storage.save('server-1', (username: 'u1', password: 'p1'));
      await storage.save('server-2', (username: 'u2', password: 'p2'));
      expect((await storage.get('server-1'))?.username, 'u1');
      expect((await storage.get('server-2'))?.username, 'u2');
    });

    test('delete removes stored credentials', () async {
      await storage.save('server-1', (username: 'u', password: 'p'));
      await storage.delete('server-1');
      expect(await storage.get('server-1'), isNull);
    });
  });
}
