import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_badge.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ConnectionBadge)
Widget defaultConnectionBadge(BuildContext context) {
  return ConnectionBadge(
    status: context.knobs.object.dropdown<ConnectionStatus>(
      label: 'Status',
      options: ConnectionStatus.values,
      initialOption: ConnectionStatus.connected,
      labelBuilder: (s) => s.name,
    ),
    serverName: context.knobs.stringOrNull(
      label: 'Server name',
      initialValue: 'my-workstation',
    ),
  );
}
