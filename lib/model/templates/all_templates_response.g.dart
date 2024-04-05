// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_templates_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTemplatesResponse _$AllTemplatesResponseFromJson(
        Map<String, dynamic> json) =>
    AllTemplatesResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => Template.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllTemplatesResponseToJson(
        AllTemplatesResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      id: json['id'] as int,
      title: json['title'] as String,
      fileName: json['file_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'file_name': instance.fileName,
      'created_at': instance.createdAt.toIso8601String(),
    };
