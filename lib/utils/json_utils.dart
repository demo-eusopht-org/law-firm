import 'package:intl/intl.dart';

bool boolFromJson(int? value) {
  return value == 1;
}

DateTime dateFromJson(String dateValue) {
  return DateFormat('yyyy-MM-ddThh:mm:ss.000Z')
      .parse(dateValue, true)
      .toLocal();
}

DateTime? nullDateFromJson(String? dateValue) {
  if (dateValue == null) {
    return null;
  }
  return DateFormat('yyyy-MM-ddThh:mm:ss.000Z')
      .parse(dateValue, true)
      .toLocal();
}
