import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/device.dart';
import './providers/lottery_data.dart';

import './screens/lottery_data_screen.dart';
import './screens/scanned_barcode_screen.dart';

import './widgets/loading_view.dart';
import './layouts/default_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Device>(create: (_) => Device()),
        ChangeNotifierProvider<LotteryData>(create: (_) => LotteryData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        routes: {
          ScannedBarcodeScreen.routeName: (ctx) => ScannedBarcodeScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final device = Provider.of<Device>(context);
    Widget _renderWidget() {
      if (device.loading) {
        return LoadingView();
      } else if (device.isAllow) {
        return LotteryDataScreen();
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('請先要求管理員給予權限。'),
          ],
        );
      }
    }

    return DefaultLayout(
      Center(
        child: _renderWidget(),
      ),
    );
  }
}
