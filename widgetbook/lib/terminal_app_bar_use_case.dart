import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/app_bar/terminal_app_bar.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TerminalAppBar)
Widget defaultTerminalAppBar(BuildContext context) {
  return Scaffold(
    appBar: TerminalAppBar(
      title: context.knobs.string(
        label: 'Title',
        initialValue: 'OpenCode Remote',
      ),
      showConnectionBadge: context.knobs.boolean(
        label: 'Show connection badge',
        initialValue: true,
      ),
      connectionStatus: context.knobs.object.dropdown<ConnectionStatus>(
        label: 'Connection status',
        options: ConnectionStatus.values,
        initialOption: ConnectionStatus.connected,
        labelBuilder: (s) => s.name,
      ),
      serverName: context.knobs.stringOrNull(
        label: 'Server name',
        initialValue: 'my-workstation',
      ),
    ),
    body: const Center(child: Text('Screen content goes here')),
  );
}
