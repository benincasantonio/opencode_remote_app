import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/discovery_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/connect/discovered_servers_list.dart';
import 'package:opencode_remote_app/presentation/screens/connect/_discovered_server_tile.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/services/discovered_server.dart';

void main() {
  Future<void> pump(WidgetTester tester, {required List<dynamic> overrides}) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [...overrides],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(child: DiscoveredServersList()),
          ),
        ),
      ),
    );
  }

  Stream<List<DiscoveredServer>> streamOf(List<DiscoveredServer> snapshot) {
    return Stream.value(snapshot);
  }

  testWidgets('loading stream shows the searching message', (tester) async {
    final controller = StreamController<List<DiscoveredServer>>();
    addTearDown(controller.close);

    await pump(
      tester,
      overrides: [
        connectionProvider.overrideWithValue(const AppConnectionState()),
        discoveredServersProvider.overrideWith((ref) => controller.stream),
      ],
    );
    await tester.pump();

    expect(find.text('Searching for servers…'), findsOneWidget);
    expect(find.byType(DiscoveredServerTile), findsNothing);
  });

  testWidgets('empty snapshot shows the searching message', (tester) async {
    await pump(
      tester,
      overrides: [
        connectionProvider.overrideWithValue(const AppConnectionState()),
        discoveredServersProvider.overrideWith(
          (ref) => streamOf(const <DiscoveredServer>[]),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('Searching for servers…'), findsOneWidget);
  });

  testWidgets('rows show name and host:port, but not TXT attributes', (
    tester,
  ) async {
    await pump(
      tester,
      overrides: [
        connectionProvider.overrideWithValue(const AppConnectionState()),
        discoveredServersProvider.overrideWith(
          (ref) => streamOf(const [
            DiscoveredServer(
              name: 'opencode-4096',
              host: '10.0.0.5',
              port: 4096,
              attributes: {'version': '1.2.3'},
            ),
          ]),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('opencode-4096'), findsOneWidget);
    expect(find.text('10.0.0.5:4096'), findsOneWidget);
    expect(find.textContaining('version'), findsNothing);
  });

  testWidgets(
    'rows are sorted case-insensitively with host/port tie-breakers',
    (tester) async {
      await pump(
        tester,
        overrides: [
          connectionProvider.overrideWithValue(const AppConnectionState()),
          discoveredServersProvider.overrideWith(
            (ref) => streamOf(const [
              DiscoveredServer(host: '10.0.0.2', port: 1, name: 'beta'),
              DiscoveredServer(host: '10.0.0.1', port: 5, name: 'ALPHA'),
              DiscoveredServer(host: '10.0.0.1', port: 3, name: 'alpha'),
              DiscoveredServer(host: '10.0.0.1', port: 9, name: 'alpha'),
              DiscoveredServer(host: '10.0.0.3', port: 80, name: 'gamma'),
            ]),
          ),
        ],
      );
      await tester.pumpAndSettle();

      final rows = tester
          .widgetList<DiscoveredServerTile>(find.byType(DiscoveredServerTile))
          .toList();
      final displayed = rows.map((t) => '${t.server.host}:${t.server.port}');
      expect(displayed, [
        '10.0.0.1:3',
        '10.0.0.1:5',
        '10.0.0.1:9',
        '10.0.0.2:1',
        '10.0.0.3:80',
      ]);
    },
  );

  testWidgets(
    'tapping a row connects with its host and port and no credentials',
    (tester) async {
      final recording = _RecordingConnection();
      await pump(
        tester,
        overrides: [
          connectionProvider.overrideWith(() => recording),
          discoveredServersProvider.overrideWith(
            (ref) => streamOf(const [
              DiscoveredServer(
                name: 'opencode-4096',
                host: '10.0.0.5',
                port: 4096,
              ),
            ]),
          ),
        ],
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('opencode-4096'));
      await tester.pumpAndSettle();

      expect(recording.lastConnect?.host, '10.0.0.5');
      expect(recording.lastConnect?.port, 4096);
      expect(recording.lastConnect?.username, isNull);
      expect(recording.lastConnect?.password, isNull);
    },
  );

  testWidgets('rows are disabled while connection status is connecting', (
    tester,
  ) async {
    await pump(
      tester,
      overrides: [
        connectionProvider.overrideWithValue(
          const AppConnectionState(status: ConnectionStatus.connecting),
        ),
        discoveredServersProvider.overrideWith(
          (ref) => streamOf(const [
            DiscoveredServer(
              name: 'opencode-4096',
              host: '10.0.0.5',
              port: 4096,
            ),
          ]),
        ),
      ],
    );
    await tester.pumpAndSettle();

    final tile = tester.widget<DiscoveredServerTile>(
      find.byType(DiscoveredServerTile),
    );
    expect(tile.onTap, isNull);
  });

  testWidgets('stream failure renders actionable error and Retry restarts', (
    tester,
  ) async {
    var calls = 0;
    await pump(
      tester,
      overrides: [
        connectionProvider.overrideWithValue(const AppConnectionState()),
        discoveredServersProvider.overrideWith((ref) {
          calls++;
          if (calls == 1) {
            return Stream.error(Exception('boom'));
          }
          return streamOf(const <DiscoveredServer>[]);
        }),
      ],
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'LAN discovery is unavailable. Check local network access and try again.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Retry'));
    await tester.pumpAndSettle();

    expect(calls, 2);
    expect(find.text('Searching for servers…'), findsOneWidget);
  });

  testWidgets('enabled rows expose control semantics with visible text', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();

    await pump(
      tester,
      overrides: [
        connectionProvider.overrideWithValue(const AppConnectionState()),
        discoveredServersProvider.overrideWith(
          (ref) => streamOf(const [
            DiscoveredServer(
              name: 'opencode-4096',
              host: '10.0.0.5',
              port: 4096,
            ),
          ]),
        ),
      ],
    );
    await tester.pumpAndSettle();

    final semantics = tester.getSemantics(find.byType(DiscoveredServerTile));
    expect(semantics, isSemantics(hasTapAction: true));
    expect(semantics.label, contains('opencode-4096'));
    expect(semantics.label, contains('10.0.0.5:4096'));
    handle.dispose();
  });
}

class _RecordingConnection extends Connection {
  ({String host, int port, String? username, String? password})? lastConnect;

  @override
  AppConnectionState build() => const AppConnectionState();

  @override
  Future<void> connect({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    lastConnect = (
      host: host,
      port: port,
      username: username,
      password: password,
    );
  }
}
