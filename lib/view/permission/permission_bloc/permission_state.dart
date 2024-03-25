import 'package:case_management/model/generic_response.dart';
import 'package:case_management/model/permission/get_role_model.dart';

abstract class PermissionState {}

class InitialPermissionState extends PermissionState {}

class LoadingPermissionState extends PermissionState {}

class SuccessRolesState extends PermissionState {
  final List<Role> roles;

  SuccessRolesState({
    required this.roles,
  });
}

class CreatePermissionState extends PermissionState {
  final GenericResponse response;

  CreatePermissionState({
    required this.response,
  });
}

class ErrorPermissionState extends PermissionState {
  final String message;

  ErrorPermissionState({
    required this.message,
  });
}
