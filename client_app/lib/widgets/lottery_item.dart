import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/loading_view.dart';
import '../providers/lottery_data.dart' as lottery;

class LotteryItem extends StatelessWidget {
  final lottery.LotteryItem _lotteryItem;
  LotteryItem(this._lotteryItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: _lotteryItem.name == '^'
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: LoadingView(),
            )
          : ListTile(
              title: Text(
                  '${_lotteryItem.name} (${_lotteryItem.id}) \$${_lotteryItem.price}'),
              trailing: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: Image.network(
                  'https://www.taiwanlottery.com.tw' + _lotteryItem.imageUrl,
                  // height: 150.0,
                  // width: 100.0,
                ),
              ),
              subtitle: Text('發行日期: ' +
                  DateFormat('yyyy/MM/dd').format(_lotteryItem.startSell) +
                  '\n' +
                  '兌獎截止: ' +
                  DateFormat('yyyy/MM/dd').format(_lotteryItem.lastRedeem)),
            ),
    );
  }
}
