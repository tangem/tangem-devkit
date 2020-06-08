import 'dart:convert';

import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';

showSnackbar(BuildContext context, String text) {
  final scaffold = Scaffold.of(context);
  scaffold.hideCurrentSnackBar();
  scaffold.showSnackBar(SnackBar(content: TextWidget(text)));
}

showError(BuildContext context, ErrorResponse error) {
  showSnackbar(context, json.encode(error));
}
