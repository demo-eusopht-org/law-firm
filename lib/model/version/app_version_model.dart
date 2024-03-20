import 'package:json_annotation/json_annotation.dart';

import '../../utils/json_utils.dart';

part 'app_version_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppVersionModel {
  String? message;
  int? status;
  final List<Versions> versions;

  AppVersionModel({
    this.message,
    this.status,
    required this.versions,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Versions {
  int? id;
  @JsonKey(name: 'file_name')
  String? fileName;
  @JsonKey(name: 'version_number')
  String? versionNumber;
  @JsonKey(name: 'release_notes')
  String? releaseNotes;
  @JsonKey(name: 'uploaded_by')
  UploadedBy uploadedBy;
  @JsonKey(name: 'force_update')
  bool? forceUpdate;
  @JsonKey(name: 'status')
  bool? status;
  Versions({
    this.id,
    this.fileName,
    this.releaseNotes,
    this.versionNumber,
    required this.uploadedBy,
    this.forceUpdate,
    this.status,
  });
  factory Versions.fromJson(Map<String, dynamic> json) =>
      _$VersionsFromJson(json);
  Map<String, dynamic> toJson() => _$VersionsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UploadedBy {
  int? id;
  String? cnic;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  String? email;
  String? description;
  int? role;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'profile_pic')
  String? profilePic;
  int? status;
  @JsonKey(fromJson: dateFromJson)
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'role_name')
  String? roleName;

  UploadedBy({
    this.id,
    this.cnic,
    this.firstName,
    this.lastName,
    this.email,
    this.description,
    this.phoneNumber,
    this.profilePic,
    this.status,
    this.role,
    this.roleName,
    this.createdAt,
    this.updatedAt,
  });
  factory UploadedBy.fromJson(Map<String, dynamic> json) =>
      _$UploadedByFromJson(json);
  Map<String, dynamic> toJson() => _$UploadedByToJson(this);
}
