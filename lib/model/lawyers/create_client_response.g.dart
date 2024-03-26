// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_client_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateClientResponse _$CreateClientResponseFromJson(
        Map<String, dynamic> json) =>
    CreateClientResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      clientId: json['client_id'] as int?,
    );

Map<String, dynamic> _$CreateClientResponseToJson(
        CreateClientResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'client_id': instance.clientId,
    };
