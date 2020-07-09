import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'dart:convert';
import 'ReadUserData.dart';

void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final readUserDataMethod = ReadUserData();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Read User Data test when there is no data', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read User Data test when there is no data",() async {
      print("Preparing the data");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cardId= personalize['cardId'];

      print("Return to menu");
      await driver.tap(backButton);

      print("Read User Data");
      final responceReadUserData = await readUserDataMethod.readUserData(driver, cardId);

      print("checking the Result and Expected result of the cardId field");
      expect(responceReadUserData['cardId'], personalize['cardId']);
      print("checking the Result and Expected result of the userData field");
      expect(responceReadUserData['userData'], "");
      print("checking the Result and Expected result of the userCounter field");
      expect(responceReadUserData['userCounter'], 0);
      print("checking the Result and Expected result of the userPritectedData field");
      expect(responceReadUserData['userProtectedData'], "");
      print("checking the Result and Expected result of the userPritectedCounter field");
      expect(responceReadUserData['userProtectedCounter'], 0);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
