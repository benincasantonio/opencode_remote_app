import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/datasources/session_datasource.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

import '../../../support/http_test_adapter.dart';

void main() {
  late DioClient client;
  late SessionDatasource datasource;
  setUp(() {
    client = DioClient(baseUrl: 'http://example.com', enableLogging: false);
    datasource = SessionDatasource(client.dio);
  });
  tearDown(() => client.dispose());

  test('DELETE encodes id and forwards cancellation', () async {
    final token = CancelToken();
    client.dio.httpClientAdapter = HttpTestAdapter((options) async {
      expect(options.method, 'DELETE');
      expect(options.path, '/session/ses%2F1%3F');
      expect(options.cancelToken, same(token));
      return jsonResponse(true);
    });
    await datasource.deleteSession('ses/1?', cancelToken: token);
  });

  for (final data in [false, null, <String, Object>{}]) {
    test('rejects unconfirmed deletion: $data', () async {
      client.dio.httpClientAdapter = HttpTestAdapter(
        (_) async => jsonResponse(data),
      );
      await expectLater(
        datasource.deleteSession('ses_1'),
        throwsA(isA<ParseException>()),
      );
    });
  }

  for (final status in [401, 404, 500]) {
    test('HTTP $status is mapped without retrying DELETE', () async {
      var calls = 0;
      client.dio.httpClientAdapter = HttpTestAdapter((_) async {
        calls++;
        return jsonResponse({'error': 'failed'}, status: status);
      });
      await expectLater(
        datasource.deleteSession('ses_1'),
        throwsA(status == 401 ? isA<AuthException>() : isA<ServerException>()),
      );
      expect(calls, 1);
    });
  }
}
