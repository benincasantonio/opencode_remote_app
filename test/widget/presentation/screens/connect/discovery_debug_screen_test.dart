import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/connect/discovery_debug_screen.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/services/mdns_service.dart';

void main() {
  group('DiscoveryDebugScreen', () {
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

    Future<void> pumpScreen(
      WidgetTester tester, {
      List<dynamic> overrides = const [],
    }) {
      return tester.pumpWidget(
        ProviderScope(
          overrides: [...overrides],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DiscoveryDebugScreen(mdns: service),
          ),
        ),
      );
    }

    Future<void> discoverServer(WidgetTester tester) async {
      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(
        fake.isSubscribed,
        isTrue,
        reason: 'listener should attach after the initialize microtask flushes',
      );
      fake.emit(_resolved('office-server', '10.0.0.5', 4096));
      await tester.pumpAndSettle();
    }

    testWidgets('lists discovered servers after starting discovery', (
      tester,
    ) async {
      await pumpScreen(tester);
      await discoverServer(tester);

      expect(find.text('office-server'), findsOneWidget);
      expect(find.text('10.0.0.5:4096'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    testWidgets('tapping a server connects to it and pops the screen', (
      tester,
    ) async {
      final recording = _RecordingConnection();
      await pumpScreen(tester, overrides: [
        connectionProvider.overrideWith(() => recording),
      ]);
      await discoverServer(tester);

      await tester.tap(find.text('office-server'));
      await tester.pumpAndSettle();

      expect(recording.lastConnect?.host, '10.0.0.5');
      expect(recording.lastConnect?.port, 4096);
      expect(find.byType(DiscoveryDebugScreen), findsNothing);
    });

    testWidgets('failed connect stays on the screen with an error snackbar', (
      tester,
    ) async {
      final failing = _FailingConnection();
      await pumpScreen(tester, overrides: [
        connectionProvider.overrideWith(() => failing),
      ]);
      await discoverServer(tester);

      await tester.tap(find.text('office-server'));
      await tester.pumpAndSettle();

      expect(
        find.text('Could not reach the server. Check host and port.'),
        findsOneWidget,
      );
      expect(find.byType(DiscoveryDebugScreen), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}

BonsoirDiscoveryServiceResolvedEvent _resolved(
  String name,
  String host,
  int port,
) {
  return BonsoirDiscoveryServiceResolvedEvent(
    service: BonsoirService.ignoreNorms(
      name: name,
      type: '_http._tcp',
      host: host,
      port: port,
    ),
  );
}

class _RecordingConnection extends Connection {
  ({String host, int port})? lastConnect;

  @override
  AppConnectionState build() => const AppConnectionState();

  @override
  Future<void> connect({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    lastConnect = (host: host, port: port);
  }
}

class _FailingConnection extends Connection {
  @override
  AppConnectionState build() => const AppConnectionState();

  @override
  Future<void> connect({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    state = AppConnectionState(
      status: ConnectionStatus.error,
      error: const NetworkException('Connection refused'),
    );
  }
}

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

  bool get isSubscribed => subscribedCompleter.isCompleted;

  @override
  ServiceResolver get serviceResolver => _FakeServiceResolver();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> start() async {}

  @override
  Future<void> stop() async {}

  @override
  Stream<BonsoirDiscoveryEvent>? get eventStream => _events.stream;

  void emit(BonsoirDiscoveryEvent event) => _events.add(event);

  Future<void> dispose() async {
    if (!_events.isClosed) {
      await _events.close();
    }
  }
}
