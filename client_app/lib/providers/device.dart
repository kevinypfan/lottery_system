import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class Device {
  String info;
  String version;
  String identifier;
  Device() {
    getDeviceDetails();
  }

  void getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        info = build.model;
        version = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        print(data);
        info = data.model;
        version = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
//if (!mounted) return;
  }
}
