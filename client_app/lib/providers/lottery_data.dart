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

  LotteryItem({
    this.id,
    this.name,
    this.imageUrl,
    this.lastRedeem,
    this.maxBonus,
    this.maxIssue,
    this.maxTop,
    this.price,
    this.salesRate,
    this.startSell,
    this.stopSell,
    this.unredeemed,
  });

  LotteryItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imageUrl = json['image_url'],
        price = json['price'],
        maxBonus = json['max_bonus'],
        startSell = DateTime.parse(json['start_sell']),
        stopSell = json['stop_sell'] == null
            ? null
            : DateTime.parse(json['stop_sell']),
        lastRedeem = json['last_redeem'] == null
            ? null
            : DateTime.parse(json['last_redeem']),
        maxIssue = json['max_issue'],
        maxTop = json['max_top'],
        salesRate = json['sales_rate'],
        unredeemed = json['unredeemed'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'maxBonus': maxBonus,
        'startSell': startSell,
        'stopSell': stopSell,
        'lastRedeem': lastRedeem,
        'maxIssue': maxIssue,
        'maxTop': maxTop,
        'salesRate': salesRate,
        'unredeemed': unredeemed,
      };
}

class LotteryData with ChangeNotifier {
  static const int itemRequestThreshold = 30;
  int _currentPage = 0;

  List<LotteryItem> _items = [];

  List<LotteryItem> get items => _items;

  LotteryData() {
    fetchLotteryDatas(0).then((_) {
      print('fetch done');
    });
  }

  Future<LotteryItem> findLotteryItemById(String id) async {
    final QueryOptions getLotteryItemByIdOption = QueryOptions(
      document: getLotteryItemByIdQuery,
      variables: <String, dynamic>{
        'id': id,
      },
    );

    final QueryResult getLotteryItemById =
        await graphQLClient.query(getLotteryItemByIdOption);

    if (getLotteryItemById.hasErrors) {
      print(getLotteryItemById.errors);
    }

    return LotteryItem.fromJson(getLotteryItemById.data['lotteryData']);
  }

  Future<void> handleItemCreated(int index) async {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % itemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ itemRequestThreshold;
    print('Item created at $index');

    if (requestMoreData && pageToRequest > _currentPage) {
      print('handleItemCreated | pageToRequest: $pageToRequest');

      _currentPage = pageToRequest;
      final LotteryItem lotteryItem = LotteryItem(name: '^');
      _showLoadingIndicator(lotteryItem);

      await fetchLotteryDatas(pageToRequest);
      print(_items.length);
      _removeLoadingIndicator(lotteryItem);
    }
  }

  void _showLoadingIndicator(LotteryItem lotteryItem) {
    _items.add(lotteryItem);
    print('add: ^$lotteryItem');
    notifyListeners();
  }

  void _removeLoadingIndicator(LotteryItem lotteryItem) {
    print(_items.remove(lotteryItem));
    notifyListeners();
  }

  Future<void> fetchLotteryDatas(int page) async {
    final QueryOptions getLotteryDatasOption = QueryOptions(
      document: getLotteryDatasQuery,
      variables: <String, dynamic>{
        'order': 'id DESC',
        'limit': itemRequestThreshold,
        'skip': page * itemRequestThreshold
      },
    );

    final QueryResult getLotteryDatas =
        await graphQLClient.query(getLotteryDatasOption);
    if (getLotteryDatas.hasErrors) {
      print(getLotteryDatas.errors);
    }
    getLotteryDatas.data['lotteryDatas'].forEach((item) {
      _items.add(LotteryItem.fromJson(item));
    });
    notifyListeners();
  }
}
