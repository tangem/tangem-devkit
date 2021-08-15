import 'dart:convert';

import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';

import 'other_responses.dart';
import 'read_personalize_response.dart';

class ResponseScreen extends StatelessWidget {
  final Object? arguments;

  const ResponseScreen({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) => ResponseFrame(arguments: arguments);

  static navigate(context, arguments) {
    Navigator.of(context).pushNamed(Routes.RESPONSE, arguments: arguments);
  }
}

class ResponseFrame extends StatelessWidget {
  final Object? arguments;
  late String jsonArguments;

  ResponseFrame({Key? key, this.arguments}) : super(key: key) {
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
    if (arguments == null) {
      return Center(child: TextWidget("Response is null"));
    }
    //TODO: only for JSON arguments
    return SingleChildScrollView(child: TextWidget(arguments.jsonEncode(true)));

    final args = arguments!;
    if (args is SuccessResponse) return SuccessResponseBody(args);
    if (args is ReadResponse) return ReadResponseBody(args);
    if (args is SignResponse) return SignResponseBody(args);
    if (args is DepersonalizeResponse) return DepersonalizeResponseBody(args);
    if (args is CreateWalletResponse) return CreateWalletResponseBody(args);
    if (args is PurgeWalletResponse) return PurgeWalletResponseBody(args);
    if (args is ReadIssuerDataResponse) return ReadIssuerDataResponseBody(args);
    if (args is ReadIssuerExtraDataResponse) return ReadIssuerExDataResponseBody(args);
    if (args is ReadUserDataResponse) return ReadUserDataResponseBody(args);
    if (args is WriteFilesResponse) return WriteFilesResponseBody(args);
    if (args is ReadFilesResponse) return ReadFilesResponseBody(args);

    return Center(child: TextWidget("Not implemented yet"));
  }
}
