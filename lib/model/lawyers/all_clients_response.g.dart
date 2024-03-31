// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_clients_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllClientsResponse _$AllClientsResponseFromJson(Map<String, dynamic> json) =>
    AllClientsResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllClientsResponseToJson(AllClientsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as int,
      cnic: json['cnic'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      description: json['description'] as String?,
      role: json['role'] as int,
      phoneNumber: json['phone_number'] as String,
      profilePic: json['profile_pic'] as String?,
      roleName: json['role_name'] as String,
      status: boolFromJson(json['status'] as int?),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'cnic': instance.cnic,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'description': instance.description,
      'role': instance.role,
      'phone_number': instance.phoneNumber,
      'profile_pic': instance.profilePic,
      'role_name': instance.roleName,
      'status': instance.status,
    };
