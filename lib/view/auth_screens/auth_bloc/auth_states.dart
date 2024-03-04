import 'package:case_management/model/login_model.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  final UserResponse response;

  SuccessAuthState({
    required this.response,
  });
}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState({
    required this.message,
  });
}
