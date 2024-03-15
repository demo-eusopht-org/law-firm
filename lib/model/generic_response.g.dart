// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericResponse _$GenericResponseFromJson(Map<String, dynamic> json) =>
    GenericResponse(
      message: json['message'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$GenericResponseToJson(GenericResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
