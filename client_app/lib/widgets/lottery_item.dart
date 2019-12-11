import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/lottery_data.dart' as lottery;

class LotteryItem extends StatelessWidget {
  final lottery.LotteryItem _lotteryItem;
  LotteryItem(this._lotteryItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${_lotteryItem.name} \$${_lotteryItem.price}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(_lotteryItem.startSell),
            ),
          ),
        ],
      ),
    );
  }
}
