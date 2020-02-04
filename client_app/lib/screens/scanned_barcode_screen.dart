import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:intl/intl.dart';

import '../config/config.dart';
import '../widgets/data_block.dart';
import '../providers/lottery_data.dart';
import '../widgets/loading_view.dart';
import '../models/barcode_argument.dart';
// import './into_stock_screen.dart';

class ScannedBarcodeScreen extends StatefulWidget {
  static const routeName = 'scanned-barcode-screen';
  @override
  _ScannedBarcodeScreenState createState() => _ScannedBarcodeScreenState();
}

class _ScannedBarcodeScreenState extends State<ScannedBarcodeScreen> {
  LotteryItem lotteryItem = LotteryItem();
  String _imageUrl = "";

  List<Widget> _datasRender() {
    return lotteryItem
        .toJson()
        .entries
        .map(
          (entry) => DataBlock(
            title: entry.key,
            content: entry.value is String
                ? entry.value
                : entry.value is DateTime
                    ? DateFormat('yyyy/MM/dd').format(entry.value)
                    : '${entry.value}',
          ),
        )
        .toList();
  }

  Widget _imagePlugin() {
    return TransitionToImage(
      image: AdvancedNetworkImage(
        _imageUrl,
        loadedCallback: () {
          print('It works!');
        },
        loadFailedCallback: () {
          if (_imageUrl != lotteryItem.imageUrl) {
            setState(() {
              _imageUrl = Config.PHOTO_BASE_URI + lotteryItem.imageUrl;
            });
          }
          print('Oh, no!');
        },
        timeoutDuration: Duration(seconds: 30),
        retryLimit: 1,
      ),
      loadingWidgetBuilder: (_, double progress, __) =>
          Text(progress.toString()),
      fit: BoxFit.contain,
      placeholder: const Icon(Icons.refresh),
      width: 400.0,
      height: 300.0,
      enableRefresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BarcodeArgument args = ModalRoute.of(context).settings.arguments;
    if (lotteryItem.id != args.firstCode) {
      Provider.of<LotteryData>(context, listen: false)
          .findLotteryItemById(args.firstCode)
          .then((result) {
        print(result.name);

        setState(() {
          _imageUrl = Config.PHOTO_BASE_URI +
              result.imageUrl.replaceFirst('small', 'preview');
          lotteryItem = result;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: lotteryItem.id == null
            ? Text("Loading...")
            : Text(lotteryItem.name),
      ),
      body: lotteryItem.name == null
          ? LoadingView()
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  // actions: <Widget>[],
                  backgroundColor: Theme.of(context).primaryColor,
                  expandedHeight: 300.0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _imagePlugin(),
                    // Image.network(
                    //   Config.PHOTO_BASE_URI +
                    //       lotteryItem.imageUrl.replaceFirst('small', 'preview'),
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: _datasRender(),
                  ),
                ),
                // SliverFillRemaining(
                //   child: Text(args.numberCode),
                // ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            // Navigator.of(context).pushNamed(
            //   IntoStockScreen.routeName,
            //   arguments: args,
            // );
          },
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
