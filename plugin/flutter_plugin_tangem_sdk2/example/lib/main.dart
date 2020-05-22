import 'dart:async';
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await TangemSdk.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(child: Text("Scan"), onPressed: _scan),
                SizedBox(width: 10),
                RaisedButton(child: Text("Sign"), onPressed: _sign),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(child: Text("Personalize"), onPressed: _personalize),
                SizedBox(width: 10),
                RaisedButton(child: Text("Depersonalize"), onPressed: _depersonalize)
              ],
            )
          ],
        )),
      ),
    );
  }

  final callback = Callback((result) {
    print(result);
    print(jsonEncode(result));
  }, (error) {
    print(error);
    print(jsonEncode(error));
  });

  _scan() {
    TangemSdk.scanCard(callback);
  }

  _sign() {
    final hexData = hex.encode("some hex string".codeUnits);
    TangemSdk.sign(callback, [hexData, hexData]);
  }

  _personalize() {}

  _depersonalize() {
    TangemSdk.depersonalize(callback, null);
  }
}
