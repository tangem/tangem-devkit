import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'ReadCard.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'PurgeWallet.dart';
import 'dart:convert';
import 'DepersonalizeCard.dart';


void main() {
  final menuButton = find.byValueKey('menu.btn');
  final testItem = find.byValueKey("navigateToTestScreen.btn");
  final commandJson = "commandJson";
  final responseSuccessJson = "responseSuccessJson";
  final responseErrorJson = "responseErrorJson";

  FlutterDriver driver;

  group('Read card test when settingMask =true', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("read",() async {
      print("1 tap");
      await driver.tap(menuButton);
      print("2 tap");
      await driver.tap(testItem);


    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });

}
