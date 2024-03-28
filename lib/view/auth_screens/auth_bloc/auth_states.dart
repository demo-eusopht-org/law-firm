import '../../../model/users/forgot_password_model.dart';
import '../../../model/users/login_model.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  final UserResponse response;

  SuccessAuthState({
    required this.response,
  });
}

class ForgotSuccessAuthState extends AuthState {
  final ForgotPasswordModel forgotResponse;

  ForgotSuccessAuthState({required this.forgotResponse});
}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState({
    required this.message,
  });
}
