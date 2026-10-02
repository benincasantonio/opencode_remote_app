import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/datasources/session_datasource.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/data/repositories/session_repository.dart';

class _FakeSessionDatasource implements SessionDatasource {
  List<Session> sessionsResult = const [];
  Map<String, SessionStatus> statusResult = const {};

  String? lastDirectory;
  String? lastRoots;
  int? lastLimit;
  String? lastWorkspace;
  CancelToken? lastCancelToken;

  @override
  Future<List<Session>> getSessions({
    String? directory,
    String? roots,
    int? limit,
    CancelToken? cancelToken,
  }) async {
    lastDirectory = directory;
    lastRoots = roots;
    lastLimit = limit;
    lastCancelToken = cancelToken;
    return sessionsResult;
  }

  @override
  Future<Map<String, SessionStatus>> getSessionStatus({
    String? directory,
    String? workspace,
    CancelToken? cancelToken,
  }) async {
    lastDirectory = directory;
    lastWorkspace = workspace;
    lastCancelToken = cancelToken;
    return statusResult;
  }
}

void main() {
  group('SessionRepository', () {
    late _FakeSessionDatasource fakeDatasource;
    late SessionRepository repository;

    setUp(() {
      fakeDatasource = _FakeSessionDatasource();
      repository = SessionRepository(fakeDatasource);
    });

    test('getSessions forwards arguments and returns sessions', () async {
      const sampleSession = Session(
        id: 'ses_1',
        slug: 'slug',
        projectID: 'global',
        directory: '/dir',
        title: 'title',
        version: '1.0',
        time: SessionTime(created: 1, updated: 2),
      );
      fakeDatasource.sessionsResult = [sampleSession];

      final token = CancelToken();
      final result = await repository.getSessions(
        directory: '/my/dir',
        roots: 'roots',
        limit: 5,
        cancelToken: token,
      );

      expect(result, [sampleSession]);
      expect(fakeDatasource.lastDirectory, '/my/dir');
      expect(fakeDatasource.lastRoots, 'roots');
      expect(fakeDatasource.lastLimit, 5);
      expect(identical(fakeDatasource.lastCancelToken, token), isTrue);
    });

    test(
      'getSessionStatus forwards arguments and returns status map',
      () async {
        fakeDatasource.statusResult = {'ses_1': const SessionStatus.idle()};

        final token = CancelToken();
        final result = await repository.getSessionStatus(
          directory: '/my/dir',
          workspace: 'ws_1',
          cancelToken: token,
        );

        expect(result, {'ses_1': const SessionStatus.idle()});
        expect(fakeDatasource.lastDirectory, '/my/dir');
        expect(fakeDatasource.lastWorkspace, 'ws_1');
        expect(identical(fakeDatasource.lastCancelToken, token), isTrue);
      },
    );
  });
}
