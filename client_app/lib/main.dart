import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/device.dart';
import './providers/lottery_data.dart';
import './providers/trustee.dart';

// import './screens/lottery_data_screen.dart';
import './screens/scanned_barcode_screen.dart';
import './screens/error_screen.dart';
// import './screens/into_stock_screen.dart';
import './screens/trustee_detail_screen.dart';

import './widgets/loading_view.dart';
import './layouts/default_layout.dart';
import './screens/not_forbidden_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device device = Device();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Device>(create: (_) => device),
        ChangeNotifierProvider<LotteryData>(create: (_) => LotteryData()),
        ChangeNotifierProvider<TrusteeData>(create: (_) => TrusteeData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: device.checkDeviseAllow(),
            builder: (ctx, deviceResultSnapshot) {
              // print(deviceResultSnapshot);
              return deviceResultSnapshot.connectionState ==
                      ConnectionState.waiting
                  ? LoadingView()
                  : device.isAllow ? DefaultLayout() : NotForbiddenScreen();
            }),
        routes: {
          ScannedBarcodeScreen.routeName: (ctx) => ScannedBarcodeScreen(),
          ErrorScreen.routeName: (ctx) => ErrorScreen(),
          // IntoStockScreen.routeName: (ctx) => IntoStockScreen(),
          TrusteeDetailScreen.routeName: (ctx) => TrusteeDetailScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final device = Provider.of<Device>(context);
//     Widget _renderWidget() {
//       if (device.loading) {
//         return LoadingView();
//       } else if (device.isAllow) {
//         return LotteryDataScreen();
//       } else {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('請先要求管理員給予權限。'),
//           ],
//         );
//       }
//     }

//     return DefaultLayout(
//       Center(
//         child: _renderWidget(),
//       ),
//     );
//   }
// }
