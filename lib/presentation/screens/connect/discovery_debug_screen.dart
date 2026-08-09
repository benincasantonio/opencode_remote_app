import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../services/services.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/connection_badge/connection_status.dart';
import 'connect_error_message.dart';

/// Debug screen for manually exercising [MdnsService].
///
/// Not a production UI: it exists so we can confirm mDNS discovery works
/// end-to-end against a real `opencode serve --mdns` instance before the
/// real connect screen lands in a later ticket. Tapping a discovered
/// server connects to it (and auto-saves it via the F1.2 flow).
class DiscoveryDebugScreen extends ConsumerStatefulWidget {
  const DiscoveryDebugScreen({super.key, this.mdns});

  /// Injectable for tests; defaults to a real [MdnsService].
  final MdnsService? mdns;

  @override
  ConsumerState<DiscoveryDebugScreen> createState() =>
      _DiscoveryDebugScreenState();
}

class _DiscoveryDebugScreenState extends ConsumerState<DiscoveryDebugScreen> {
  late final MdnsService _mdns = widget.mdns ?? MdnsService();
  StreamSubscription<List<DiscoveredServer>>? _subscription;
  List<DiscoveredServer> _servers = const [];
  Object? _error;
  bool _isDiscovering = false;
  String? _connectingKey;

  @override
  void dispose() {
    _subscription?.cancel();
    unawaited(_mdns.dispose());
    super.dispose();
  }

  void _start() {
    setState(() {
      _error = null;
      _isDiscovering = true;
    });
    try {
      final stream = _mdns.startDiscovery();
      _subscription = stream.listen(
        (servers) {
          setState(() => _servers = servers);
        },
        onError: (Object error) {
          setState(() {
            _error = error;
            _isDiscovering = false;
          });
        },
      );
    } catch (err) {
      setState(() {
        _error = err;
        _isDiscovering = false;
      });
    }
  }

  Future<void> _stop() async {
    await _subscription?.cancel();
    _subscription = null;
    await _mdns.stopDiscovery();
    if (!mounted) return;
    setState(() {
      _isDiscovering = false;
      _servers = const [];
    });
  }

  /// Connects to a discovered server, popping back on success and showing
  /// the mapped error inline on failure.
  Future<void> _connect(DiscoveredServer server) async {
    if (_connectingKey != null) {
      return;
    }
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _connectingKey = server.key);

    await ref.read(connectionProvider.notifier).connect(
      host: server.host,
      port: server.port,
    );
    if (!mounted) return;
    setState(() => _connectingKey = null);

    final connection = ref.read(connectionProvider);
    if (connection.status == ConnectionStatus.error) {
      final message =
          connectErrorMessage(l10n, connection.error) ?? l10n.connectErrorGeneric;
      messenger.showSnackBar(SnackBar(content: Text(message)));
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TerminalAppBar(
        title: context.l10n.discoveryTitle,
        showConnectionBadge: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isDiscovering ? null : _start,
                    child: Text(context.l10n.start),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isDiscovering ? _stop : null,
                    child: Text(context.l10n.stop),
                  ),
                ),
              ],
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ErrorBanner(message: _error.toString()),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  _isDiscovering ? context.l10n.discovering : context.l10n.idle,
                  style: AppTypography.label.copyWith(
                    color: _isDiscovering
                        ? AppColors.success
                        : AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  context.l10n.serverCount(_servers.length),
                  style: AppTypography.label,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: _servers.isEmpty
                ? Center(
                    child: Text(
                      _isDiscovering
                          ? context.l10n.searchingForServers
                          : context.l10n.noServersYet,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    itemCount: _servers.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final server = _servers[index];
                      return _ServerTile(
                        server: server,
                        isConnecting: _connectingKey == server.key,
                        onTap: () => _connect(server),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ServerTile extends StatelessWidget {
  const _ServerTile({
    required this.server,
    required this.isConnecting,
    required this.onTap,
  });

  final DiscoveredServer server;
  final bool isConnecting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final attributes = server.attributes;
    return ListTile(
      enabled: !isConnecting,
      onTap: onTap,
      title: Text(server.name, style: AppTypography.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${server.host}:${server.port}', style: AppTypography.codeSmall),
          if (attributes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                attributes.entries.map((e) => '${e.key}=${e.value}').join('  '),
                style: AppTypography.bodySmall,
              ),
            ),
        ],
      ),
      trailing: isConnecting
          ? const SizedBox(
              width: AppSizing.iconMedium,
              height: AppSizing.iconMedium,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(
              Icons.arrow_forward_ios,
              size: AppSizing.iconTiny,
              color: AppColors.textMuted,
            ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.12),
        border: Border.all(color: AppColors.error),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        message,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.error),
      ),
    );
  }
}
