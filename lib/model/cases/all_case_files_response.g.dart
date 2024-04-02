// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_case_files_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCaseFilesResponse _$AllCaseFilesResponseFromJson(
        Map<String, dynamic> json) =>
    AllCaseFilesResponse(
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => CaseFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )
      ..message = json['message'] as String?
      ..status = json['status'] as int?;

Map<String, dynamic> _$AllCaseFilesResponseToJson(
        AllCaseFilesResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'files': instance.files.map((e) => e.toJson()).toList(),
    };
