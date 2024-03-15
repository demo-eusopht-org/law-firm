// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientRequestModel _$ClientRequestModelFromJson(Map<String, dynamic> json) =>
    ClientRequestModel(
      cnic: json['cnic'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$ClientRequestModelToJson(ClientRequestModel instance) =>
    <String, dynamic>{
      'cnic': instance.cnic,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
    };
