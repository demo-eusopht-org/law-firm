class Validator {
  static String? email(String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value == '') {
      return 'Please enter an email';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String? notEmpty(String? value) {
    if (value == null || value == '') {
      return 'This field cannot be empty!';
    } else if (value.length < 4) {
      return 'Please enter a valid value!';
    }
    return null;
  }
}
