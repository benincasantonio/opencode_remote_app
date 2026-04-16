import 'dart:async';

import 'package:bonsoir/bonsoir.dart';

import '../core/constants/app_constants.dart';
import '../core/errors/errors.dart';
import '../core/utils/logger.dart';
import 'discovered_server.dart';

/// Builds a [BonsoirDiscovery] for the given service type. Injected by tests
/// so they can substitute a [Fake] without a mocking library.
typedef BonsoirDiscoveryFactory = BonsoirDiscovery Function(String type);

/// Discovers OpenCode servers advertised on the local network via mDNS/DNS-SD.
///
/// Lifecycle: `startDiscovery()` → (stream events) → `stopDiscovery()` — may be
/// repeated — then `dispose()` to release the stream controller for good.
class MdnsService {
  MdnsService({
    BonsoirDiscoveryFactory? discoveryFactory,
    String serviceType = AppConstants.mdnsServiceType,
  }) : _discoveryFactory =
           discoveryFactory ?? ((type) => BonsoirDiscovery(type: type)),
       _serviceType = serviceType;

  final BonsoirDiscoveryFactory _discoveryFactory;
  final String _serviceType;

  final Map<String, DiscoveredServer> _servers = {};
  final StreamController<List<DiscoveredServer>> _controller =
      StreamController<List<DiscoveredServer>>.broadcast();
  late final Stream<List<DiscoveredServer>> _stream = _controller.stream;

  BonsoirDiscovery? _discovery;
  StreamSubscription<BonsoirDiscoveryEvent>? _subscription;
  bool _isDiscovering = false;
  bool _isDisposed = false;

  /// Whether discovery is currently active.
  bool get isDiscovering => _isDiscovering;

  /// Snapshot of currently known servers. Immutable view.
  List<DiscoveredServer> get discoveredServers =>
      List.unmodifiable(_servers.values);

  /// Starts mDNS discovery and returns a broadcast stream of snapshots.
  ///
  /// Idempotent: a second call while discovery is already running returns the
  /// existing stream. Throws [StateError] after [dispose]. Throws
  /// [NetworkException] if bonsoir fails to initialize or start.
  Stream<List<DiscoveredServer>> startDiscovery() {
    if (_isDisposed) {
      throw StateError('MdnsService has been disposed');
    }
    if (_isDiscovering) {
      return _stream;
    }

    // Assigned synchronously so this method returns a stream immediately;
    // the async initialize/start runs in the background and errors surface
    // via `_controller.addError` (or rethrow to the unhandled zone if no
    // listener yet). See `_beginDiscovery` for the error path.
    _isDiscovering = true;
    unawaited(_beginDiscovery());
    return _stream;
  }

  Future<void> _beginDiscovery() async {
    final discovery = _discoveryFactory(_serviceType);
    _discovery = discovery;

    try {
      await discovery.initialize();
    } catch (error, stackTrace) {
      Logger.error(
        'mDNS discovery failed to start',
        error: error,
        stackTrace: stackTrace,
      );
      _isDiscovering = false;
      _discovery = null;
      _controller.addError(
        NetworkException('mDNS discovery failed to start: $error', stackTrace),
        stackTrace,
      );
      return;
    }

    final stream = discovery.eventStream;
    if (stream == null) {
      Logger.warning('mDNS discovery eventStream is null');
      _isDiscovering = false;
      _discovery = null;
      _controller.addError(
        const NetworkException('mDNS discovery event stream is unavailable'),
      );
      return;
    }

    _subscription = stream.listen(
      _handleEvent,
      onError: (Object error, StackTrace stackTrace) {
        Logger.error(
          'mDNS discovery stream error',
          error: error,
          stackTrace: stackTrace,
        );
        _controller.addError(
          NetworkException('mDNS stream error: $error', stackTrace),
          stackTrace,
        );
      },
    );

    try {
      await discovery.start();
    } catch (error, stackTrace) {
      Logger.error(
        'mDNS discovery failed to start',
        error: error,
        stackTrace: stackTrace,
      );
      _isDiscovering = false;
      await _subscription?.cancel();
      _subscription = null;
      _discovery = null;
      _controller.addError(
        NetworkException('mDNS discovery failed to start: $error', stackTrace),
        stackTrace,
      );
    }
  }

  void _handleEvent(BonsoirDiscoveryEvent event) {
    switch (event) {
      case BonsoirDiscoveryStartedEvent():
        Logger.info('mDNS discovery started');
      case BonsoirDiscoveryServiceFoundEvent(:final service):
        Logger.debug(
          'mDNS service found',
          context: {'name': service.name, 'port': service.port},
        );
        _resolveIfPossible(service);
      case BonsoirDiscoveryServiceResolvedEvent(:final service):
        _upsert(service);
      case BonsoirDiscoveryServiceUpdatedEvent(:final service):
        _upsert(service);
      case BonsoirDiscoveryServiceResolveFailedEvent():
        Logger.warning('mDNS service resolve failed');
      case BonsoirDiscoveryServiceLostEvent(:final service):
        _remove(service);
      case BonsoirDiscoveryStoppedEvent():
        Logger.info('mDNS discovery stopped');
      case BonsoirDiscoveryUnknownEvent():
        Logger.warning('mDNS unknown discovery event');
    }
  }

  void _resolveIfPossible(BonsoirService service) {
    final resolver = _discovery?.serviceResolver;
    if (resolver == null) {
      return;
    }
    try {
      resolver.resolveService(service);
    } catch (error, stackTrace) {
      Logger.warning(
        'mDNS resolveService failed',
        error: error,
        stackTrace: stackTrace,
        context: {'name': service.name},
      );
    }
  }

  void _upsert(BonsoirService service) {
    final host = service.host;
    if (host == null) {
      return;
    }
    final entry = DiscoveredServer(
      name: service.name,
      host: host,
      port: service.port,
      attributes: Map<String, String>.from(service.attributes),
    );
    _servers[entry.key] = entry;
    _emit();
  }

  void _remove(BonsoirService service) {
    final host = service.host;
    if (host != null) {
      final keyed = '${service.name}|$host|${service.port}';
      if (_servers.remove(keyed) != null) {
        _emit();
        return;
      }
    }
    // Host may be null on lost events: fall back to name+port match.
    String? matchKey;
    for (final entry in _servers.values) {
      if (entry.name == service.name && entry.port == service.port) {
        matchKey = entry.key;
        break;
      }
    }
    if (matchKey != null) {
      _servers.remove(matchKey);
      _emit();
    }
  }

  void _emit() {
    if (_controller.isClosed) {
      return;
    }
    _controller.add(List.unmodifiable(_servers.values));
  }

  /// Stops active discovery. No-op when not running. Safe to call repeatedly.
  /// Does not close the underlying stream controller (use [dispose] for that).
  Future<void> stopDiscovery() async {
    if (!_isDiscovering) {
      return;
    }
    _isDiscovering = false;

    await _subscription?.cancel();
    _subscription = null;

    final discovery = _discovery;
    _discovery = null;
    if (discovery != null) {
      try {
        await discovery.stop();
      } catch (error, stackTrace) {
        Logger.warning(
          'mDNS discovery stop failed',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    _servers.clear();
    _emit();
  }

  /// Releases all resources. Subsequent calls to [startDiscovery] throw
  /// [StateError]. Safe to call multiple times.
  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }
    await stopDiscovery();
    _isDisposed = true;
    await _controller.close();
  }
}
