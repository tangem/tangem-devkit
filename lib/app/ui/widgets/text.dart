import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;

  const CenterText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
