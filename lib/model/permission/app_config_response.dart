import 'package:json_annotation/json_annotation.dart';

part 'app_config_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AppConfigResponse {
  final int status;
  final String message;
  final List<AppConfig> data;

  AppConfigResponse({
    required this.status,
    required this.message,
    this.data = const [],
  });

  factory AppConfigResponse.fromJson(Map<String, dynamic> json) {
    return _$AppConfigResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AppConfigResponseToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AppConfig {
  final int permissionId;
  final String permissionName;
  final int roleId;
  final bool isAllowed;

  AppConfig({
    required this.permissionId,
    required this.permissionName,
    required this.roleId,
    required this.isAllowed,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return _$AppConfigFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AppConfigToJson(this);
  }
}
