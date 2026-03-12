import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/utils/asyncvalue_extensions.dart';

void main() {
  group('AsyncValueX', () {
    test('dataOrNull returns data for AsyncData', () {
      final value = AsyncValue<String>.data('test data');
      expect(value.dataOrNull, 'test data');
    });

    test('dataOrNull returns null for AsyncLoading', () {
      final value = AsyncValue<String>.loading();
      expect(value.dataOrNull, isNull);
    });

    test('dataOrNull returns null for AsyncError', () {
      final value = AsyncValue<String>.error(
        Exception('test'),
        StackTrace.empty,
      );
      expect(value.dataOrNull, isNull);
    });

    test('errorOrNull returns error for AsyncError', () {
      final error = Exception('test error');
      final stackTrace = StackTrace.empty;
      final value = AsyncValue<String>.error(error, stackTrace);
      expect(value.errorOrNull, equals((error, stackTrace)));
    });

    test('errorOrNull returns null for AsyncLoading', () {
      final value = AsyncValue<String>.loading();
      expect(value.errorOrNull, isNull);
    });

    test('errorOrNull returns null for AsyncData', () {
      final value = AsyncValue<String>.data('test');
      expect(value.errorOrNull, isNull);
    });
  });
}
