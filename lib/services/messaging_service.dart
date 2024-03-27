import 'dart:developer';

import 'package:case_management/services/notification_service.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'locator.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.notification?.title}');
}

class MessagingService {
  final _instance = FirebaseMessaging.instance;
  final _notificationService = locator<NotificationService>();

  MessagingService() {
    _init();
  }

  Future<void> _init() async {
    final status = await _instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );
    if (status.authorizationStatus == AuthorizationStatus.authorized) {
      await _setupNotifications();
    } else {
      CustomToast.show('Notification permission is required!');
    }
  }

  Future<void> _setupNotifications() async {
    final token = await _instance.getToken();
    log('TOKEN: $token');
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification?.title != null && notification?.body != null) {
        _notificationService.show(
          title: notification!.title!,
          body: notification.body!,
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<String?> getToken() async {
    try {
      final token = await _instance.getToken();
      return token;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      return null;
    }
  }
}
