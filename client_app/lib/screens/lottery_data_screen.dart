import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

import '../providers/lottery_data.dart' as lottery;
import '../widgets/lottery_item.dart';
import '../widgets/hoc/creation_aware_listItem.dart';
import '../widgets/loading_view.dart';

class LotteryDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<lottery.LotteryData>(
      builder: (ctx, lotteryData, child) => lotteryData.items.length == 0
          ? LoadingView()
          : ListView.builder(
              itemCount: lotteryData.items.length,
              itemBuilder: (ctx, i) => CreationAwareListItem(
                    itemCreated: () {
                      SchedulerBinding.instance.addPostFrameCallback(
                          (duration) => Provider.of<lottery.LotteryData>(
                                  context,
                                  listen: false)
                              .handleItemCreated(i));
                    },
                    child: LotteryItem(lotteryData.items[i]),
                  )),
    );
  }
}
