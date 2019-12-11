import 'dart:io';

import 'package:graphql/client.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import '../plugin/graphql.dart';
import '../graphql/device.dart';

class Device with ChangeNotifier {
  String info;
  String version;
  String identifier;
  bool isAllow = false;
  bool loading = true;

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
        info = data.model;
        version = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
      checkDeviseAllow();
    } on PlatformException {
      print('Failed to get platform version');
    }
//if (!mounted) return;
  }

  void checkDeviseAllow() async {
    try {
      final QueryOptions getDeviceOption = QueryOptions(
        document: getDeviceQuery,
        variables: <String, dynamic>{
          'id': identifier,
        },
      );

      final QueryResult device = await graphQLClient.query(getDeviceOption);

      if (device.hasErrors) {
        if (device.errors[0].toString().contains(new RegExp(r'.*404.*'))) {
          final MutationOptions newDeviceOption = MutationOptions(
            document: newDeviceMutaion,
            variables: <String, dynamic>{
              'input': {
                'id': identifier,
                'model': info,
                'version': version,
              },
            },
          );

          final QueryResult newDevice =
              await graphQLClient.mutate(newDeviceOption);
          if (newDevice.hasErrors) {
            print(device.errors);
          }
          isAllow = device.data['getDevice']['isVerify'];
          loading = false;
          notifyListeners();
        }
      }
      isAllow = device.data['getDevice']['isVerify'];
      loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      loading = false;
      notifyListeners();
    }
  }
}
