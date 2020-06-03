import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'ReadCard.dart';

void main() {
  group('Tangem DevKit app', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

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

    test("TEST",() {
      print("START");
      final responce = readCardMethot.readCard2(driver);
      var expectCardId = "bb03000000000004";
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

//    test("Test ReadCard", () async {
//      print("Start Read Card test");
//
//      print("Checking whether an element ReadCard is present");
//      await isExist(scanItem, driver);
//      print("Tap ReadCard in menu");
//      await driver.tap(scanItem);
//
//      print("Checking whether an element ActionButton is present");
//      await isExist(floatingActionButton, driver);
//      print("Tab action button");
//      await driver.tap(floatingActionButton);
//
//      print("Checking whether an element ResponseText is present");
//      await isExist(responseTextWidget, driver);
//
//      //print("Reconciliation of Results and Expected Result");
//      //print(driver.getText(responseText));
//     // expect(await driver.getText(responseText), expectedResult);
//
//      String response = await getResponce(driver,responseTextWidget);
//      Map<String, dynamic> responceJson = jsonDecode(response);
//      //print('${responceJson['cardId']}');
//      var cardId = responceJson['cardId'];
//
//      var expectCardId = "bb03000000000004";
//
//      print("Reconciliation of Results and Expected Result");
//      expect(cardId, expectCardId);
//
//    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}

isExist(parameter, driver) async{
  final isExists = await isPresent(parameter, driver);
  if (isExists) {
    print('Widget is present');
  } else {
    print('Widget is not present');
  }
}

isPresent(SerializableFinder byValueKey, FlutterDriver driver, {Duration timeout = const Duration(seconds: 3)}) async {
  try {
    await driver.waitFor(byValueKey,timeout: timeout);
    return true;
  } catch(exception) {
    return false;
  }
}

Future<String> getResponce(driver, responceElement) async {
  final response = await driver.getText(responceElement);
  return response;
}
