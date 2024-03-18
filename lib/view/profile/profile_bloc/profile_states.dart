import 'package:case_management/model/generic_response.dart';

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {
  final GenericResponse response;

  SuccessProfileState({
    required this.response,
  });
}

class ErrorProfileState extends ProfileState {
  final String message;

  ErrorProfileState({
    required this.message,
  });
}
