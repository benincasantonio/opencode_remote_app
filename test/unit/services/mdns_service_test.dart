import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/services/discovered_server.dart';
import 'package:opencode_remote_app/services/mdns_service.dart';

void main() {
  group('DiscoveredServer', () {
    test('equality is based on name, host and port (attributes ignored)', () {
      const a = DiscoveredServer(
        name: 'svc',
        host: '10.0.0.1',
        port: 4096,
        attributes: {'v': '1'},
      );
      const b = DiscoveredServer(
        name: 'svc',
        host: '10.0.0.1',
        port: 4096,
        attributes: {'v': '2'},
      );
      const c = DiscoveredServer(name: 'svc', host: '10.0.0.2', port: 4096);

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode is consistent with equality', () {
      const a = DiscoveredServer(name: 'svc', host: '10.0.0.1', port: 4096);
      const b = DiscoveredServer(name: 'svc', host: '10.0.0.1', port: 4096);
      expect(a.hashCode, equals(b.hashCode));
    });

    test('toString returns a readable format', () {
      const s = DiscoveredServer(name: 'svc', host: '10.0.0.1', port: 4096);
      expect(s.toString(), 'DiscoveredServer(name: svc, host: 10.0.0.1:4096)');
    });
  });

  group('MdnsService', () {
    late _FakeDiscovery fake;
    late MdnsService service;

    setUp(() {
      fake = _FakeDiscovery();
      service = MdnsService(discoveryFactory: (_) => fake);
    });

    tearDown(() async {
      await service.dispose();
      await fake.dispose();
    });

    group('initial state', () {
      test('isDiscovering is false', () {
        expect(service.isDiscovering, isFalse);
      });

      test('discoveredServers is empty', () {
        expect(service.discoveredServers, isEmpty);
      });

      test('discoveredServers returns an unmodifiable list', () {
        expect(
          () => service.discoveredServers.add(
            const DiscoveredServer(name: 'x', host: 'h', port: 1),
          ),
          throwsUnsupportedError,
        );
      });
    });

    group('startDiscovery', () {
      test('calls initialize then start on the underlying discovery', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;
        expect(fake.initializeCalled, isTrue);
        expect(fake.startCalled, isTrue);
        expect(
          fake.callOrder,
          containsAllInOrder(['initialize', 'start']),
        );
      });

      test('returns a broadcast stream (multiple listeners receive events)',
          () async {
        final stream = service.startDiscovery();
        await fake.subscribedCompleter.future;

        final snapshotsA = <List<DiscoveredServer>>[];
        final snapshotsB = <List<DiscoveredServer>>[];
        final subA = stream.listen(snapshotsA.add);
        final subB = stream.listen(snapshotsB.add);

        fake.emit(_resolved('svc', '10.0.0.1', 4096));
        await _pump();

        expect(snapshotsA, hasLength(1));
        expect(snapshotsB, hasLength(1));

        await subA.cancel();
        await subB.cancel();
      });

      test('sets isDiscovering to true', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;
        expect(service.isDiscovering, isTrue);
      });

      test('a second call returns the same broadcast stream (idempotent)',
          () async {
        final a = service.startDiscovery();
        await fake.subscribedCompleter.future;
        final b = service.startDiscovery();
        expect(identical(a, b), isTrue);
        expect(fake.initializeCallCount, 1);
        expect(fake.startCallCount, 1);
      });

      test('emits NetworkException on stream when initialize fails', () async {
        fake.throwOnInitialize = Exception('init-boom');
        final stream = service.startDiscovery();
        await expectLater(
          stream,
          emitsError(isA<NetworkException>()),
        );
        expect(service.isDiscovering, isFalse);
      });

      test('emits NetworkException on stream when start fails', () async {
        fake.throwOnStart = Exception('start-boom');
        final stream = service.startDiscovery();
        await expectLater(
          stream,
          emitsError(isA<NetworkException>()),
        );
        expect(service.isDiscovering, isFalse);
      });

      test('throws StateError after dispose', () async {
        await service.dispose();
        expect(service.startDiscovery, throwsStateError);
      });
    });

    group('event handling', () {
      test('ServiceFoundEvent does not add to discoveredServers', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        fake.emit(
          BonsoirDiscoveryServiceFoundEvent(
            service: BonsoirService.ignoreNorms(
              name: 'svc',
              type: '_opencode._tcp',
              port: 4096,
            ),
          ),
        );
        await _pump();

        expect(service.discoveredServers, isEmpty);
      });

      test('ServiceResolvedEvent adds a DiscoveredServer and emits', () async {
        final stream = service.startDiscovery();
        final snapshots = <List<DiscoveredServer>>[];
        final sub = stream.listen(snapshots.add);
        await fake.subscribedCompleter.future;

        fake.emit(_resolved('svc', '10.0.0.1', 4096));
        await _pump();

        expect(service.discoveredServers, hasLength(1));
        expect(service.discoveredServers.single.host, '10.0.0.1');
        expect(snapshots.last, hasLength(1));

        await sub.cancel();
      });

      test('ServiceResolvedEvent with same key replaces existing entry',
          () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        fake.emit(
          _resolved('svc', '10.0.0.1', 4096, attributes: {'v': '1'}),
        );
        fake.emit(
          _resolved('svc', '10.0.0.1', 4096, attributes: {'v': '2'}),
        );
        await _pump();

        expect(service.discoveredServers, hasLength(1));
        expect(service.discoveredServers.single.attributes['v'], '2');
      });

      test('ServiceUpdatedEvent with resolved host updates entry', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        fake.emit(
          _resolved('svc', '10.0.0.1', 4096, attributes: {'v': '1'}),
        );
        fake.emit(
          BonsoirDiscoveryServiceUpdatedEvent(
            service: BonsoirService.ignoreNorms(
              name: 'svc',
              type: '_opencode._tcp',
              host: '10.0.0.1',
              port: 4096,
              attributes: const {'v': '2'},
            ),
          ),
        );
        await _pump();

        expect(service.discoveredServers.single.attributes['v'], '2');
      });

      test('ServiceUpdatedEvent with null host is ignored', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        fake.emit(
          BonsoirDiscoveryServiceUpdatedEvent(
            service: BonsoirService.ignoreNorms(
              name: 'svc',
              type: '_opencode._tcp',
              port: 4096,
            ),
          ),
        );
        await _pump();

        expect(service.discoveredServers, isEmpty);
      });

      test('ServiceLostEvent removes the entry and emits an empty snapshot',
          () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;
        fake.emit(_resolved('svc', '10.0.0.1', 4096));
        await _pump();

        fake.emit(
          BonsoirDiscoveryServiceLostEvent(
            service: BonsoirService.ignoreNorms(
              name: 'svc',
              type: '_opencode._tcp',
              host: '10.0.0.1',
              port: 4096,
            ),
          ),
        );
        await _pump();

        expect(service.discoveredServers, isEmpty);
      });

      test('ServiceLostEvent with null host falls back to name+port match',
          () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;
        fake.emit(_resolved('svc', '10.0.0.1', 4096));
        await _pump();

        fake.emit(
          BonsoirDiscoveryServiceLostEvent(
            service: BonsoirService.ignoreNorms(
              name: 'svc',
              type: '_opencode._tcp',
              port: 4096,
            ),
          ),
        );
        await _pump();

        expect(service.discoveredServers, isEmpty);
      });

      test('ServiceLostEvent for unknown service is a no-op', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;
        fake.emit(_resolved('known', '10.0.0.1', 4096));
        await _pump();

        fake.emit(
          BonsoirDiscoveryServiceLostEvent(
            service: BonsoirService.ignoreNorms(
              name: 'unknown',
              type: '_opencode._tcp',
              host: '10.0.0.9',
              port: 4096,
            ),
          ),
        );
        await _pump();

        expect(service.discoveredServers, hasLength(1));
      });

      test('ResolveFailedEvent does not crash', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        fake.emit(const BonsoirDiscoveryServiceResolveFailedEvent());
        await _pump();

        expect(service.discoveredServers, isEmpty);
      });

      test('UnknownEvent does not crash', () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        fake.emit(const BonsoirDiscoveryUnknownEvent(id: 'weird'));
        await _pump();

        expect(service.discoveredServers, isEmpty);
      });

      test('stream onError is forwarded via NetworkException', () async {
        final stream = service.startDiscovery();
        final errors = <Object>[];
        final sub = stream.listen(
          (_) {},
          onError: errors.add,
        );
        await fake.subscribedCompleter.future;

        fake.emitError(Exception('underlying-stream-boom'));
        await _pump();

        expect(errors, hasLength(1));
        expect(errors.single, isA<NetworkException>());

        await sub.cancel();
      });
    });

    group('stopDiscovery', () {
      test('calls stop on the discovery and flips isDiscovering to false',
          () async {
        service.startDiscovery();
        await fake.subscribedCompleter.future;

        await service.stopDiscovery();

        expect(fake.stopCalled, isTrue);
        expect(service.isDiscovering, isFalse);
      });

      test('emits an empty snapshot after stopping', () async {
        final stream = service.startDiscovery();
        final snapshots = <List<DiscoveredServer>>[];
        final sub = stream.listen(snapshots.add);
        await fake.subscribedCompleter.future;

        fake.emit(_resolved('svc', '10.0.0.1', 4096));
        await _pump();

        await service.stopDiscovery();
        await _pump();

        expect(snapshots.last, isEmpty);
        expect(service.discoveredServers, isEmpty);

        await sub.cancel();
      });

      test('is a no-op when not currently discovering', () async {
        await service.stopDiscovery();
        expect(fake.stopCalled, isFalse);
      });
    });

    group('dispose', () {
      test('stops active discovery and closes the stream controller',
          () async {
        final stream = service.startDiscovery();
        final sub = stream.listen((_) {});
        await fake.subscribedCompleter.future;

        await service.dispose();

        expect(fake.stopCalled, isTrue);
        expect(service.startDiscovery, throwsStateError);
        await sub.cancel();
      });

      test('is safe to call multiple times', () async {
        await service.dispose();
        await service.dispose();
      });
    });
  });
}

