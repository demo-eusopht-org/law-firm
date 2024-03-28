import 'package:json_annotation/json_annotation.dart';

import '../users/login_model.dart';

part 'app_version_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppVersionModel {
  final String message;
  final int status;
  final List<Versions> versions;

  AppVersionModel({
    required this.message,
    required this.status,
    this.versions = const [],
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Versions {
  final int id;
  final String fileName;
  final String versionNumber;
  final String releaseNotes;
  final User uploadedBy;
  final bool forceUpdate;
  final bool status;
  Versions({
    required this.id,
    required this.fileName,
    required this.releaseNotes,
    required this.versionNumber,
    required this.uploadedBy,
    required this.forceUpdate,
    required this.status,
  });
  factory Versions.fromJson(Map<String, dynamic> json) =>
      _$VersionsFromJson(json);
  Map<String, dynamic> toJson() => _$VersionsToJson(this);
}
