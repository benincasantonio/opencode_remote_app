import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';

void main() {
  group('AppException hierarchy', () {
    // ── Construction ──────────────────────────────────────────────────

    group('construction', () {
      test('NetworkException stores message', () {
        const e = NetworkException('no internet');
        expect(e.message, 'no internet');
        expect(e.stackTrace, isNull);
      });

      test('ServerException stores statusCode and responseBody', () {
        const e = ServerException(
          'internal error',
          statusCode: 500,
          responseBody: '{"error":"boom"}',
        );
        expect(e.message, 'internal error');
        expect(e.statusCode, 500);
        expect(e.responseBody, '{"error":"boom"}');
      });

      test('AuthException stores optional statusCode', () {
        const withCode = AuthException('forbidden', statusCode: 403);
        expect(withCode.statusCode, 403);

        const withoutCode = AuthException('missing credentials');
        expect(withoutCode.statusCode, isNull);
      });

      test('TimeoutException stores optional duration', () {
        const e = TimeoutException(
          'timed out',
          duration: Duration(seconds: 10),
        );
        expect(e.duration, const Duration(seconds: 10));

        const noDuration = TimeoutException('timed out');
        expect(noDuration.duration, isNull);
      });

      test('ParseException stores optional source', () {
        const e = ParseException('bad json', source: '{invalid}');
        expect(e.source, '{invalid}');

        const noSource = ParseException('bad json');
        expect(noSource.source, isNull);
      });

      test('CacheException stores message', () {
        const e = CacheException('read failed');
        expect(e.message, 'read failed');
      });

      test('SseException stores message', () {
        const e = SseException('stream dropped');
        expect(e.message, 'stream dropped');
      });
    });

    // ── toString ──────────────────────────────────────────────────────

    group('toString', () {
      test('returns "SubclassName: message"', () {
        const exceptions = <AppException>[
          NetworkException('a'),
          ServerException('b', statusCode: 404),
          AuthException('c'),
          TimeoutException('d'),
          ParseException('e'),
          CacheException('f'),
          SseException('g'),
        ];

        expect(exceptions[0].toString(), 'NetworkException: a');
        expect(exceptions[1].toString(), 'ServerException: b');
        expect(exceptions[2].toString(), 'AuthException: c');
        expect(exceptions[3].toString(), 'TimeoutException: d');
        expect(exceptions[4].toString(), 'ParseException: e');
        expect(exceptions[5].toString(), 'CacheException: f');
        expect(exceptions[6].toString(), 'SseException: g');
      });
    });

    // ── StackTrace propagation ────────────────────────────────────────

    group('stackTrace propagation', () {
      test('all subclasses forward stackTrace', () {
        final trace = StackTrace.current;

        final exceptions = <AppException>[
          NetworkException('a', trace),
          ServerException('b', statusCode: 500, stackTrace: trace),
          AuthException('c', stackTrace: trace),
          TimeoutException('d', stackTrace: trace),
          ParseException('e', stackTrace: trace),
          CacheException('f', trace),
          SseException('g', trace),
        ];

        for (final e in exceptions) {
          expect(e.stackTrace, same(trace), reason: '${e.runtimeType}');
        }
      });
    });

    // ── Exhaustive switch ────────────────────────────────────────────

    group('exhaustive switch', () {
      test('covers all subtypes without default', () {
        // This test verifies static exhaustiveness — if a subtype is
        // added without updating the switch, this will fail to compile.
        const exceptions = <AppException>[
          NetworkException('a'),
          ServerException('b', statusCode: 500),
          AuthException('c'),
          TimeoutException('d'),
          ParseException('e'),
          CacheException('f'),
          SseException('g'),
        ];

        for (final e in exceptions) {
          final label = switch (e) {
            NetworkException() => 'network',
            ServerException() => 'server',
            AuthException() => 'auth',
            TimeoutException() => 'timeout',
            ParseException() => 'parse',
            CacheException() => 'cache',
            SseException() => 'sse',
          };
          expect(label, isNotEmpty);
        }
      });
    });

    // ── implements Exception ─────────────────────────────────────────

    group('type hierarchy', () {
      test('all subclasses are Exception instances', () {
        const exceptions = <AppException>[
          NetworkException('a'),
          ServerException('b', statusCode: 500),
          AuthException('c'),
          TimeoutException('d'),
          ParseException('e'),
          CacheException('f'),
          SseException('g'),
        ];

        for (final e in exceptions) {
          expect(e, isA<Exception>(), reason: '${e.runtimeType}');
          expect(e, isA<AppException>(), reason: '${e.runtimeType}');
        }
      });
    });
  });
}
