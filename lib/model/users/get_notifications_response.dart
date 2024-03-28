import 'package:case_management/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_notifications_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetNotificationsResponse {
  final int status;
  final String message;
  final List<Notification> notifications;

  GetNotificationsResponse({
    required this.status,
    required this.message,
    this.notifications = const [],
  });

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetNotificationsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetNotificationsResponseToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Notification {
  final int id;
  final String title;
  final String body;
  final int userId;
  final String? image;
  @JsonKey(fromJson: dateFromJson)
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.image,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NotificationToJson(this);
  }
}
