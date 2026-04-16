import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../services/services.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';

/// Debug screen for manually exercising [MdnsService].
///
/// Not a production UI: it exists so we can confirm mDNS discovery works
/// end-to-end against a real `opencode serve --mdns` instance before the
/// real connect screen lands in a later ticket.
class DiscoveryDebugScreen extends StatefulWidget {
  const DiscoveryDebugScreen({super.key});

  @override
  State<DiscoveryDebugScreen> createState() => _DiscoveryDebugScreenState();
}

class _DiscoveryDebugScreenState extends State<DiscoveryDebugScreen> {
  final MdnsService _mdns = MdnsService();
  StreamSubscription<List<DiscoveredServer>>? _subscription;
  List<DiscoveredServer> _servers = const [];
  Object? _error;
  bool _isDiscovering = false;

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
    } catch (error) {
      setState(() {
        _error = error;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TerminalAppBar(
        title: 'mDNS Discovery',
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
                    child: const Text('Start'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isDiscovering ? _stop : null,
                    child: const Text('Stop'),
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
                  _isDiscovering ? 'DISCOVERING' : 'IDLE',
                  style: AppTypography.label.copyWith(
                    color: _isDiscovering
                        ? AppColors.success
                        : AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_servers.length} server(s)',
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
                          ? 'Searching for servers…'
                          : 'No servers yet.\nTap Start to begin discovery.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    itemCount: _servers.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) =>
                        _ServerTile(server: _servers[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ServerTile extends StatelessWidget {
  const _ServerTile({required this.server});

  final DiscoveredServer server;

  @override
  Widget build(BuildContext context) {
    final attributes = server.attributes;
    return ListTile(
      title: Text(server.name, style: AppTypography.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${server.host}:${server.port}',
            style: AppTypography.codeSmall,
          ),
          if (attributes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                attributes.entries
                    .map((e) => '${e.key}=${e.value}')
                    .join('  '),
                style: AppTypography.bodySmall,
              ),
            ),
        ],
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
