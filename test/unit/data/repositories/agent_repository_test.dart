import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/datasources/agent_datasource.dart';
import 'package:opencode_remote_app/data/models/agent_info.dart';
import 'package:opencode_remote_app/data/repositories/agent_repository.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

import '../../../support/http_test_adapter.dart';

void main() {
  late DioClient client;
  late AgentRepository repository;
  setUp(() {
    client = DioClient(baseUrl: 'http://example.com', enableLogging: false);
    repository = AgentRepository(AgentDatasource(client.dio));
  });
  tearDown(() => client.dispose());

  test(
    'loads agents through repository and datasource, preserving API fields',
    () async {
      final token = CancelToken();
      client.dio.httpClientAdapter = HttpTestAdapter((options) async {
        expect(options.path, '/agent');
        expect(options.method, 'GET');
        expect(options.cancelToken, same(token));
        return jsonResponse([
          {
            'name': 'build',
            'mode': 'primary',
            'description': 'Build things',
            'options': {},
          },
          {'name': 'internal', 'mode': 'all', 'hidden': true},
        ]);
      });
      expect(await repository.getAgents(cancelToken: token), [
        const AgentInfo(
          name: 'build',
          mode: 'primary',
          description: 'Build things',
        ),
        const AgentInfo(name: 'internal', mode: 'all', hidden: true),
      ]);
    },
  );

  test('accepts an empty agent list', () async {
    client.dio.httpClientAdapter = HttpTestAdapter(
      (_) async => jsonResponse([]),
    );
    expect(await repository.getAgents(), isEmpty);
  });

  for (final data in [
    null,
    {},
    [
      {'name': 'missing-mode'},
    ],
  ]) {
    test('invalid agent payload $data propagates ParseException', () async {
      client.dio.httpClientAdapter = HttpTestAdapter(
        (_) async => jsonResponse(data),
      );
      await expectLater(repository.getAgents(), throwsA(isA<ParseException>()));
    });
  }

  test('HTTP errors propagate through the repository', () async {
    client.dio.httpClientAdapter = HttpTestAdapter(
      (_) async => jsonResponse({}, status: 401),
    );
    await expectLater(repository.getAgents(), throwsA(isA<AuthException>()));
  });
}
