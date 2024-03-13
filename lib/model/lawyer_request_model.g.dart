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
      phoneNumber: json['phone_number'] as String?,
      role: json['role'] as String?,
      lawyerCredential: json['lawyer_credential'] as String?,
      experience: json['experience'] as String?,
      expertise: json['expertise'] == null
          ? null
          : Exp.fromJson(json['expertise'] as Map<String, dynamic>),
      lawyerBio: json['lawyer_bio'] as String?,
      password: json['password'] as String?,
    )..qualification = json['qualification'] == null
        ? null
        : Qualification.fromJson(json['qualification'] as Map<String, dynamic>);

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
      'expertise': instance.expertise?.toJson(),
      'lawyer_bio': instance.lawyerBio,
      'password': instance.password,
      'qualification': instance.qualification?.toJson(),
    };

Exp _$ExpFromJson(Map<String, dynamic> json) => Exp(
      jobTitle: json['job_title'] as String?,
      employer: json['employer'] as String?,
      startYear: json['start_year'] as int?,
      endYear: json['end_year'] as int?,
    );

Map<String, dynamic> _$ExpToJson(Exp instance) => <String, dynamic>{
      'job_title': instance.jobTitle,
      'employer': instance.employer,
      'start_year': instance.startYear,
      'end_year': instance.endYear,
    };

Qualification _$QualificationFromJson(Map<String, dynamic> json) =>
    Qualification(
      degree: json['degree'] as String?,
      institute: json['institute'] as String?,
      startYear: json['start_year'] as int?,
      endYear: json['end_year'] as int?,
    );

Map<String, dynamic> _$QualificationToJson(Qualification instance) =>
    <String, dynamic>{
      'degree': instance.degree,
      'institute': instance.institute,
      'start_year': instance.startYear,
      'end_year': instance.endYear,
    };
