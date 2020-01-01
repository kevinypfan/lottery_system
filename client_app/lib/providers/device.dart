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
  String name;
  String storeId;
  bool isAllow = false;
  bool loading = true;

  Future<void> getDeviceDetails() async {
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
      // checkDeviseAllow();
    } on PlatformException {
      print('Failed to get platform version');
    }
//if (!mounted) return;
  }

  Future<bool> checkDeviseAllow() async {
    print('checkDeviseAllow');
    try {
      await getDeviceDetails();
      final QueryOptions getDeviceOption = QueryOptions(
        document: getDeviceQuery,
        variables: <String, dynamic>{
          'id': identifier,
        },
      );
      print('id: $identifier');
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
            // print(newDevice.errors);
          }
          print('newDevice: ${newDevice.data}');
          isAllow = newDevice.data['newDevice']['isVerify'];
          name = newDevice.data['newDevice']['name'];
          storeId = newDevice.data['newDevice']['storeId'];
          loading = false;
          // notifyListeners();
          return isAllow;
        }
      }
      print('device: ${device.data}');
      isAllow = device.data['getDevice']['isVerify'];
      name = device.data['getDevice']['name'];
      storeId = device.data['getDevice']['storeId'];
      loading = false;
      notifyListeners();
      return isAllow;
    } catch (e) {
      // print(e);
      loading = false;
      return false;
      // notifyListeners();
    }
  }
}