BonsoirDiscoveryServiceResolvedEvent _resolved(
  String name,
  String host,
  int port, {
  Map<String, String> attributes = const {},
}) {
  return BonsoirDiscoveryServiceResolvedEvent(
    service: BonsoirService.ignoreNorms(
      name: name,
      type: '_opencode._tcp',
      host: host,
      port: port,
      attributes: attributes,
    ),
  );
}

/// Yields control so the async event pipeline can process queued events.
Future<void> _pump() => Future<void>.delayed(Duration.zero);

class _FakeServiceResolver with ServiceResolver {
  @override
  Future<void> resolveService(BonsoirService service) async {}
}

class _FakeDiscovery extends Fake implements BonsoirDiscovery {
  _FakeDiscovery() {
    _events = StreamController<BonsoirDiscoveryEvent>.broadcast(
      onListen: () {
        if (!subscribedCompleter.isCompleted) {
          subscribedCompleter.complete();
        }
      },
    );
  }

  late final StreamController<BonsoirDiscoveryEvent> _events;
  final Completer<void> subscribedCompleter = Completer<void>();
  final List<String> callOrder = [];

  int initializeCallCount = 0;
  int startCallCount = 0;
  bool initializeCalled = false;
  bool startCalled = false;
  bool stopCalled = false;

  Object? throwOnInitialize;
  Object? throwOnStart;

  @override
  ServiceResolver get serviceResolver => _FakeServiceResolver();

  @override
  Future<void> initialize() async {
    initializeCallCount++;
    initializeCalled = true;
    callOrder.add('initialize');
    if (throwOnInitialize != null) {
      throw throwOnInitialize!;
    }
  }

  @override
  Future<void> start() async {
    startCallCount++;
    startCalled = true;
    callOrder.add('start');
    if (throwOnStart != null) {
      throw throwOnStart!;
    }
  }

  @override
  Future<void> stop() async {
    stopCalled = true;
    callOrder.add('stop');
  }

  @override
  Stream<BonsoirDiscoveryEvent>? get eventStream => _events.stream;

  void emit(BonsoirDiscoveryEvent event) => _events.add(event);

  void emitError(Object error) => _events.addError(error);

  Future<void> dispose() async {
    if (!_events.isClosed) {
      await _events.close();
    }
  }
}
