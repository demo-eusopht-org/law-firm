// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_lawyers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllLawyerModel _$GetAllLawyerModelFromJson(Map<String, dynamic> json) =>
    GetAllLawyerModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      lawyers: (json['lawyers'] as List<dynamic>?)
              ?.map((e) => AllLawyer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetAllLawyerModelToJson(GetAllLawyerModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'lawyers': instance.lawyers.map((e) => e.toJson()).toList(),
    };

AllLawyer _$AllLawyerFromJson(Map<String, dynamic> json) => AllLawyer(
      id: json['id'] as int?,
      cnic: json['cnic'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      decription: json['decription'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePic: json['profile_pic'] as String?,
      lawyerCredentials: json['lawyer_credentials'] as String?,
      lawyerBio: json['lawyer_bio'] as String?,
      expertise: json['expertise'] as String?,
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => AllLawyerExp.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      qualification: (json['qualification'] as List<dynamic>?)
              ?.map((e) =>
                  AlllawyerQualification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AllLawyerToJson(AllLawyer instance) => <String, dynamic>{
      'id': instance.id,
      'cnic': instance.cnic,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'decription': instance.decription,
      'profile_pic': instance.profilePic,
      'phone_number': instance.phoneNumber,
      'lawyer_credentials': instance.lawyerCredentials,
      'expertise': instance.expertise,
      'lawyer_bio': instance.lawyerBio,
      'experience': instance.experience.map((e) => e.toJson()).toList(),
      'qualification': instance.qualification.map((e) => e.toJson()).toList(),
    };

AllLawyerExp _$AllLawyerExpFromJson(Map<String, dynamic> json) => AllLawyerExp(
      id: json['id'] as int?,
      jobTitle: json['job_title'] as String?,
      employer: json['employer'] as String?,
      startYear: json['start_year'] as int?,
      endYear: json['end_year'] as int?,
      userId: json['user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updateedAt: json['updateed_at'] as String?,
    );

Map<String, dynamic> _$AllLawyerExpToJson(AllLawyerExp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_title': instance.jobTitle,
      'employer': instance.employer,
      'start_year': instance.startYear,
      'end_year': instance.endYear,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updateed_at': instance.updateedAt,
    };

AlllawyerQualification _$AlllawyerQualificationFromJson(
        Map<String, dynamic> json) =>
    AlllawyerQualification(
      id: json['id'] as int?,
      degree: json['degree'] as String?,
      institute: json['institute'] as String?,
      startYear: json['start_year'] as int?,
      endYear: json['end_year'] as int?,
      userId: json['user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updateedAt: json['updateed_at'] as String?,
    );

Map<String, dynamic> _$AlllawyerQualificationToJson(
        AlllawyerQualification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'degree': instance.degree,
      'institute': instance.institute,
      'start_year': instance.startYear,
      'end_year': instance.endYear,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updateed_at': instance.updateedAt,
    };
