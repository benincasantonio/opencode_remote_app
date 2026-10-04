import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/datasources/session_datasource.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

import '../../../support/http_test_adapter.dart';
import '../../../support/session_test_support.dart';

void main() {
  late DioClient client;
  late SessionDatasource datasource;
  setUp(() {
    client = DioClient(baseUrl: 'http://example.com', enableLogging: false);
    datasource = SessionDatasource(client.dio);
  });
  tearDown(() => client.dispose());

  test(
    'POST sends title, agent, auth and cancellation and parses session',
    () async {
      client.updateCredentials(username: 'user', password: 'secret');
      final token = CancelToken();
      client.dio.httpClientAdapter = HttpTestAdapter((options) async {
        expect(options.method, 'POST');
        expect(options.path, '/session');
        expect(options.data, {'title': 'Fix bug', 'agent': 'build'});
        expect(
          options.headers['authorization'],
          'Basic ${base64Encode(utf8.encode('user:secret'))}',
        );
        expect(options.cancelToken, same(token));
        return jsonResponse(createdSession.toJson());
      });
      expect(
        await datasource.createSession(
          const CreateSessionInput(title: 'Fix bug', agent: 'build'),
          cancelToken: token,
        ),
        createdSession,
      );
    },
  );

  test(
    'default creation sends an empty object, without null options',
    () async {
      client.dio.httpClientAdapter = HttpTestAdapter((options) async {
        expect(options.data, <String, dynamic>{});
        return jsonResponse(createdSession.toJson());
      });
      await datasource.createSession(const CreateSessionInput());
    },
  );

  for (final status in [401, 500]) {
    test('HTTP $status is mapped without retrying the POST', () async {
      var calls = 0;
      client.dio.httpClientAdapter = HttpTestAdapter((_) async {
        calls++;
        return jsonResponse({'error': 'failed'}, status: status);
      });
      await expectLater(
        datasource.createSession(const CreateSessionInput()),
        throwsA(status == 401 ? isA<AuthException>() : isA<ServerException>()),
      );
      expect(calls, 1);
    });
  }

  for (final data in [null, <String, Object>{}, <Object>[]]) {
    test('rejects malformed session response $data', () async {
      client.dio.httpClientAdapter = HttpTestAdapter(
        (_) async => jsonResponse(data),
      );
      await expectLater(
        datasource.createSession(const CreateSessionInput()),
        throwsA(isA<ParseException>()),
      );
    });
  }
}
