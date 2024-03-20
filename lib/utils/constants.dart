import 'package:flutter/cupertino.dart';

class Constants {
  static const String baseUrl = 'http://192.168.100.7:4000';
  static const String profileUrl = "$baseUrl/profile_images?filename=";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
