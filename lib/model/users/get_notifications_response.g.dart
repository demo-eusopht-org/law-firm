// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationsResponse _$GetNotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    GetNotificationsResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => Notification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetNotificationsResponseToJson(
        GetNotificationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'notifications': instance.notifications.map((e) => e.toJson()).toList(),
    };

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['user_id'] as int,
      image: json['image'] as String?,
      createdAt: dateFromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'user_id': instance.userId,
      'image': instance.image,
      'created_at': instance.createdAt.toIso8601String(),
    };
