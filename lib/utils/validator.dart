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

  static String? phoneNumber(String? value) {
    if (value == null || value == '') {
      return 'Please enter phone number!';
    } else if (!value.startsWith('+92')) {
      return 'Phone number must start with +92';
    } else if (value.length != 13) {
      return 'Phone number must be of 13 digits!';
    }
    return null;
  }

  static String? cnic(String? value) {
    if (value == null || value == '') {
      return 'Please enter a valid CNIC!';
    } else if (value.contains('-')) {
      return 'Please remove - from CNIC!';
    } else if (value.length > 13) {
      return 'CNIC cannot have more than 13 digits!';
    } else if (value.length < 13) {
      return 'CNIC cannot have less than 13 digits!';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value == '') {
      return 'Please enter password!';
    } else if (value.length < 8) {
      return 'Password must contain 8 or more digits!';
    }
    return null;
  }

  static String? notEmpty(String? value) {
    if (value == null || value == '') {
      return 'This field cannot be empty!';
    } else if (value.length < 3) {
      return 'Please enter a valid value!';
    }
    return null;
  }
}
