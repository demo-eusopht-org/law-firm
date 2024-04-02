import '../../../model/cases/case_status.dart';
import '../../../model/cases/case_type.dart';
import '../../../model/cases/court_type.dart';
import '../../../model/lawyers/all_clients_response.dart';
import '../../../model/lawyers/get_all_lawyers_model.dart';
import '../../../model/open_file_model.dart';

abstract class CaseEvent {}

class GetDataCaseEvent extends CaseEvent {}

class GetCasesEvent extends CaseEvent {}

class GetCaseEvent extends CaseEvent {
  final String caseNo;

  GetCaseEvent({
    required this.caseNo,
  });
}

class GetUserCasesEvent extends CaseEvent {
  final int userId;

  GetUserCasesEvent({
    required this.userId,
  });
}

class AssignLawyerEvent extends CaseEvent {
  final String caseNo;
  final String cnic;

  AssignLawyerEvent({
    required this.cnic,
    required this.caseNo,
  });
}

class AssignClientEvent extends CaseEvent {
  final String caseNo;
  final String cnic;

  AssignClientEvent({
    required this.caseNo,
    required this.cnic,
  });
}

class DeleteCaseEvent extends CaseEvent {
  final String caseNo;

  DeleteCaseEvent({
    required this.caseNo,
  });
}

class CreateCaseEvent extends CaseEvent {
  final String caseNo;
  final String plaintiff;
  final String defendant;
  final String plaintiffAdvocate;
  final String defendantAdvocate;
  final CaseType caseType;
  final CaseStatus caseStatus;
  final CourtType courtType;
  final Client? caseClient;
  final bool? isCustomerPlaintiff;
  final DateTime caseFilingDate;
  final DateTime nextHearingDate;
  final String judgeName;
  final String courtLocation;
  final String year;
  final AllLawyer? caseLawyer;
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
    this.caseClient,
    this.isCustomerPlaintiff,
    required this.caseFilingDate,
    required this.nextHearingDate,
    required this.judgeName,
    required this.courtLocation,
    required this.year,
    this.caseLawyer,
    required this.proceedings,
    required this.files,
  });
}

class GetCaseFilesEvent extends CaseEvent {
  final String caseNo;

  GetCaseFilesEvent({
    required this.caseNo,
  });
}

class UploadCaseFileEvent extends CaseEvent {
  final OpenFileModel file;
  final String caseNo;

  UploadCaseFileEvent({
    required this.caseNo,
    required this.file,
  });
}
