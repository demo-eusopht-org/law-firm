import '../../../model/cases/all_cases_response.dart';
import '../../../model/cases/case_status.dart';
import '../../../model/cases/case_type.dart';
import '../../../model/cases/court_type.dart';
import '../../../model/lawyers/all_clients_response.dart';
import '../../../model/lawyers/get_all_lawyers_model.dart';

abstract class CaseState {}

class InitialCaseState extends CaseState {}

class LoadingCaseState extends CaseState {}

class AllCasesState extends CaseState {
  final List<Case> cases;

  AllCasesState({
    required this.cases,
  });
}

class SuccessCaseState extends CaseState {
  final Case caseData;

  SuccessCaseState({
    required this.caseData,
  });
}

class ErrorCaseState extends CaseState {
  final String message;

  ErrorCaseState({
    required this.message,
  });
}

class DataSuccessCaseState extends CaseState {
  final List<CaseType> caseTypes;
  final List<CaseStatus> caseStatuses;
  final List<CourtType> courtTypes;
  final List<Client> clients;
  final List<AllLawyer> lawyers;

  DataSuccessCaseState({
    required this.caseTypes,
    required this.caseStatuses,
    required this.courtTypes,
    required this.clients,
    required this.lawyers,
  });
}

class SubmittingCaseState extends CaseState {}

class SubmitSuccessCaseState extends CaseState {}
