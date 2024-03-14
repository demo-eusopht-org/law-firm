import '../../../model/cases/case_status.dart';
import '../../../model/cases/case_type.dart';
import '../../../model/cases/court_type.dart';

abstract class CaseState {}

class InitialCaseState extends CaseState {}

class LoadingCaseState extends CaseState {}

class DataSuccessCaseState extends CaseState {
  final List<CaseType> caseTypes;
  final List<CaseStatus> caseStatuses;
  final List<CourtType> courtTypes;

  DataSuccessCaseState({
    required this.caseTypes,
    required this.caseStatuses,
    required this.courtTypes,
  });
}
