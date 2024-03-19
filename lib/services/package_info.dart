import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  static Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    return currentVersion;
  }
}
