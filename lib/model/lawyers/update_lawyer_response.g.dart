// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_lawyer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLawyerResponse _$UpdateLawyerResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateLawyerResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LawyerProfile.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateLawyerResponseToJson(
        UpdateLawyerResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data?.toJson(),
    };

LawyerProfile _$LawyerProfileFromJson(Map<String, dynamic> json) =>
    LawyerProfile(
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      role: json['role'] as int,
      lawyerCredentials: json['lawyer_credentials'] as String,
      expertise: json['expertise'] as String,
      lawyerBio: json['lawyer_bio'] as String,
      experience: (json['experience'] as List<dynamic>)
          .map((e) => Exp.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualification: (json['qualification'] as List<dynamic>)
          .map((e) => Qualification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LawyerProfileToJson(LawyerProfile instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'role': instance.role,
      'lawyer_credentials': instance.lawyerCredentials,
      'expertise': instance.expertise,
      'lawyer_bio': instance.lawyerBio,
      'experience': instance.experience.map((e) => e.toJson()).toList(),
      'qualification': instance.qualification.map((e) => e.toJson()).toList(),
    };
