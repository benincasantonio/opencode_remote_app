import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/presentation/screens/home/server_status_widget.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

import '../../../../helpers/pump_with_l10n.dart';

void main() {
  const healthy = ServerHealth(healthy: true, version: '1.2.3');
  const unhealthy = ServerHealth(healthy: false, version: '1.2.3');

  testWidgets('renders identity, healthy text, and version', (tester) async {
    await pumpWidgetWithL10n(
      tester,
      const _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: healthy,
          status: ConnectionStatus.connected,
          healthUnavailable: false,
          onDisconnect: _noopDisconnect,
        ),
      ),
    );

    expect(find.text('192.168.1.10:4096'), findsOneWidget);
    expect(find.text('Healthy'), findsOneWidget);
    expect(find.text('Version 1.2.3'), findsOneWidget);
    expect(find.text('Health information unavailable'), findsNothing);
  });

  testWidgets('renders the explicit unhealthy state', (tester) async {
    await pumpWidgetWithL10n(
      tester,
      const _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: unhealthy,
          status: ConnectionStatus.unhealthy,
          healthUnavailable: false,
          onDisconnect: _noopDisconnect,
        ),
      ),
    );

    expect(find.text('Unhealthy'), findsNWidgets(2));
    expect(find.text('Version 1.2.3'), findsOneWidget);
  });

  testWidgets(
    'renders Error plus unavailable copy while retaining the last-known '
    'version',
    (tester) async {
      await pumpWidgetWithL10n(
        tester,
        const _StatusHost(
          child: ServerStatusWidget(
            serverIdentity: '192.168.1.10:4096',
            health: unhealthy,
            status: ConnectionStatus.error,
            healthUnavailable: true,
            onDisconnect: _noopDisconnect,
          ),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Health information unavailable'), findsOneWidget);
      expect(find.text('Version 1.2.3'), findsOneWidget);
    },
  );

  testWidgets('omits the version when no successful health is available', (
    tester,
  ) async {
    await pumpWidgetWithL10n(
      tester,
      const _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: null,
          status: ConnectionStatus.error,
          healthUnavailable: true,
          onDisconnect: _noopDisconnect,
        ),
      ),
    );

    expect(find.textContaining('Version'), findsNothing);
    expect(find.text('Health information unavailable'), findsOneWidget);
  });

  testWidgets('disconnect opens the confirmation dialog', (tester) async {
    await pumpWidgetWithL10n(
      tester,
      const _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: healthy,
          status: ConnectionStatus.connected,
          healthUnavailable: false,
          onDisconnect: _noopDisconnect,
        ),
      ),
    );

    await tester.tap(find.widgetWithText(AppButton, 'Disconnect'));
    await tester.pumpAndSettle();

    expect(find.text('Disconnect from server?'), findsOneWidget);
    expect(
      find.text(
        'Disconnect from 192.168.1.10:4096? '
        'The server will remain saved for quick reconnect.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('cancel does not call onDisconnect', (tester) async {
    var calls = 0;
    await pumpWidgetWithL10n(
      tester,
      _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: healthy,
          status: ConnectionStatus.connected,
          healthUnavailable: false,
          onDisconnect: () async => calls++,
        ),
      ),
    );

    await tester.tap(find.widgetWithText(AppButton, 'Disconnect'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(AppButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Disconnect from server?'), findsNothing);
    expect(calls, 0);
  });

  testWidgets('barrier dismissal does not call onDisconnect', (tester) async {
    var calls = 0;
    await pumpWidgetWithL10n(
      tester,
      _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: healthy,
          status: ConnectionStatus.connected,
          healthUnavailable: false,
          onDisconnect: () async => calls++,
        ),
      ),
    );

    await tester.tap(find.widgetWithText(AppButton, 'Disconnect'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.text('Disconnect from server?'), findsNothing);
    expect(calls, 0);
  });

  testWidgets('confirm calls onDisconnect exactly once', (tester) async {
    var calls = 0;
    await pumpWidgetWithL10n(
      tester,
      _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: '192.168.1.10:4096',
          health: healthy,
          status: ConnectionStatus.connected,
          healthUnavailable: false,
          onDisconnect: () async => calls++,
        ),
      ),
    );

    await tester.tap(find.widgetWithText(AppButton, 'Disconnect'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(AppButton, 'Disconnect').last);
    await tester.pumpAndSettle();

    expect(find.text('Disconnect from server?'), findsNothing);
    expect(calls, 1);
  });

  testWidgets('long identities do not overflow on a narrow viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpWidgetWithL10n(
      tester,
      const _StatusHost(
        child: ServerStatusWidget(
          serverIdentity: 'my-very-long-server-name.mycompany.internal:4096',
          health: healthy,
          status: ConnectionStatus.connected,
          healthUnavailable: false,
          onDisconnect: _noopDisconnect,
        ),
      ),
    );

    expect(
      find.text('my-very-long-server-name.mycompany.internal:4096'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}

Future<void> _noopDisconnect() async {}

class _StatusHost extends StatelessWidget {
  const _StatusHost({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: child));
  }
}
