import 'package:flutter/material.dart';

import '../widgets/data_block.dart';

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
    // final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // actions: <Widget>[],
            title: Text('新年快樂'),
            // expandedHeight: 300.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   title: Text('新年快樂'),
            //   background: Image.network(
            //     'https://www.taiwanlottery.com.tw/instant/images/142/IN1081211_preview_4362.jpg',
            //     fit: BoxFit.contain,
            //   ),
            // ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                DataBlock(),
                DataBlock(),
                DataBlock(),
                DataBlock(),
                DataBlock(),
                DataBlock(),
                DataBlock(),
              ],
            ),
          ),
          // SliverFillRemaining(
          //   child: Text(args.numberCode),
          // ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: RaisedButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(
            '加入庫存',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
