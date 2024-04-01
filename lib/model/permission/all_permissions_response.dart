import 'package:case_management/model/generic_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'get_role_model.dart';

part 'all_permissions_response.g.dart';

@JsonSerializable()
class AllPermissionsResponse extends GenericResponse {
  final List<AppPermission> permissions;

  AllPermissionsResponse({
    required super.status,
    required super.message,
    required this.permissions,
  });

  factory AllPermissionsResponse.fromJson(Map<String, dynamic> json) {
    return _$AllPermissionsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AllPermissionsResponseToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class AppPermission {
  final int id;
  final String permission;
  final List<RoleEnabled> roles;

  AppPermission({
    required this.id,
    required this.permission,
    required this.roles,
  });

  factory AppPermission.fromJson(Map<String, dynamic> json) {
    return _$AppPermissionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AppPermissionToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RoleEnabled extends Role {
  final bool enabled;

  RoleEnabled({
    required this.enabled,
    required super.id,
    required super.roleName,
  });

  factory RoleEnabled.fromJson(Map<String, dynamic> json) {
    return _$RoleEnabledFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$RoleEnabledToJson(this);
  }
}
