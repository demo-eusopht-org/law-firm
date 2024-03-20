// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_proceeding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProceedingResponse _$AddProceedingResponseFromJson(
        Map<String, dynamic> json) =>
    AddProceedingResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      proceedingId: json['proceeding_id'] as int?,
    );

Map<String, dynamic> _$AddProceedingResponseToJson(
        AddProceedingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'proceeding_id': instance.proceedingId,
    };
