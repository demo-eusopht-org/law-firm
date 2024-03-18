import 'package:case_management/model/cases/case_status.dart';

import '../../../model/login_model.dart';
import '../../../model/open_file_model.dart';

abstract class HistoryEvent {}

class GetHistoryEvent extends HistoryEvent {
  final String caseNo;

  GetHistoryEvent({
    required this.caseNo,
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
  final User nextAssignee;
  final List<OpenFileModel> files;

  CreateProceedingEvent({
    required this.caseNo,
    required this.judgeName,
    required this.status,
    required this.proceedings,
    required this.oppositePartyLawyer,
    required this.assigneeSwitchReason,
    required this.nextHearingDate,
    required this.nextAssignee,
    required this.files,
  });
}
