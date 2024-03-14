// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourtTypeResponse _$CourtTypeResponseFromJson(Map<String, dynamic> json) =>
    CourtTypeResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CourtType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourtTypeResponseToJson(CourtTypeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CourtType _$CourtTypeFromJson(Map<String, dynamic> json) => CourtType(
      id: json['id'] as int,
      court: json['court'] as String,
    );

Map<String, dynamic> _$CourtTypeToJson(CourtType instance) => <String, dynamic>{
      'id': instance.id,
      'court': instance.court,
    };
