import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/connection_badge/connection_status.dart';

/// Manual host/port (+ optional Basic auth) form for connecting to OpenCode.
class ManualConnectWidget extends ConsumerStatefulWidget {
  const ManualConnectWidget({super.key});

  @override
  ConsumerState<ManualConnectWidget> createState() =>
      _ManualConnectWidgetState();
}

class _ManualConnectWidgetState extends ConsumerState<ManualConnectWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _hostController;
  late final TextEditingController _portController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _hostController = TextEditingController(text: ApiConstants.defaultHost);
    _portController = TextEditingController(
      text: '${ApiConstants.defaultPort}',
    );
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onConnect() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    final port = int.parse(_portController.text.trim());
    await ref
        .read(connectionProvider.notifier)
        .connect(
          host: _hostController.text,
          port: port,
          username: _optional(_usernameController.text),
          password: _optional(_passwordController.text),
        );
  }

  static String? _optional(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connection = ref.watch(connectionProvider);
    final isConnecting = connection.status == ConnectionStatus.connecting;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _hostController,
            enabled: !isConnecting,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: l10n.hostLabel),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.hostRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizing.gapMedium),
          TextFormField(
            controller: _portController,
            enabled: !isConnecting,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l10n.portLabel),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.portRequired;
              }
              final port = int.tryParse(value.trim());
              if (port == null || port < 1 || port > 65535) {
                return l10n.portInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizing.gapMedium),
          TextFormField(
            controller: _usernameController,
            enabled: !isConnecting,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: l10n.usernameLabel),
          ),
          const SizedBox(height: AppSizing.gapMedium),
          TextFormField(
            controller: _passwordController,
            enabled: !isConnecting,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              if (!isConnecting) {
                _onConnect();
              }
            },
            decoration: InputDecoration(labelText: l10n.passwordLabel),
          ),
          const SizedBox(height: AppSizing.gapXLarge),
          AppButton(
            label: l10n.connectButton,
            isLoading: isConnecting,
            onPressed: isConnecting ? null : _onConnect,
          ),
        ],
      ),
    );
  }
}
