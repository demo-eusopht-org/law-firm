// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigResponse _$AppConfigResponseFromJson(Map<String, dynamic> json) =>
    AppConfigResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AppConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AppConfigResponseToJson(AppConfigResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      permissionId: json['permission_id'] as int,
      permissionName: json['permission_name'] as String,
      roleId: json['role_id'] as int,
      isAllowed: json['is_allowed'] as bool,
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'permission_id': instance.permissionId,
      'permission_name': instance.permissionName,
      'role_id': instance.roleId,
      'is_allowed': instance.isAllowed,
    };
