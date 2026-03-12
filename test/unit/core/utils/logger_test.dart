import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/utils/logger.dart';

void main() {
  group('Logger', () {
    test('Logger.debug logs correctly', () {
      expect(() => Logger.debug('Debug message'), returnsNormally);
    });

    test('Logger.debug logs with error', () {
      expect(
        () => Logger.debug('Debug message', error: Exception('Test error')),
        returnsNormally,
      );
    });

    test('Logger.debug logs with context', () {
      expect(
        () => Logger.debug('Debug message', context: {'key': 'value'}),
        returnsNormally,
      );
    });

    test('Logger.info logs correctly', () {
      expect(() => Logger.info('Info message'), returnsNormally);
    });

    test('Logger.info logs with error', () {
      expect(
        () => Logger.info('Info message', error: Exception('Test error')),
        returnsNormally,
      );
    });

    test('Logger.info logs with context', () {
      expect(
        () => Logger.info('Info message', context: {'key': 'value'}),
        returnsNormally,
      );
    });

    test('Logger.warning logs correctly', () {
      expect(() => Logger.warning('Warning message'), returnsNormally);
    });

    test('Logger.warning logs with error', () {
      expect(
        () => Logger.warning('Warning message', error: Exception('Test error')),
        returnsNormally,
      );
    });

    test('Logger.warning logs with context', () {
      expect(
        () => Logger.warning('Warning message', context: {'key': 'value'}),
        returnsNormally,
      );
    });

    test('Logger.error logs correctly', () {
      expect(() => Logger.error('Error message'), returnsNormally);
    });

    test('Logger.error logs with error and stackTrace', () {
      try {
        throw Exception('Test error');
      } catch (e, s) {
        expect(
          () => Logger.error('Error message', error: e, stackTrace: s),
          returnsNormally,
        );
      }
    });

    test('Logger.error logs with context', () {
      expect(
        () => Logger.error('Error message', context: {'key': 'value'}),
        returnsNormally,
      );
    });

    test('Logger.error logs with all parameters', () {
      try {
        throw Exception('Test error');
      } catch (e, s) {
        expect(
          () => Logger.error(
            'Error message',
            error: e,
            stackTrace: s,
            context: {'userId': '123', 'action': 'login'},
          ),
          returnsNormally,
        );
      }
    });

    test('ISO timestamp format', () {
      final timestamp = DateTime.now().toIso8601String();
      expect(timestamp.contains('T'), isTrue);
      expect(timestamp.split('T')[0].length, equals(10));
      expect(timestamp.split('T')[1].length, greaterThan(0));
    });

    test('Short timestamp format', () {
      final timestamp = DateTime.now().toIso8601String().substring(11, 19);
      expect(timestamp.contains(':'), isTrue);
      expect(timestamp.length, equals(8));
    });

    test('Context map with multiple entries', () {
      expect(
        () => Logger.info(
          'Complex context',
          context: {
            'userId': '123',
            'action': 'login',
            'duration': Duration(seconds: 5),
            'success': true,
          },
        ),
        returnsNormally,
      );
    });

    test('Empty context does not crash', () {
      expect(() => Logger.info('Empty context', context: {}), returnsNormally);
    });

    test('Null context is handled correctly', () {
      expect(() => Logger.info('No context'), returnsNormally);
    });

    test('Complex error object is handled', () {
      expect(
        () => Logger.error(
          'Complex error',
          error: ArgumentError('Invalid argument'),
        ),
        returnsNormally,
      );
    });

    test('Long message is handled', () {
      final longMessage = 'A' * 1000;
      expect(() => Logger.debug(longMessage), returnsNormally);
    });

    test('Special characters in message are handled', () {
      final specialChars = 'Message with 🎉 emoji and \n newlines \t tabs';
      expect(() => Logger.info(specialChars), returnsNormally);
    });

    test('Null values in context map are handled', () {
      expect(
        () => Logger.info(
          'Null context values',
          context: {'key': null, 'other': 'value'},
        ),
        returnsNormally,
      );
    });

    test('Complex objects in context are handled', () {
      expect(
        () => Logger.info(
          'Complex context objects',
          context: {
            'map': {'nested': 'value'},
            'list': [1, 2, 3],
            'duration': Duration(minutes: 5),
          },
        ),
        returnsNormally,
      );
    });
  });
}
