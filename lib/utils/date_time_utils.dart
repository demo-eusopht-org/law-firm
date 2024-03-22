import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String getFormattedDateTime() {
    return DateFormat('dd MMM yyyy hh:mm a').format(this);
  }

  String getFormattedDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  bool get isToday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = now.copyWith(
      day: now.day + 1,
    );
    return tomorrow.year == year &&
        tomorrow.month == month &&
        tomorrow.day == day;
  }
}
