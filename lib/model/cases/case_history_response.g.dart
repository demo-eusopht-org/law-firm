// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseHistoryResponse _$CaseHistoryResponseFromJson(Map<String, dynamic> json) =>
    CaseHistoryResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      caseNo: json['case_no'] as String?,
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => CaseHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CaseHistoryResponseToJson(
        CaseHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'case_no': instance.caseNo,
      'history': instance.history.map((e) => e.toJson()).toList(),
    };

CaseHistory _$CaseHistoryFromJson(Map<String, dynamic> json) => CaseHistory(
      id: json['id'] as int,
      caseStatus: json['case_status'] as int,
      year: json['year'] as int,
      hearingDate: dateFromJson(json['hearing_date'] as String),
      hearingProceedings: json['hearing_proceedings'] as String,
      judgeName: json['judge_name'] as String,
      oppositePartyAdvocate: json['opposite_party_advocate'] as String,
      caseId: json['case_id'] as int,
      caseAssignedTo:
          User.fromJson(json['case_assigned_to'] as Map<String, dynamic>),
      assigneeSwitchReason: json['assignee_switch_reason'] as String,
      caseStatusName: json['case_status_name'] as String,
      createdAt: dateFromJson(json['created_at'] as String),
      files: (json['files'] as List<dynamic>)
          .map((e) => CaseFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CaseHistoryToJson(CaseHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'case_status': instance.caseStatus,
      'year': instance.year,
      'hearing_date': instance.hearingDate.toIso8601String(),
      'hearing_proceedings': instance.hearingProceedings,
      'judge_name': instance.judgeName,
      'opposite_party_advocate': instance.oppositePartyAdvocate,
      'case_id': instance.caseId,
      'case_assigned_to': instance.caseAssignedTo.toJson(),
      'assignee_switch_reason': instance.assigneeSwitchReason,
      'case_status_name': instance.caseStatusName,
      'created_at': instance.createdAt.toIso8601String(),
      'files': instance.files.map((e) => e.toJson()).toList(),
    };
