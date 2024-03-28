import 'package:case_management/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import '../users/login_model.dart';
import 'all_cases_response.dart';

part 'case_history_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CaseHistoryResponse {
  final int status;
  final String message;
  final String? caseNo;
  final List<CaseHistory> history;

  CaseHistoryResponse({
    required this.status,
    required this.message,
    this.caseNo,
    this.history = const [],
  });

  factory CaseHistoryResponse.fromJson(Map<String, dynamic> json) {
    return _$CaseHistoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseHistoryResponseToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CaseHistory {
  final int id;
  final int caseStatus;
  final int year;
  @JsonKey(fromJson: dateFromJson)
  final DateTime hearingDate;
  final String hearingProceedings;
  final String judgeName;
  final String oppositePartyAdvocate;
  final int caseId;
  final User caseAssignedTo;
  final String assigneeSwitchReason;
  final String caseStatusName;
  @JsonKey(fromJson: dateFromJson)
  final DateTime createdAt;
  final List<CaseFile> files;

  CaseHistory({
    required this.id,
    required this.caseStatus,
    required this.year,
    required this.hearingDate,
    required this.hearingProceedings,
    required this.judgeName,
    required this.oppositePartyAdvocate,
    required this.caseId,
    required this.caseAssignedTo,
    required this.assigneeSwitchReason,
    required this.caseStatusName,
    required this.createdAt,
    required this.files,
  });

  factory CaseHistory.fromJson(Map<String, dynamic> json) {
    return _$CaseHistoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseHistoryToJson(this);
  }
}
