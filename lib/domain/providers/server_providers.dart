import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../data/datasources/server_datasource.dart';
import '../../data/models/server_health.dart';
import '../../data/repositories/server_repository.dart';
import 'connection_providers.dart';
import 'dio_providers.dart';

part 'server_providers.g.dart';

@Riverpod(keepAlive: true)
ServerDatasource serverDatasource(Ref ref) {
  final client = ref.watch(dioClientProvider);
  return ServerDatasource(client.dio);
}

@Riverpod(keepAlive: true)
ServerRepository serverRepository(Ref ref) {
  return ServerRepository(ref.watch(serverDatasourceProvider));
}

/// Live health dashboard source: seeds from the connection snapshot, then
/// polls every [AppConstants.healthPollingInterval] while connected.
///
/// Auto-disposed: Home is the only consumer today, so leaving Home stops the
/// timer and cancels the in-flight request. A failed poll surfaces as a
/// stream error (kept as [AsyncValue] error with the previous value) without
/// touching [connectionProvider], so transient health errors never trigger
/// the router's disconnected redirect. Riverpod's default stream retry
/// (backoff + provider rebuild) is disabled so the stream itself stays open
/// and owns the polling cadence.
@Riverpod(retry: _noRetry)
Stream<ServerHealth> healthPolling(Ref ref) {
  final connection = ref.watch(connectionProvider);
  final seedHealth = connection.health;
  if (!connection.isConnected || seedHealth == null) {
    return const Stream<ServerHealth>.empty();
  }

  final repository = ref.read(serverRepositoryProvider);
  CancelToken? activeToken;
  ref.onDispose(() => activeToken?.cancel());

  Stream<ServerHealth> fetchOnce() async* {
    final token = CancelToken();
    activeToken = token;
    try {
      yield await repository.getHealth(cancelToken: token);
    } finally {
      if (identical(activeToken, token)) {
        activeToken = null;
      }
    }
  }

  Stream<ServerHealth> poll() async* {
    yield seedHealth;
    while (true) {
      await Future<void>.delayed(AppConstants.healthPollingInterval);
      yield* fetchOnce();
    }
  }

  return poll();
}

/// Disables Riverpod's default stream retry (exponential backoff plus
/// provider rebuild), which would otherwise restart the polling stream.
Duration? _noRetry(int retryCount, Object error) => null;
