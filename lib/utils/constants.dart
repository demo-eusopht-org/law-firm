import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Constants {
  static const _port = 5000;
  static const String baseUrl = kDebugMode
      ? 'http://192.168.100.7:$_port'
      : 'http://35.93.142.239:$_port';

  // Visibility Constants
  static const String createLawyer = 'CREATE-LAWYER';
  static const String updateLawyer = 'UPDATE-LAWYER';
  static const String deleteLawyer = 'DELETE-LAWYER';
  static const String createClient = 'CREATE-CLIENT';
  static const String updateClient = 'UPDATE-CLIENT';
  static const String createCase = 'CREATE-CASE';
  static const String addProceedings = 'ADD-PROCEEDING';
  static const String deleteClient = 'DELETE-CLIENT';
  static const String addAttachments = 'ADD-ATTACHMENTS';
  static const String deleteCase = 'DELETE-CASE';
  static const String assignCaseToClient = 'ASSIGN-CASE-TO-CLIENT';
  static const String assignCaseToLawyer = 'ASSIGN-CASE-TO-LAWYER';

  static const String channelId = 'LAW-FIRM-CHANNEL-ID';
  static const String channelName = 'LAW-FIRM-CHANNEL-NAME';
  static const String channelDescription = '';

  static String getProfileUrl(String fileName, int userId) {
    return "$baseUrl/profile_images?filename=$fileName&userId=$userId";
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
