import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'ReadCard.dart';

void main() {

  final scanItem = find.byValueKey("scan");
  final signItem = find.byValueKey("sign");
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final expectedResult = "OPA!";
  //final cidButton =find.text('Read Card');
  final cidButton =find.byValueKey('cid.btn');
  final readCardMethot = ReadCard();

  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  group('Tangem DevKit app', () {

    test("TEST",() async {
      print("START");
      final responce = await readCardMethot.readCard2(driver);
      var expectCardId = "bb03000000000004";
      print("Reconciliation of Results and Expected Result");
      expect(responce['cardId'], expectCardId);

    });

//    test("Test ReadCard", () async {
//      print("Checking whether an element ReadCard is present");
//      await isExist(signItem, driver);
//      print("Tap ReadCard in menu");
//      await driver.tap(signItem);
//      print("Checking whether an element ActionButton is present");
//      await isExist(cidButton, driver);
//      print("Tab action button");
//      await driver.tap(cidButton);
//    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
