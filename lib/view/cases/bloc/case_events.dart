import '../../../model/cases/case_status.dart';
import '../../../model/cases/case_type.dart';
import '../../../model/cases/court_type.dart';
import '../../../model/get_all_lawyers_model.dart';
import '../../../model/lawyers/all_clients_response.dart';
import '../../../model/open_file_model.dart';

abstract class CaseEvent {}

class GetDataCaseEvent extends CaseEvent {}

class CreateCaseEvent extends CaseEvent {
  final String caseNo;
  final String plaintiff;
  final String defendant;
  final String plaintiffAdvocate;
  final String defendantAdvocate;
  final CaseType caseType;
  final CaseStatus caseStatus;
  final CourtType courtType;
  final Client caseClient;
  final bool isCustomerPlaintiff;
  final DateTime caseFilingDate;
  final DateTime nextHearingDate;
  final String judgeName;
  final String courtLocation;
  final String year;
  final AllLawyer caseLawyer;
  final String proceedings;
  final List<OpenFileModel> files;

  CreateCaseEvent({
    required this.caseNo,
    required this.plaintiff,
    required this.defendant,
    required this.plaintiffAdvocate,
    required this.defendantAdvocate,
    required this.caseType,
    required this.caseStatus,
    required this.courtType,
    required this.caseClient,
    required this.isCustomerPlaintiff,
    required this.caseFilingDate,
    required this.nextHearingDate,
    required this.judgeName,
    required this.courtLocation,
    required this.year,
    required this.caseLawyer,
    required this.proceedings,
    required this.files,
  });
}
