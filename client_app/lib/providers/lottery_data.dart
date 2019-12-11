import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../plugin/graphql.dart';
import '../graphql/lottery_data.dart';

class LotteryItem {
  String id;
  String name;
  String imageUrl;
  int price;
  int maxBonus;
  DateTime startSell;
  DateTime stopSell;
  DateTime lastRedeem;
  int maxIssue;
  int maxTop;
  String salesRate;
  int unredeemed;

  LotteryItem(Map<String, dynamic> item) {
    id = item['id'];
    name = item['name'];
    imageUrl = item['image_url'];
    price = item['price'];
    maxBonus = item['max_bonus'];
    startSell = DateTime.parse(item['start_sell']);
    stopSell =
        item['stop_sell'] == null ? null : DateTime.parse(item['stop_sell']);
    lastRedeem =
        item['stop_sell'] == null ? null : DateTime.parse(item['last_redeem']);
    maxIssue = item['max_issue'];
    maxTop = item['max_top'];
    salesRate = item['sales_rate'];
    unredeemed = item['unredeemed'];
  }

  // LotteryItem({
  //   this.id,
  //   this.name,
  //   this.imageUrl,
  //   this.lastRedeem,
  //   this.maxBonus,
  //   this.maxIssue,
  //   this.maxTop,
  //   this.price,
  //   this.salesRate,
  //   this.startSell,
  //   this.stopSell,
  //   this.unredeemed,
  // });
}

class LotteryData with ChangeNotifier {
  List<LotteryItem> _items = [];

  List<LotteryItem> get items => _items;

  LotteryData() {
    fetchLotteryDatas().then((result) {
      print(_items);
    });
  }

  Future<void> fetchLotteryDatas() async {
    final QueryOptions getLotteryDatasOption = QueryOptions(
      document: getLotteryDatasQuery,
      variables: <String, dynamic>{
        'order': 'start_sell DESC',
      },
    );

    final QueryResult getLotteryDatas =
        await graphQLClient.query(getLotteryDatasOption);
    if (getLotteryDatas.hasErrors) {
      print(getLotteryDatas.errors);
    }
    getLotteryDatas.data['lotteryDatas'].forEach((item) {
      _items.add(LotteryItem(item));
    });
  }
}
