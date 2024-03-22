import 'package:flutter/cupertino.dart';

class Constants {
  static const String baseUrl = 'https://bf20-182-190-217-14.ngrok-free.app';
  static String getProfileUrl(String fileName, int userId) {
    String url = "$baseUrl/profile_images?filename=$fileName&userId=$userId";
    return url;
  }

  static String getCaseFileUrl(String caseNo, String filename) {
    return '$baseUrl/case_files?caseNo=$caseNo&filename=$filename';
  }

  static String getAppVersionUrl(String versionNumber, String fileName) {
    return '$baseUrl/download_app?versionNumber=$versionNumber&fileName=$fileName';
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String downloadUrl = "$baseUrl/download_app?versionNumber=";
}
