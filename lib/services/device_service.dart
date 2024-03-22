import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  final _deviceInfo = DeviceInfoPlugin();

  Future<int?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    return null;
  }
}
