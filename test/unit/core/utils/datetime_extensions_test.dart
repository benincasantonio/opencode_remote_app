import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/utils/datetime_extensions.dart';

void main() {
  group('DateTimeX', () {
    test('timeAgo with just now', () {
      final now = DateTime.now();
      expect(now.timeAgo(), 'just now');
    });

    test('timeAgo with minutes ago', () {
      final fiveMinAgo = DateTime.now().subtract(const Duration(minutes: 5));
      expect(fiveMinAgo.timeAgo(), '5 minutes ago');
    });

    test('timeAgo with singular minute', () {
      final oneMinAgo = DateTime.now().subtract(const Duration(minutes: 1));
      expect(oneMinAgo.timeAgo(), '1 minute ago');
    });

    test('timeAgo with hours ago', () {
      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));
      expect(twoHoursAgo.timeAgo(), '2 hours ago');
    });

    test('timeAgo with singular hour', () {
      final oneHourAgo = DateTime.now().subtract(const Duration(hours: 1));
      expect(oneHourAgo.timeAgo(), '1 hour ago');
    });

    test('timeAgo with days ago', () {
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      expect(threeDaysAgo.timeAgo(), '3 days ago');
    });

    test('timeAgo with singular day', () {
      final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
      expect(oneDayAgo.timeAgo(), 'yesterday');
    });

    test('timeAgo with numericDates uses days', () {
      final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
      expect(oneDayAgo.timeAgo(numericDates: true), '1 day ago');
    });

    test('timeAgo with old date uses formatShort', () {
      final thirtyFiveDaysAgo = DateTime.now().subtract(
        const Duration(days: 35),
      );
      final result = thirtyFiveDaysAgo.timeAgo();
      expect(result, contains('/'));
      expect(result.split('/').length, equals(3));
    });

    test('formatShort returns MM/dd/yyyy', () {
      final date = DateTime(2026, 3, 12);
      expect(date.formatShort(), '03/12/2026');
    });

    test('formatShort pads single digit month and day', () {
      final date = DateTime(2026, 3, 5);
      expect(date.formatShort(), '03/05/2026');
    });

    test('formatShort with two digit month and day', () {
      final date = DateTime(2026, 12, 25);
      expect(date.formatShort(), '12/25/2026');
    });
  });
}
