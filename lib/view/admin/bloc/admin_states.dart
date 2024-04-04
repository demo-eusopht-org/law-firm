import '../../../model/cases/case_status.dart';
import '../../../model/lawyers/get_all_lawyers_model.dart';

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

class GotAdminsState extends AdminState {
  final List<AllLawyer> lawyers;

  GotAdminsState({
    required this.lawyers,
  });
}

class CreateCompanySuccessState extends AdminState {}
