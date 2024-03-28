import 'dart:developer';

import 'package:case_management/services/notification_service.dart';
import 'package:case_management/view/cases/live_case_details.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';
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
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification?.title != null && notification?.body != null) {
        _notificationService.show(
          title: notification!.title!,
          body: notification.body!,
          payload: message.data,
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _goToCaseScreen(message);
    });
    final initialMessage = await _instance.getInitialMessage();
    if (initialMessage != null) {
      _goToCaseScreen(initialMessage);
    }
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

  void _goToCaseScreen(RemoteMessage message) {
    final data = message.data;
    final caseNo = data['case_no'];
    final context = Constants.navigatorKey.currentContext;
    if (caseNo != null && context != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => LiveCaseDetails(caseNo: caseNo),
        ),
      );
    }
  }
}
