import 'package:flutter/material.dart';

class ScreenArguments {
  final String firstCode;
  final String numberCode;

  ScreenArguments(this.firstCode, this.numberCode);
}

class ScannedBarcodeScreen extends StatefulWidget {
  static const routeName = 'scanned-barcode-screen';
  @override
  _ScannedBarcodeScreenState createState() => _ScannedBarcodeScreenState();
}

class _ScannedBarcodeScreenState extends State<ScannedBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Fixed Button'),
        ),
      ),
    );
  }
}
