import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/server_datasource.dart';
import '../../data/repositories/server_repository.dart';
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
