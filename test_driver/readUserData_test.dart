import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'dart:convert';
import 'ReadUserData.dart';
import 'WriteUserData.dart';
import 'WriteProtectedUserData.dart';
import 'SignCard.dart';
import 'DepersonalizeCard.dart';

void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final readUserDataMethod = ReadUserData();
  final writeUserDataMethod = WriteUserData();
  final writeProtectedUserDataMethod = WriteProtectedUserData();
  final signCardMethod = SignCard();
  final backButton = find.byTooltip('Back');
  final depersonalize = DepersonalizeCard();


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
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

  group('Read User Data after SIGN', () {

    final userData = "User Data";
    final userCounter = "1";
    final userProtectedData = "User Protected Data";
    final userProtectedCounter = "1";

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read User Data after SIGN",() async {
      print("Preparing the data");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);

      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid= personalize['cardId'];
      print("Return to menu");
      await driver.tap(backButton);

      print("Write user data");
      final responceWriteUserData = await writeUserDataMethod.writeUserData(driver, cid, userData, userCounter);
      print("Return to menu");
      await driver.tap(backButton);

      print("Write user protected data");
      final responceWriteProtectedUserData = await writeProtectedUserDataMethod.writeProtectedUserData(driver, cid, userProtectedData, userProtectedCounter);
      print("Return to menu");
      await driver.tap(backButton);

      print("Sign card");
      final responceSign = await signCardMethod.signCard(driver, cid, '123qwertyq');
      print("Return to menu");
      await driver.tap(backButton);

      print("Read User Data");
      final responceReadUserData = await readUserDataMethod.readUserData(driver, cid);

      print("checking the Result and Expected result of the cardId field");
      expect(responceReadUserData['cardId'], personalize['cardId']);
      print("checking the Result and Expected result of the userCounter field");
      expect(responceReadUserData['userCounter'], int.parse(userCounter)+1);
      print("checking the Result and Expected result of the userData field");
      expect(responceReadUserData['userData'], userData);
      print("checking the Result and Expected result of the userPritectedData field");
      expect(responceReadUserData['userProtectedData'], userProtectedData);
      print("checking the Result and Expected result of the userPritectedCounter field");
      expect(responceReadUserData['userProtectedCounter'], int.parse(userProtectedCounter)+1);
    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
