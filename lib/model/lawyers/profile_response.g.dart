// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      user: json['user'] == null
          ? null
          : Profile.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user?.toJson(),
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
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
      lawyerCredentials: json['lawyer_credentials'] as String?,
      expertise: json['expertise'] as String?,
      lawyerBio: json['lawyer_bio'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
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
      'lawyer_credentials': instance.lawyerCredentials,
      'expertise': instance.expertise,
      'lawyer_bio': instance.lawyerBio,
    };
