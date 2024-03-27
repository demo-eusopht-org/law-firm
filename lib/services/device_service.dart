import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  final _deviceInfo = DeviceInfoPlugin();
  final _androidId = const AndroidId();

  Future<int?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    return null;
  }

  Future<String?> getDeviceId() async {
    if (Platform.isAndroid) {
      return await _androidId.getId();
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }
}
