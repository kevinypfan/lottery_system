import 'package:flutter/material.dart';

import '../screens/trustee_detail_screen.dart';

class TrusteeProfileListTile extends StatelessWidget {
  final int id;
  final String name;
  final String cardCode;

  TrusteeProfileListTile({this.id, this.name, this.cardCode});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile.png'),
        backgroundColor: Colors.grey[300],
      ),
      title: Text(name),
      subtitle: Text(cardCode),
      onTap: () {
        Navigator.of(context)
            .pushNamed(TrusteeDetailScreen.routeName, arguments: {'id': id});
      },
    );
  }
}
