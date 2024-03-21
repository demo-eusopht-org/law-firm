import 'dart:developer';

import 'package:intl/intl.dart';

bool boolFromJson(int value) {
  return value == 1;
}

DateTime dateFromJson(String dateValue) {
  log('DATE: ${dateValue}');
  return DateFormat('yyyy-MM-ddThh:mm:ss.000Z')
      .parse(dateValue, true)
      .toLocal();
}
