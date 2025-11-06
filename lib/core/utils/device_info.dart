import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  static String id = '';
  static String appName = '';
  static String appVersion = '';
  static String buildNumber = '';
  static String packageName = '';

  static Future<void> init() async {
    try {
      // --- Ambil info app
      final info = await PackageInfo.fromPlatform();
      appName = info.appName;
      buildNumber = info.buildNumber;
      packageName = info.packageName;
      final version =
          info.version.replaceAll(RegExp(r'-(staging|production)'), '');
      appVersion = '$version.$buildNumber';

      // --- Ambil device ID
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        // coba androidId (versi baru), fallback ke id (versi lama)
        id = (androidInfo as dynamic).androidId ??
            (androidInfo as dynamic).id ??
            '';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        id = (iosInfo as dynamic).identifierForVendor ?? '';
      }

      // fallback ke FlutterUdid jika tetap kosong
      if (id.isEmpty) {
        id = await FlutterUdid.udid;
      }
    } catch (e) {
      // fallback terakhir supaya tidak null
      id = await FlutterUdid.udid;
    }
  }
}
