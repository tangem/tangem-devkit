import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'app_widgets.dart';
import 'utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tangem SDK plugin example')),
        body: CommandListWidget(),
      ),
    );
  }
}

class CommandListWidget extends StatefulWidget {
  @override
  _CommandListWidgetState createState() => _CommandListWidgetState();
}

class _CommandListWidgetState extends State<CommandListWidget> {
  final Utils _utils = Utils();
  final _jsonEncoder = JsonEncoder.withIndent('  ');

  late Callback _callback;
  String? _cardId;

  @override
  void initState() {
    super.initState();

    _callback = Callback((success) {
      if (success is ReadResponse) {
        _cardId = success.cardId;
      }
      final prettyJson = _jsonEncoder.convert(success.toJson());
      prettyJson.split("\n").forEach((element) => print(element));
    }, (error) {
      if (error is SdkPluginError) {
        print(error.message);
      } else {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 25),
          RowActions(
            [
              ActionButton("Scan card", action: handleScanCard),
              ActionButton("Sign", action: handleSign),
            ],
          ),
          ActionType("Issuer data"),
          RowActions(
            [
              ActionButton("Read", action: handleReadIssuerData),
              ActionButton("Write", action: handleWriteIssuerData),
            ],
          ),
          ActionType("Issuer extra data"),
          RowActions(
            [
              ActionButton("Read", action: handleReadIssuerExtraData),
              ActionButton("Write", action: handleWriteIssuerExtraData),
            ],
          ),
          ActionType("User data"),
          RowActions(
            [
              ActionButton("Read (all)", action: handleReadUserData),
              ActionButton("Write data", action: handleWriteUserData),
            ],
          ),
          RowActions([
            ActionButton("Write protected data", action: handleWriteUserProtectedData),
          ]),
          ActionType("Wallet"),
          RowActions(
            [
              ActionButton("Create", action: handleCreateWallet),
              ActionButton("Purge", action: handlePurgeWallet),
            ],
          ),
          ActionType("Pins"),
          RowActions(
            [
              ActionButton("Change PIN1", action: handleSetPin1),
              ActionButton("Change PIN2", action: handleSetPin2),
            ],
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }

  handleScanCard() {
    _showToast("Available through CommandData");
  }

  handleSign() {
    _showToast("Available through CommandData");
  }

  handleReadIssuerData() {
    _showToast("Available through CommandData");
  }

  handleWriteIssuerData() {
    _showToast("Available through CommandData");
  }

  handleReadIssuerExtraData() {
    _showToast("Available through CommandData");
  }

  handleWriteIssuerExtraData() {
    _showToast("Available through CommandData");
  }

  handleReadUserData() {
    _showToast("Available through CommandData");
  }

  handleWriteUserData() {
    _showToast("Available through CommandData");
  }

  handleWriteUserProtectedData() {
    _showToast("Available through CommandData");
  }

  handleCreateWallet() {
    _showToast("Available through CommandData");
  }

  handlePurgeWallet() {
    _showToast("Available through CommandData");
  }

  handleSetPin1() {
    _showToast("Available through CommandData");
  }

  handleSetPin2() {
    _showToast("Available through CommandData");
  }

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.8),
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
