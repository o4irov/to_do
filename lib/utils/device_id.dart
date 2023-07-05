import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceId {
  Future<String> get deviceId => _getId();

  Future<String> _getId() async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;

      identifier = build.androidId;
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor;
    }
    return identifier ?? '';
  }
}
