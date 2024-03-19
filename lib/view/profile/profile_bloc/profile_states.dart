import 'package:case_management/model/generic_response.dart';
import 'package:case_management/model/version/app_version_model.dart';

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {
  final GenericResponse response;

  SuccessProfileState({
    required this.response,
  });
}

class VersionSuccessProfileState extends ProfileState {
  final AppVersionModel response;

  VersionSuccessProfileState({
    required this.response,
  });
}

class ErrorProfileState extends ProfileState {
  final String message;

  ErrorProfileState({
    required this.message,
  });
}
