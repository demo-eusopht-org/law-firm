import 'package:case_management/model/cases/case_status.dart';
import 'package:case_management/model/lawyers/get_all_lawyers_model.dart';

import '../../../model/cases/all_cases_response.dart';
import '../../../model/open_file_model.dart';

abstract class HistoryEvent {}

class GetHistoryEvent extends HistoryEvent {
  final Case caseData;

  GetHistoryEvent({
    required this.caseData,
  });
}

class GetDataHistoryEvent extends HistoryEvent {}

class CreateProceedingEvent extends HistoryEvent {
  final String caseNo;
  final String judgeName;
  final CaseStatus status;
  final String proceedings;
  final String oppositePartyLawyer;
  final String assigneeSwitchReason;
  final DateTime nextHearingDate;
  final AllLawyer? nextAssignee;
  final List<OpenFileModel> files;

  CreateProceedingEvent({
    required this.caseNo,
    required this.judgeName,
    required this.status,
    required this.proceedings,
    required this.oppositePartyLawyer,
    required this.assigneeSwitchReason,
    required this.nextHearingDate,
    this.nextAssignee,
    required this.files,
  });
}
