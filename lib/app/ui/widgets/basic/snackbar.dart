import 'dart:convert';

import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String message) {
  final scaffold = Scaffold.of(context);
  scaffold.hideCurrentSnackBar();
  scaffold.showSnackBar(SnackBar(content: TextWidget(message)));
}

showJsonSnackbar(BuildContext context, dynamic object) {
  final scaffold = Scaffold.of(context);
  scaffold.hideCurrentSnackBar();
  try {
    final message = object is String ? object : json.encode(object);
    showSnackbar(context, message);
  } catch (ex) {
    showSnackbar(context, object.toString());
  }
}
