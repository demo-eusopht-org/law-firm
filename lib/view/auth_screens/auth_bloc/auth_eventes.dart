abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String cnic;
  final String password;

  LoginEvent({
    required this.cnic,
    required this.password,
  });
}
