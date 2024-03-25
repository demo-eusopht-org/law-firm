// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionModel _$AppVersionModelFromJson(Map<String, dynamic> json) =>
    AppVersionModel(
      message: json['message'] as String,
      status: json['status'] as int,
      versions: (json['versions'] as List<dynamic>?)
              ?.map((e) => Versions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AppVersionModelToJson(AppVersionModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'versions': instance.versions.map((e) => e.toJson()).toList(),
    };

Versions _$VersionsFromJson(Map<String, dynamic> json) => Versions(
      id: json['id'] as int,
      fileName: json['file_name'] as String,
      releaseNotes: json['release_notes'] as String,
      versionNumber: json['version_number'] as String,
      uploadedBy: User.fromJson(json['uploaded_by'] as Map<String, dynamic>),
      forceUpdate: json['force_update'] as bool,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$VersionsToJson(Versions instance) => <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'version_number': instance.versionNumber,
      'release_notes': instance.releaseNotes,
      'uploaded_by': instance.uploadedBy.toJson(),
      'force_update': instance.forceUpdate,
      'status': instance.status,
    };
