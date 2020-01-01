import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../providers/device.dart';

class NotForbiddenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device device = Provider.of<Device>(context);
    print(device.isAllow);
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('code: ${403}'),
            Text('message: 您權限不足，請管理員開啟您的權限！'),
          ],
        ),
      ),
    );
  }
}
