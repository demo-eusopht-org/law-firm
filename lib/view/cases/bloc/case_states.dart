import '../../../model/cases/case_status.dart';
import '../../../model/cases/case_type.dart';
import '../../../model/cases/court_type.dart';
import '../../../model/get_all_lawyers_model.dart';
import '../../../model/lawyers/all_clients_response.dart';

abstract class CaseState {}

class InitialCaseState extends CaseState {}

class LoadingCaseState extends CaseState {}

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
