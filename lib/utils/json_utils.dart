bool boolFromJson(int value) {
  return value == 1;
}

DateTime dateFromJson(String dateValue) {
  return DateTime.parse(dateValue);
}
