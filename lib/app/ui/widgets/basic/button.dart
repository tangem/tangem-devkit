import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const Button(this.text, {@required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: TextWidget(text.toUpperCase(), color: Colors.white),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => AppColor.accentColor)
      ),
    );
  }
}
