import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/scanned_barcode_screen.dart';
import '../screens/error_screen.dart';
import '../models/barcode_argument.dart';

class BarcodeScan extends StatefulWidget {
  @override
  _BarcodeScanState createState() => new _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  // String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(CommunityMaterialIcons.qrcode_scan),
      onPressed: () {
        scan();
      },
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      // setState(() => this.barcode = barcode);
      print(barcode);
      print(barcode.length);
      if (barcode.length >= 16 && barcode.length <= 29) {
        String firstCode = barcode.substring(0, 4);
        String numberCode = barcode.substring(5, 11);
        String serial = barcode.substring(0, 11);
        Navigator.of(context).pushNamed(
          ScannedBarcodeScreen.routeName,
          arguments: BarcodeArgument(firstCode, numberCode, serial),
        );
      } else {
        Navigator.of(context).pushNamed(
          ErrorScreen.routeName,
          arguments: ErrorArguments(
              code: 'barcode.length Error', message: 'barcode.length Error'),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        Navigator.of(context).pushNamed(
          ErrorScreen.routeName,
          arguments: ErrorArguments(
              code: 'BarcodeScanner.CameraAccessDenied',
              message: 'The user did not grant the camera permission!'),
        );
      } else {
        Navigator.of(context).pushNamed(
          ErrorScreen.routeName,
          arguments:
              ErrorArguments(code: 'Unknown', message: 'Unknown error: $e'),
        );
      }
    } on FormatException {
      Navigator.of(context).pushNamed(
        ErrorScreen.routeName,
        arguments: ErrorArguments(
            code: 'Unknown',
            message:
                'null (User returned using the "back"-button before scanning anything. Result)'),
      );
    } catch (e) {
      Navigator.of(context).pushNamed(
        ErrorScreen.routeName,
        arguments:
            ErrorArguments(code: 'Unknown', message: 'Unknown error: $e'),
      );
    }
  }
}
