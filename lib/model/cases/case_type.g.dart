// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseTypeResponse _$CaseTypeResponseFromJson(Map<String, dynamic> json) =>
    CaseTypeResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CaseType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CaseTypeResponseToJson(CaseTypeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CaseType _$CaseTypeFromJson(Map<String, dynamic> json) => CaseType(
      id: json['id'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$CaseTypeToJson(CaseType instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
