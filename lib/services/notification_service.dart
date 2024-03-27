import 'dart:developer';

import 'package:case_management/utils/constants.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  final _androidSettings = const AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );
  final _darwinSettings = const DarwinInitializationSettings();

  final _androidDetails = const AndroidNotificationDetails(
    Constants.channelId,
    Constants.channelName,
    channelDescription: Constants.channelDescription,
    importance: Importance.high,
    priority: Priority.high,
    category: AndroidNotificationCategory.reminder,
  );
  final _iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentBanner: true,
    presentSound: true,
  );

  NotificationService() {
    _init();
  }

  Future<void> _init() async {
    final initializationSettings = InitializationSettings(
      android: _androidSettings,
      iOS: _darwinSettings,
    );
    final isInitialized = await _plugin.initialize(initializationSettings);
    if (!(isInitialized ?? false)) {
      CustomToast.show(
        'Could not initialize notification feature!',
      );
    }
  }

  Future<void> show({
    required String title,
    required String body,
  }) async {
    try {
      final details = NotificationDetails(
        android: _androidDetails,
        iOS: _iosDetails,
      );
      await _plugin.show(
        0,
        title,
        body,
        details,
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
    }
  }
}
