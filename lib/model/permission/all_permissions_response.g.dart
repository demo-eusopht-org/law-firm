// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_permissions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPermissionsResponse _$AllPermissionsResponseFromJson(
        Map<String, dynamic> json) =>
    AllPermissionsResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => AppPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPermissionsResponseToJson(
        AllPermissionsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'permissions': instance.permissions,
    };

AppPermission _$AppPermissionFromJson(Map<String, dynamic> json) =>
    AppPermission(
      id: json['id'] as int,
      permission: json['permission'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleEnabled.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppPermissionToJson(AppPermission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'permission': instance.permission,
      'roles': instance.roles.map((e) => e.toJson()).toList(),
    };

RoleEnabled _$RoleEnabledFromJson(Map<String, dynamic> json) => RoleEnabled(
      enabled: json['enabled'] as bool,
      id: json['id'] as int,
      roleName: json['role_name'] as String,
    );

Map<String, dynamic> _$RoleEnabledToJson(RoleEnabled instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role_name': instance.roleName,
      'enabled': instance.enabled,
    };
