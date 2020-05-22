import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showError(BuildContext context, Object error) {
  final scaffold = Scaffold.of(context);
  scaffold.hideCurrentSnackBar();
  scaffold.showSnackBar(SnackBar(content: TextWidget(stringOf(error))));
}
