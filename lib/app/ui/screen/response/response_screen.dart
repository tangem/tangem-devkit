import 'dart:convert';

import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'scan_personalize_response.dart';

class ResponseScreen extends StatelessWidget {
  final Object arguments;

  const ResponseScreen({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) => ResponseFrame(arguments: arguments);

  static navigate(context, arguments) {
    Navigator.of(context).pushNamed(Routes.RESPONSE, arguments: arguments);
  }
}

class ResponseFrame extends StatelessWidget {
  final Object arguments;

  const ResponseFrame({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (Route route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Transl.of(context).screen_response_scan),
          actions: [Menu.popupDescription()],
        ),
        body: Stack(
          children: <Widget>[
            Visibility(visible: false, child: TextWidget(json.encode(arguments), keyName: ItemName.responseJson)),
            _createAppropriateResponseWidget(),
          ],
        ),
      ),
    );
  }

  Widget _createAppropriateResponseWidget() {
    return ReadResponseBody(arguments);
  }
}
