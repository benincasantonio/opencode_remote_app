extension DateTimeX on DateTime {
  String timeAgo({bool numericDates = false}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    }

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    }

    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }

    if (difference.inDays <= 29) {
      final days = difference.inDays;
      if (days == 1 && !numericDates) {
        return 'yesterday';
      }
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    }

    return formatShort();
  }

  String formatShort() {
    final monthValue = month.toString().padLeft(2, '0');
    final dayValue = day.toString().padLeft(2, '0');
    final yearValue = year;
    return '$monthValue/$dayValue/$yearValue';
  }
}
