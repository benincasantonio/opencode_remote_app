import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/errors/app_exception.dart';
import '../../data/models/server_health.dart';
import '../../presentation/widgets/connection_badge/connection_status.dart';
import 'dio_providers.dart';
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
  });

  final ConnectionStatus status;
  final String? baseUrl;
  final String? displayName;
  final ServerHealth? health;
  final AppException? error;

  bool get isConnected => status == ConnectionStatus.connected;

  AppConnectionState copyWith({
    ConnectionStatus? status,
    String? baseUrl,
    String? displayName,
    ServerHealth? health,
    AppException? error,
    bool clearError = false,
    bool clearHealth = false,
  }) {
    return AppConnectionState(
      status: status ?? this.status,
      baseUrl: baseUrl ?? this.baseUrl,
      displayName: displayName ?? this.displayName,
      health: clearHealth ? null : (health ?? this.health),
      error: clearError ? null : (error ?? this.error),
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
  AppConnectionState build() => const AppConnectionState();

  /// Configure Dio and verify the server with a one-shot health check.
  Future<void> connect({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    final trimmedHost = host.trim();
    final displayName = '$trimmedHost:$port';
    final baseUrl = 'http://$trimmedHost:$port';

    state = AppConnectionState(
      status: ConnectionStatus.connecting,
      baseUrl: baseUrl,
      displayName: displayName,
    );

    final client = ref.read(dioClientProvider);
    client.updateBaseUrl(baseUrl);
    client.updateCredentials(username: username, password: password);

    try {
      final health = await ref.read(serverRepositoryProvider).getHealth();
      state = AppConnectionState(
        status: ConnectionStatus.connected,
        baseUrl: baseUrl,
        displayName: displayName,
        health: health,
      );
    } on AppException catch (error) {
      state = AppConnectionState(
        status: ConnectionStatus.error,
        baseUrl: baseUrl,
        displayName: displayName,
        error: error,
      );
    } on Object catch (error, st) {
      state = AppConnectionState(
        status: ConnectionStatus.error,
        baseUrl: baseUrl,
        displayName: displayName,
        error: NetworkException(
          'An unexpected error occurred: $error',
          st,
        ),
      );
    }
  }
}
