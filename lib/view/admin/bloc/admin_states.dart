import '../../../model/cases/case_status.dart';

abstract class AdminState {}

class InitialAdminState extends AdminState {}

class ErrorAdminState extends AdminState {
  final String message;

  ErrorAdminState({
    required this.message,
  });
}

class LoadingAdminState extends AdminState {}

class GotStatusAdminState extends AdminState {
  final List<CaseStatus> statuses;

  GotStatusAdminState({
    required this.statuses,
  });
}
