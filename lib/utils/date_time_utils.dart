import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String getFormattedDateTime() {
    return DateFormat('dd MMM yyyy hh:mm a').format(this);
  }

  String getFormattedDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
