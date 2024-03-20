import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static const String baseUrl = 'http://192.168.100.7:4000';
  static String getProfileUrl(String fileName) {
    final userId = locator<LocalStorageService>().getData('id');
    String url = "$baseUrl/profile_images?filename=$fileName&userId=$userId";
    return url;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
