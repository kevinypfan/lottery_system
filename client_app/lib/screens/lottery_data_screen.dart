import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/lottery_data.dart' as lottery;
import '../widgets/lottery_item.dart';

class LotteryDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<lottery.LotteryData>(context, listen: false)
            .fetchLotteryDatas(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<lottery.LotteryData>(
                builder: (ctx, lotteryData, child) => ListView.builder(
                  itemCount: lotteryData.items.length,
                  itemBuilder: (ctx, i) => LotteryItem(lotteryData.items[i]),
                ),
              );
            }
          }
        });
  }
}
