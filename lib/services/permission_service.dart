import 'dart:developer';
import 'dart:io';

import 'package:case_management/services/device_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final _deviceService = locator<DeviceService>();

  Future<PermissionStatus> getStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        final versionNumber = await _deviceService.getAndroidVersion();
        log('VERSION: $versionNumber');
        if ((versionNumber ?? 0) > 30) {
          return await Permission.manageExternalStorage.request();
        } else {
          return await Permission.storage.request();
        }
      }
      return await Permission.storage.request();
    } catch (e) {
      return PermissionStatus.denied;
    }
  }
}
