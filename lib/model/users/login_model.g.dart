// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'token': instance.token,
      'data': instance.data,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      cnic: json['cnic'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      description: json['description'] as String?,
      role: json['role'] as int,
      phoneNumber: json['phone_number'] as String,
      profilePic: json['profile_pic'] as String?,
      notificationsEnabled: json['notifications_enabled'] as bool,
      status: json['status'] as int,
      createdAt: dateFromJson(json['created_at'] as String),
      updatedAt: dateFromJson(json['updated_at'] as String),
      roleId: json['role_id'] as int,
      roleName: json['role_name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'cnic': instance.cnic,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'description': instance.description,
      'role': instance.role,
      'status': instance.status,
      'phone_number': instance.phoneNumber,
      'profile_pic': instance.profilePic,
      'notifications_enabled': instance.notificationsEnabled,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'role_id': instance.roleId,
      'role_name': instance.roleName,
    };
