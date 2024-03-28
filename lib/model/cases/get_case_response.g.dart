// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_case_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCaseResponse _$GetCaseResponseFromJson(Map<String, dynamic> json) =>
    GetCaseResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Case.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCaseResponseToJson(GetCaseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data?.toJson(),
    };
