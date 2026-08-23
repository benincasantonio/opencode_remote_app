import 'package:flutter/material.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/presentation/screens/home/server_status_widget.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ServerStatusWidget)
Widget defaultServerStatusWidget(BuildContext context) {
  final version = context.knobs.stringOrNull(
    label: 'Version',
    initialValue: '0.1.0',
  );
  final unhealthy = context.knobs.boolean(
    label: 'Unhealthy',
    initialValue: false,
  );
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ServerStatusWidget(
      serverIdentity: context.knobs.string(
        label: 'Server identity',
        initialValue: '192.168.1.10:4096',
      ),
      health: version == null
          ? null
          : ServerHealth(healthy: !unhealthy, version: version),
      status: context.knobs.object.dropdown<ConnectionStatus>(
        label: 'Status',
        options: ConnectionStatus.values,
        initialOption: ConnectionStatus.connected,
        labelBuilder: (s) => s.name,
      ),
      healthUnavailable: context.knobs.boolean(
        label: 'Health unavailable',
        initialValue: false,
      ),
      onDisconnect: () async {},
    ),
  );
}
