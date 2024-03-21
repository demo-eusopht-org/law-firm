// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoleModel _$GetRoleModelFromJson(Map<String, dynamic> json) => GetRoleModel(
      status: json['status'] as int,
      message: json['message'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRoleModelToJson(GetRoleModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'roles': instance.roles,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: json['id'] as int,
      roleName: json['role_name'] as String,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'role_name': instance.roleName,
    };
