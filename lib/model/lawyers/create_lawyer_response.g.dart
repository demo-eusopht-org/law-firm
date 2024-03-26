// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_lawyer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLawyerResponse _$CreateLawyerResponseFromJson(
        Map<String, dynamic> json) =>
    CreateLawyerResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      lawyerId: json['lawyer_id'] as int?,
    );

Map<String, dynamic> _$CreateLawyerResponseToJson(
        CreateLawyerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'lawyer_id': instance.lawyerId,
    };
