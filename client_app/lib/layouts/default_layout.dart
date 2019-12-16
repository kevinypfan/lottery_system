import 'package:flutter/material.dart';

import '../widgets/barcode_scanner.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  DefaultLayout(this.child);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lottery'),
        actions: <Widget>[
          BarcodeScan(),
        ],
      ),
      body: child,
    );
  }
}
