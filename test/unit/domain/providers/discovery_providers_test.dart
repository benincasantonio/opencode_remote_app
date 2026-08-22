import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/domain/providers/discovery_providers.dart';
import 'package:opencode_remote_app/services/discovered_server.dart';
import 'package:opencode_remote_app/services/mdns_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeMdnsService fake;

  ProviderContainer makeContainer() {
    fake = _FakeMdnsService();
    final container = ProviderContainer(
      overrides: [mdnsServiceProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('mdnsServiceProvider', () {
    test('constructs a service only when first read', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final service = container.read(mdnsServiceProvider);
      expect(service, isA<MdnsService>());
    });

    test('disposing the container disposes the service', () async {
      final container = ProviderContainer();
      final service = container.read(mdnsServiceProvider);

      container.dispose();
      await container.pump();
      await Future<void>.delayed(Duration.zero);

      expect(service.startDiscovery, throwsStateError);
    });

    test(
      'recreating after disposal creates a fresh service lifecycle',
      () async {
        final container = ProviderContainer();
        final first = container.read(mdnsServiceProvider);
        container.dispose();
        await Future<void>.delayed(Duration.zero);

        final recreated = ProviderContainer();
        addTearDown(recreated.dispose);
        final second = recreated.read(mdnsServiceProvider);

        expect(second, isNot(same(first)));
        expect(second.startDiscovery, isNot(throwsStateError));
      },
    );
  });

  group('discoveredServersProvider', () {
    test(
      'emits an initial empty snapshot before any discovery event',
      () async {
        final container = makeContainer();
        final states = <AsyncValue<List<DiscoveredServer>>>[];
        final sub = container.listen(
          discoveredServersProvider,
          (_, next) => states.add(next),
          fireImmediately: true,
        );
        await container.pump();

        expect(states.last, isA<AsyncData<List<DiscoveredServer>>>());
        expect(states.last.value, isEmpty);
        sub.close();
      },
    );

    test('later fake snapshots reach listeners unchanged', () async {
      final container = makeContainer();
      final states = <List<DiscoveredServer>?>[];
      final sub = container.listen(
        discoveredServersProvider,
        (_, next) => states.add(next.value),
        fireImmediately: true,
      );
      await container.pump();

      const server = DiscoveredServer(
        name: 'opencode-4096',
        host: '10.0.0.5',
        port: 4096,
      );
      fake.controller.add(const [server]);
      await container.pump();

      expect(states.last, hasLength(1));
      expect(states.last!.single.name, 'opencode-4096');
      sub.close();
    });

    test('multiple updates remain observable while watched', () async {
      final container = makeContainer();
      final states = <List<DiscoveredServer>?>[];
      final sub = container.listen(
        discoveredServersProvider,
        (_, next) => states.add(next.value),
        fireImmediately: true,
      );
      await container.pump();

      const a = DiscoveredServer(host: '10.0.0.1', port: 4096, name: 'a');
      const b = DiscoveredServer(host: '10.0.0.2', port: 4096, name: 'b');
      fake.controller.add(const [a]);
      await container.pump();
      fake.controller.add(const [a, b]);
      await container.pump();
      await container.pump();

      final last = states.whereType<List<DiscoveredServer>>().last;
      expect(last, hasLength(2));
      sub.close();
    });

    test('fake stream errors become AsyncError', () async {
      final container = makeContainer();
      final states = <AsyncValue<List<DiscoveredServer>>>[];
      final sub = container.listen(
        discoveredServersProvider,
        (_, next) => states.add(next),
        fireImmediately: true,
      );
      await container.pump();

      fake.controller.addError(Exception('boom'));
      await container.pump();

      expect(
        states.any((s) => s is AsyncError<List<DiscoveredServer>>),
        isTrue,
      );
      sub.close();
    });
  });
}

class _FakeMdnsService extends Fake implements MdnsService {
  final StreamController<List<DiscoveredServer>> controller =
      StreamController<List<DiscoveredServer>>.broadcast();
  int startCalls = 0;
  bool disposed = false;

  @override
  bool get isDiscovering => false;

  @override
  List<DiscoveredServer> get discoveredServers => const [];

  @override
  Stream<List<DiscoveredServer>> startDiscovery() {
    startCalls++;
    return controller.stream;
  }

  @override
  Future<void> stopDiscovery() async {}

  @override
  Future<void> dispose() async {
    disposed = true;
    await controller.close();
  }
}
