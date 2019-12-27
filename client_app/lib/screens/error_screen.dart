import 'package:flutter/material.dart';

class ErrorArguments {
  final String message;
  final dynamic code;
  ErrorArguments({this.message, this.code});
}

class ErrorScreen extends StatelessWidget {
  static const routeName = 'error-screen';
  @override
  Widget build(BuildContext context) {
    final ErrorArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('code: ${args.code}'),
            Text('message: ${args.message}'),
          ],
        ),
      ),
    );
  }
}
