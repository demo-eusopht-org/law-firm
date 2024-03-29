// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_cases_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCasesResponse _$AllCasesResponseFromJson(Map<String, dynamic> json) =>
    AllCasesResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Case.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCasesResponseToJson(AllCasesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

Case _$CaseFromJson(Map<String, dynamic> json) => Case(
      id: json['id'] as int,
      caseNo: json['case_no'] as String,
      plaintiff: json['plaintiff'] as String,
      defendant: json['defendant'] as String,
      plaintiffAdvocate: json['plaintiff_advocate'] as String,
      defendantAdvocate: json['defendant_advocate'] as String,
      isCustomerPlaintiff: boolFromJson(json['is_customer_plaintiff'] as int?),
      caseFilingDate: dateFromJson(json['case_filing_date'] as String),
      nextHearingDate: dateFromJson(json['next_hearing_date'] as String),
      judge: json['judge'] as String,
      courtLocation: json['court_location'] as String,
      year: json['year'] as int,
      currentProceedings: json['current_proceedings'] as String,
      caseStatus: json['case_status'] as String,
      statusId: json['status_id'] as int,
      typeId: json['type_id'] as int,
      caseType: json['case_type'] as String,
      courtId: json['court_id'] as int,
      courtType: json['court_type'] as String,
      caseFiles: (json['case_files'] as List<dynamic>)
          .map((e) => CaseFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      caseCustomer: json['case_customer'] == null
          ? null
          : User.fromJson(json['case_customer'] as Map<String, dynamic>),
      caseLawyer: json['case_lawyer'] == null
          ? null
          : User.fromJson(json['case_lawyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaseToJson(Case instance) => <String, dynamic>{
      'id': instance.id,
      'case_no': instance.caseNo,
      'plaintiff': instance.plaintiff,
      'defendant': instance.defendant,
      'plaintiff_advocate': instance.plaintiffAdvocate,
      'defendant_advocate': instance.defendantAdvocate,
      'is_customer_plaintiff': instance.isCustomerPlaintiff,
      'case_filing_date': instance.caseFilingDate.toIso8601String(),
      'next_hearing_date': instance.nextHearingDate.toIso8601String(),
      'judge': instance.judge,
      'court_location': instance.courtLocation,
      'year': instance.year,
      'current_proceedings': instance.currentProceedings,
      'case_status': instance.caseStatus,
      'status_id': instance.statusId,
      'type_id': instance.typeId,
      'case_type': instance.caseType,
      'court_id': instance.courtId,
      'court_type': instance.courtType,
      'case_files': instance.caseFiles.map((e) => e.toJson()).toList(),
      'case_customer': instance.caseCustomer?.toJson(),
      'case_lawyer': instance.caseLawyer?.toJson(),
    };

CaseFile _$CaseFileFromJson(Map<String, dynamic> json) => CaseFile(
      id: json['id'] as int,
      fileName: json['file_name'] as String,
      fileTitle: json['file_title'] as String,
      caseId: json['case_id'] as int,
      createdAt: dateFromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$CaseFileToJson(CaseFile instance) => <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'file_title': instance.fileTitle,
      'case_id': instance.caseId,
      'created_at': instance.createdAt.toIso8601String(),
    };
