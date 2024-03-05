abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String cnic;
  final String password;

  LoginEvent({
    required this.cnic,
    required this.password,
  });
}

class ForgotEvent extends AuthEvent {
  final String cnic;

  ForgotEvent({
    required this.cnic,
  });
}
