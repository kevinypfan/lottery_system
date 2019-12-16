import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/scanned_barcode_screen.dart';

class BarcodeScan extends StatefulWidget {
  @override
  _BarcodeScanState createState() => new _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  String barcode = "";

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
      setState(() => this.barcode = barcode);
      String firstCode = barcode.substring(0, 4);
      String numberCode = barcode.substring(5, 11);

      Navigator.of(context).pushNamed(
        ScannedBarcodeScreen.routeName,
        arguments: ScreenArguments(firstCode, numberCode),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
