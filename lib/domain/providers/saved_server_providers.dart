import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/credential_storage.dart';
import '../../data/datasources/server_storage_datasource.dart';
import '../../data/models/saved_server.dart';
import '../../data/repositories/saved_server_repository.dart';

part 'saved_server_providers.g.dart';

@Riverpod(keepAlive: true)
ServerStorageDatasource serverStorageDatasource(Ref ref) {
  return ServerStorageDatasource();
}

@Riverpod(keepAlive: true)
CredentialStorage credentialStorage(Ref ref) {
  return SecureCredentialStorage();
}

@Riverpod(keepAlive: true)
SavedServerRepository savedServerRepository(Ref ref) {
  return SavedServerRepository(
    ref.watch(serverStorageDatasourceProvider),
    ref.watch(credentialStorageProvider),
  );
}

/// The persisted list of saved servers, kept in sync with
/// [SavedServerRepository].
@Riverpod(keepAlive: true)
class SavedServers extends _$SavedServers {
  @override
  Future<List<SavedServer>> build() {
    return ref.watch(savedServerRepositoryProvider).getAll();
  }

  Future<void> delete(String id) async {
    await ref.read(savedServerRepositoryProvider).delete(id);
    ref.invalidateSelf();
  }

  Future<void> setDefault(String id) async {
    await ref.read(savedServerRepositoryProvider).setDefault(id);
    ref.invalidateSelf();
  }
}
