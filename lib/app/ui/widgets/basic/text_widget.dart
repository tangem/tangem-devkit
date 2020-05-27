import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final Key key;
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  const TextWidget(this.text, {this.key, this.fontSize, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) => Text(text, key: key, textAlign: textAlign, style: textStyle(color, fontSize));

  static TextStyle textStyle(Color color, double fontSize) => TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
      );

  factory TextWidget.center(String text) => TextWidget(text, textAlign: TextAlign.center);
}
