import '../../../model/users/get_notifications_response.dart';

abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class LoadingNotificationState extends NotificationState {}

class SuccessNotificationState extends NotificationState {
  final List<Notification> notifications;

  SuccessNotificationState({
    required this.notifications,
  });
}

class ErrorNotificationState extends NotificationState {
  final String message;

  ErrorNotificationState({
    required this.message,
  });
}
