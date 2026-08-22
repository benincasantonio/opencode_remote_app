import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/mdns_service.dart';
import '../../services/discovered_server.dart';

part 'discovery_providers.g.dart';

/// Disables Riverpod's automatic retry for [discoveredServers]: the UI owns
/// retrying via `ref.invalidate`, and automatic backoff would retry mDNS
/// initialization without user intent.
const Duration? Function(int retryCount, Object error) noDiscoveryRetry =
    _noRetry;

Duration? _noRetry(int retryCount, Object error) => null;

/// Owns the active [MdnsService] for the Connect screen lifecycle.
///
/// Auto-disposed: the service is disposed when Connect leaves the tree,
/// stopping the underlying Bonsoir discovery. Injectable in tests by
/// overriding this provider with a fake service.
@Riverpod()
MdnsService mdnsService(Ref ref) {
  final service = MdnsService();
  ref.onDispose(() => unawaited(service.dispose()));
  return service;
}

/// Stream of discovered OpenCode server snapshots: the current snapshot
/// immediately, then live discovery updates; errors propagate to
/// `AsyncError` unchanged. Retry is disabled: the UI owns retrying via
/// `ref.invalidate`, and automatic exponential backoff would retry (and
/// spam) mDNS initialization without user intent.
@Riverpod(retry: noDiscoveryRetry)
Stream<List<DiscoveredServer>> discoveredServers(Ref ref) async* {
  final service = ref.watch(mdnsServiceProvider);
  yield service.discoveredServers;
  yield* service.startDiscovery();
}
