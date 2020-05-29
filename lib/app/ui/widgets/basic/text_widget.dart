import 'package:devkit/app/resources/app_resources.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String keyName;
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  const TextWidget(this.text, {this.keyName, this.fontSize, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) => Text(text, key: ItemId.from(keyName), textAlign: textAlign, style: textStyle(color, fontSize));

  static TextStyle textStyle(Color color, double fontSize) => TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
      );

  factory TextWidget.center(String text) => TextWidget(text, textAlign: TextAlign.center);
}
