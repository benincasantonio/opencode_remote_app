import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/utils/string_extensions.dart';

void main() {
  group('StringX', () {
    test('truncate returns original if shorter than length', () {
      expect('Hello'.truncate(10), 'Hello');
    });

    test('truncate returns original if equal to length', () {
      expect('Hello'.truncate(5), 'Hello');
    });

    test('truncate with default suffix', () {
      expect('Hello World'.truncate(5), 'He...');
    });

    test('truncate with custom suffix', () {
      final result = 'Hello World'.truncate(8, suffix: '***');
      expect(result.length, 8);
    });

    test('truncate with length <= suffix length returns original', () {
      expect('Hi'.truncate(2), 'Hi');
    });

    test('truncate with empty string', () {
      expect(''.truncate(10), '');
    });

    test('capitalize capitalizes first letter', () {
      expect('hello world'.capitalize(), 'Hello world');
    });

    test('capitalize handles single character', () {
      expect('h'.capitalize(), 'H');
    });

    test('capitalize handles already capitalized', () {
      expect('Hello'.capitalize(), 'Hello');
    });

    test('capitalize with empty string', () {
      expect(''.capitalize(), '');
    });

    test('isValidUrl with valid https URL', () {
      expect('https://example.com'.isValidUrl(), isTrue);
    });

    test('isValidUrl with valid http URL', () {
      expect('http://example.com'.isValidUrl(), isTrue);
    });

    test('isValidUrl with invalid URL', () {
      expect('not-a-url'.isValidUrl(), isFalse);
    });

    test('isValidUrl with httpsOnly true accepts only https', () {
      expect('https://example.com'.isValidUrl(httpsOnly: true), isTrue);
      expect('http://example.com'.isValidUrl(httpsOnly: true), isFalse);
    });

    test('isValidUrl with httpsOnly false accepts both', () {
      expect('https://example.com'.isValidUrl(httpsOnly: false), isTrue);
      expect('http://example.com'.isValidUrl(httpsOnly: false), isTrue);
    });

    test('isValidUrl rejects empty string', () {
      expect(''.isValidUrl(), isFalse);
    });
  });
}
