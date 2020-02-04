import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trustee.dart';
import '../widgets/loading_view.dart';
import '../widgets/trustee_profile_list_tile.dart';

class TrusteeProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrusteeData trusteeData = Provider.of<TrusteeData>(context, listen: false);

    return FutureBuilder(
      future: trusteeData.fetchTrusteeData(),
      builder: (ctx, trusteeDataSnapshot) {
        print(trusteeDataSnapshot);
        if (trusteeDataSnapshot.connectionState == ConnectionState.active ||
            trusteeDataSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingView();
        }

        if (trusteeDataSnapshot.connectionState == ConnectionState.done) {
          if (trusteeDataSnapshot.hasData) {
            // return new RefreshIndicator(
            //     child: buildListView(context, list),
            //     onRefresh: refresh);
            return ListView.builder(
              itemCount: trusteeDataSnapshot.data.length,
              itemBuilder: (context, index) {
                return TrusteeProfileListTile(
                  id: trusteeDataSnapshot.data[index].id,
                  name: trusteeDataSnapshot.data[index].name,
                  cardCode: trusteeDataSnapshot.data[index].cardCode,
                );
              },
            );
          }
        }
        return new Center(
          child: new Text("ERROR"),
        );
      },
    );
  }
}
