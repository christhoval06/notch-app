import 'package:package_info_plus/package_info_plus.dart';

class SettingsAppInfo {
  const SettingsAppInfo({required this.version, required this.buildNumber});

  final String version;
  final String buildNumber;
}

class SettingsAppInfoService {
  const SettingsAppInfoService._();

  static Future<SettingsAppInfo> load() async {
    final info = await PackageInfo.fromPlatform();
    return SettingsAppInfo(
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }
}
