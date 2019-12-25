import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DataBlock extends StatelessWidget {
  final String title;
  final String content;

  DataBlock({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.blue[200],
        borderRadius: new BorderRadius.all(
          const Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            title,
            maxLines: 1,
            presetFontSizes: [18, 16],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(
            thickness: 3,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  content,
                  presetFontSizes: [18, 16, 14, 12],
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
