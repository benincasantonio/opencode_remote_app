import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../../core/utils/logger.dart';
import '../../data/models/server_health.dart';
import '../../presentation/widgets/connection_badge/connection_status.dart';
import 'dio_providers.dart';
import 'saved_server_providers.dart';
import 'server_providers.dart';

part 'connection_providers.g.dart';

/// App-level connection snapshot for Connect / Home / GoRouter redirects.
///
/// Named [AppConnectionState] to avoid clashing with Flutter's
/// `ConnectionState` from `package:flutter/widgets.dart`.
class AppConnectionState {
  const AppConnectionState({
    this.status = ConnectionStatus.disconnected,
    this.baseUrl,
    this.displayName,
    this.health,
    this.error,
    this.bootInProgress = false,
  });

  final ConnectionStatus status;
  final String? baseUrl;
  final String? displayName;
  final ServerHealth? health;
  final AppException? error;

  /// True while the cold-start auto-connect to a saved server is running.
  /// The Connect screen shows a boot/loading state instead of the form.
  final bool bootInProgress;

  bool get isConnected => status == ConnectionStatus.connected;

  AppConnectionState copyWith({
    ConnectionStatus? status,
    String? baseUrl,
    String? displayName,
    ServerHealth? health,
    AppException? error,
    bool? bootInProgress,
    bool clearError = false,
    bool clearHealth = false,
  }) {
    return AppConnectionState(
      status: status ?? this.status,
      baseUrl: baseUrl ?? this.baseUrl,
      displayName: displayName ?? this.displayName,
      health: clearHealth ? null : (health ?? this.health),
      error: clearError ? null : (error ?? this.error),
      bootInProgress: bootInProgress ?? this.bootInProgress,
    );
  }
}

/// Whether the app has an active successful connection to an OpenCode server.
@Riverpod(keepAlive: true)
bool isConnected(Ref ref) {
  return ref.watch(connectionProvider).isConnected;
}

@Riverpod(keepAlive: true)
class Connection extends _$Connection {
  @override
  AppConnectionState build() {
    _bootAutoConnect();
    return const AppConnectionState(bootInProgress: true);
  }

  /// Cold-start auto-connect to the default/last saved server, if any.
  ///
  /// Ends in a disconnected state when no server is saved, and in an error
  /// state when the saved server is unreachable (both surfaced on Connect).
  Future<void> _bootAutoConnect() async {
    try {
      final repository = ref.read(savedServerRepositoryProvider);
      final defaultServer = await repository.getDefault();
      if (!ref.mounted) return;
      if (defaultServer == null) {
        state = const AppConnectionState();
        return;
      }
      final credentials = await repository.getCredentials(defaultServer.id);
      if (!ref.mounted) return;
      await connect(
        host: defaultServer.host,
        port: defaultServer.port,
        username: credentials?.username,
        password: credentials?.password,
      );
      if (!ref.mounted) return;
      state = state.copyWith(bootInProgress: false);
    } on Object {
      if (!ref.mounted) return;
      state = const AppConnectionState();
    }
  }

  /// Configure Dio and verify the server with a one-shot health check.
  Future<void> connect({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    // One guard for every caller (manual, saved, discovered): ignore a new
    // attempt while one is already in flight. Retries from error or
    // disconnected are still allowed.
    if (state.status == ConnectionStatus.connecting) {
      return;
    }
    final trimmedHost = host.trim();
    final displayName = '$trimmedHost:$port';
    final baseUrl = 'http://$trimmedHost:$port';

    state = AppConnectionState(
      status: ConnectionStatus.connecting,
      baseUrl: baseUrl,
      displayName: displayName,
      bootInProgress: state.bootInProgress,
    );

    final client = ref.read(dioClientProvider);
    client.updateBaseUrl(baseUrl);
    client.updateCredentials(username: username, password: password);

    try {
      final health = await ref.read(serverRepositoryProvider).getHealth();
      if (!ref.mounted) return;
      state = AppConnectionState(
        status: ConnectionStatus.connected,
        baseUrl: baseUrl,
        displayName: displayName,
        health: health,
        bootInProgress: state.bootInProgress,
      );
      await _persistCurrent(
        host: trimmedHost,
        port: port,
        username: username,
        password: password,
      );
    } on AppException catch (error) {
      if (!ref.mounted) return;
      state = AppConnectionState(
        status: ConnectionStatus.error,
        baseUrl: baseUrl,
        displayName: displayName,
        error: error,
      );
    } on Object catch (error, st) {
      if (!ref.mounted) return;
      state = AppConnectionState(
        status: ConnectionStatus.error,
        baseUrl: baseUrl,
        displayName: displayName,
        error: NetworkException('An unexpected error occurred: $error', st),
      );
    }
  }

  /// Saves the current server so it survives app restarts.
  ///
  /// Storage failures never fail a successful connection; they are logged
  /// and surfaced the next time the user opens Connect.
  Future<void> _persistCurrent({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    try {
      await ref
          .read(savedServerRepositoryProvider)
          .save(host: host, port: port, username: username, password: password);
      ref.invalidate(savedServersProvider);
    } on Object catch (error, st) {
      Logger.warning(
        'Failed to persist saved server',
        error: error,
        stackTrace: st,
      );
    }
  }

  /// Drops the active connection and clears Dio credentials.
  Future<void> disconnect() async {
    final client = ref.read(dioClientProvider);
    client.updateCredentials(username: null, password: null);
    client.updateBaseUrl(ApiConstants.baseUrl);
    state = const AppConnectionState();
  }
}
