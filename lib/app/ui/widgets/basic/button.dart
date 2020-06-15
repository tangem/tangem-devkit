import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Button({@required this.text, @required this.onPressed, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: TextWidget(text.toUpperCase()),
      onPressed: onPressed,
      textColor: Colors.white,
      color: AppColor.accentColor,
    );
  }
}
