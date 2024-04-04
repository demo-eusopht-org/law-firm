// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_company_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCompanyResponse _$AllCompanyResponseFromJson(Map<String, dynamic> json) =>
    AllCompanyResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AllCompanyResponseToJson(AllCompanyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as int,
      companyName: json['company_name'] as String,
      companyAdmin: json['company_admin'] == null
          ? null
          : User.fromJson(json['company_admin'] as Map<String, dynamic>),
      createdAt: dateFromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'company_name': instance.companyName,
      'company_admin': instance.companyAdmin?.toJson(),
      'created_at': instance.createdAt.toIso8601String(),
    };
