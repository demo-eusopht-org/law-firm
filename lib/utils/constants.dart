import 'package:flutter/cupertino.dart';

class Constants {
  static const String baseUrl = 'http://35.93.142.239:5000';
  // static const String baseUrl = 'https://cdb1-39-51-70-95.ngrok-free.app';

  // Visibility Constants
  static const String createLawyer = 'CREATE-LAWYER';
  static const String updateLawyer = 'UPDATE-LAWYER';
  static const String deleteLawyer = 'DELETE-LAWYER';
  static const String createClient = 'CREATE-CLIENT';
  static const String updateClient = 'UPDATE-CLIENT';
  static const String createCase = 'CREATE-CASE';

  static const String channelId = 'LAW-FIRM-CHANNEL-ID';
  static const String channelName = 'LAW-FIRM-CHANNEL-NAME';
  static const String channelDescription = '';

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

ValueNotifier<List<String>> configNotifier = ValueNotifier([]);
