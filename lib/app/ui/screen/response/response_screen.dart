import 'dart:convert';

import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';

import 'other_responses.dart';
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
  String jsonArguments;

  ResponseFrame({Key key, this.arguments}) : super(key: key) {
    jsonArguments = json.encode(arguments);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (Route route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Transl.of(context).screen_response),
          actions: [
            IconButton(icon: Icon(Icons.share), onPressed: () => Share.share(jsonArguments)),
            Menu.popupDescription(),
          ],
        ),
        body: Stack(
          children: <Widget>[
            TextWidget(jsonArguments, keyName: ItemName.responseJson).visibility(false),
            _createAppropriateResponseWidget(),
          ],
        ),
      ),
    );
  }

  Widget _createAppropriateResponseWidget() {
    if (arguments is CardResponse) return ReadResponseBody(arguments);
    if (arguments is SignResponse) return SignResponseBody(arguments);
    if (arguments is DepersonalizeResponse) return DepersonalizeResponseBody(arguments);
    if (arguments is CreateWalletResponse) return CreateWalletResponseBody(arguments);
    if (arguments is PurgeWalletResponse) return PurgeWalletResponseBody(arguments);
    if (arguments is ReadIssuerDataResponse) return ReadIssuerDataResponseBody(arguments);
    if (arguments is WriteIssuerDataResponse) return WriteIssuerDataResponseBody(arguments);
    if (arguments is ReadIssuerExDataResponse) return ReadIssuerExDataResponseBody(arguments);
    if (arguments is WriteIssuerExDataResponse) return WriteIssuerExDataResponseBody(arguments);
    if (arguments is ReadUserDataResponse) return ReadUserDataResponseBody(arguments);
    if (arguments is WriteUserDataResponse) return WriteUserDataResponseBody(arguments);
    if (arguments is SetPinResponse) return SetPinResponseBody(arguments);
    if (arguments is WriteFilesResponse) return WriteFilesResponseBody(arguments);
    if (arguments is ReadFilesResponse) return ReadFilesResponseBody(arguments);
    if (arguments is DeleteFilesResponse) return DeleteFilesResponseBody(arguments);
    if (arguments is ChangeFilesSettingsResponse) return ChangeFilesSettingsResponseBody(arguments);

    return Center(child: TextWidget("Not implemented yet"));
  }
}
