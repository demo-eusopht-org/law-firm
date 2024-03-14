// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseStatusResponse _$CaseStatusResponseFromJson(Map<String, dynamic> json) =>
    CaseStatusResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CaseStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CaseStatusResponseToJson(CaseStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CaseStatus _$CaseStatusFromJson(Map<String, dynamic> json) => CaseStatus(
      id: json['id'] as int,
      statusName: json['status_name'] as String,
    );

Map<String, dynamic> _$CaseStatusToJson(CaseStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status_name': instance.statusName,
    };
