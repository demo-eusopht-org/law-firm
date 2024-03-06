// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawyerRequestModel _$LawyerRequestModelFromJson(Map<String, dynamic> json) =>
    LawyerRequestModel(
      cnic: json['cnic'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as int?,
      role: json['role'] as int?,
      lawyerCredential: json['lawyer_credential'] as String?,
      experience: json['experience'] as String?,
      expertise: json['expertise'] as String?,
      lawyerBio: json['lawyer_bio'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LawyerRequestModelToJson(LawyerRequestModel instance) =>
    <String, dynamic>{
      'cnic': instance.cnic,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'role': instance.role,
      'lawyer_credential': instance.lawyerCredential,
      'experience': instance.experience,
      'expertise': instance.expertise,
      'lawyer_bio': instance.lawyerBio,
      'password': instance.password,
    };
