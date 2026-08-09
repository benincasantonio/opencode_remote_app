import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/api_constants.dart';
import '../../services/dio_client.dart';

part 'dio_providers.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClient(Ref ref) {
  final client = DioClient(baseUrl: ApiConstants.baseUrl);
  ref.onDispose(client.dispose);
  return client;
}
