import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/device.dart';
import './widgets/loading_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Device>(create: (_) => Device()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You deviceName: ${device.info}',
            ),
            Text(
              'You deviceVersion: ${device.version}',
            ),
            Text(
              'You identifier: ${device.identifier}',
            ),
            Text(
              'You isAllow: ${device.isAllow}',
            ),
            Text(
              'You loading: ${device.loading}',
            ),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('請先要求管理員給予權限。'),
          ],
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lottery'),
      ),
      body: Center(
        child: _renderWidget(),
      ),
    );
  }
}
