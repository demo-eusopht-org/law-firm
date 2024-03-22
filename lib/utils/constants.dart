import 'package:flutter/cupertino.dart';

class Constants {
  static const String baseUrl = 'http://192.168.100.115:4000';
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
