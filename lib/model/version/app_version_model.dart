import 'package:json_annotation/json_annotation.dart';

part 'app_version_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppVersionModel {
  String? message;
  int? status;
  List<Versions> versions;

  AppVersionModel({
    this.message,
    this.status,
    this.versions = const [],
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Versions {
  int? id;
  String? fileName;
  String? versionNumber;
  String? releaseNotes;
  List<UploadedBy> uploadedBy;

  Versions({
    this.id,
    this.fileName,
    this.releaseNotes,
    this.versionNumber,
    this.uploadedBy = const [],
  });
  factory Versions.fromJson(Map<String, dynamic> json) =>
      _$VersionsFromJson(json);
  Map<String, dynamic> toJson() => _$VersionsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UploadedBy {
  int? id;
  String? cnic;
  String? firstName;
  String? lastName;
  String? email;
  String? description;
  int? role;
  String? phoneNumber;
  String? profilePic;
  int? Status;
  String? createdAt;
  String? updatedAt;
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
    this.Status,
    this.role,
    this.roleName,
    this.createdAt,
    this.updatedAt,
  });
  factory UploadedBy.fromJson(Map<String, dynamic> json) =>
      _$UploadedByFromJson(json);
  Map<String, dynamic> toJson() => _$UploadedByToJson(this);
}
