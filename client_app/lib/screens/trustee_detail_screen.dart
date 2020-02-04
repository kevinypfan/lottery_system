import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/data_block.dart';
import '../widgets/barcode_scanner.dart';
import '../providers/trustee.dart';

class TrusteeDetailScreen extends StatelessWidget {
  static const routeName = 'trustee-detail-screen';

  List<Widget> _dataRender(data) {
    return data
        .toJson()
        .entries
        .map<Widget>(
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

  @override
  Widget build(BuildContext context) {
    TrusteeData trusteeData = Provider.of<TrusteeData>(context, listen: false);
    final Map<String, int> args = ModalRoute.of(context).settings.arguments;
    // print(args);
    TrusteeItem trustee = trusteeData.findOneById(args['id']);
    // print(trustee);
    // return Container();
    return Scaffold(
      appBar: AppBar(
        title: Text(trustee.name),
        actions: <Widget>[
          BarcodeScan("trustee"),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: _dataRender(trustee),
            ),
          ),
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 200.0,
          //     mainAxisSpacing: 10.0,
          //     crossAxisSpacing: 10.0,
          //     childAspectRatio: 3 / 1,
          //   ),
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Container(
          //         alignment: Alignment.center,
          //         color: Colors.teal[100 * (index % 9)],
          //         child: Text('Grid Item $index'),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
          // SliverFixedExtentList(
          //   itemExtent: 50.0,
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Container(
          //         alignment: Alignment.center,
          //         color: Colors.lightBlue[100 * (index % 9)],
          //         child: Text('List Item $index'),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
