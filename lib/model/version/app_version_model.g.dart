// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionModel _$AppVersionModelFromJson(Map<String, dynamic> json) =>
    AppVersionModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      versions: (json['versions'] as List<dynamic>)
          .map((e) => Versions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppVersionModelToJson(AppVersionModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'versions': instance.versions.map((e) => e.toJson()).toList(),
    };

Versions _$VersionsFromJson(Map<String, dynamic> json) => Versions(
      id: json['id'] as int?,
      fileName: json['file_name'] as String?,
      releaseNotes: json['release_notes'] as String?,
      versionNumber: json['version_number'] as String?,
      uploadedBy:
          UploadedBy.fromJson(json['uploaded_by'] as Map<String, dynamic>),
      forceUpdate: json['force_update'] as bool?,
      status: json['status'] as bool?,
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

UploadedBy _$UploadedByFromJson(Map<String, dynamic> json) => UploadedBy(
      id: json['id'] as int?,
      cnic: json['cnic'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePic: json['profile_pic'] as String?,
      status: json['status'] as int?,
      role: json['role'] as int?,
      roleName: json['role_name'] as String?,
      createdAt: dateFromJson(json['created_at'] as String),
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$UploadedByToJson(UploadedBy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cnic': instance.cnic,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'description': instance.description,
      'role': instance.role,
      'phone_number': instance.phoneNumber,
      'profile_pic': instance.profilePic,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt,
      'role_name': instance.roleName,
    };
