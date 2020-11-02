import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'dart:convert';
import 'WriteProtectedUserData.dart';
import 'ReadUserData.dart';
import 'DepersonalizeCard.dart';


void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final writeProtectedUserDataMethod = WriteProtectedUserData();
  final readUserDataMethod = ReadUserData();
  final depersonalize = DepersonalizeCard();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Write Protected User Data test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Write Protected User Data test",() async {
      print("Data preparation");
      final config = await configForPersonalize.returnConfig('config7');
      String jsonString = jsonEncode(config);
      final userProtectedData = "User Protected Data";
      final userProtectedCounter = "2";

      print("Personalize card");
      final responsePersonalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = responsePersonalize['cardId'];

      print("Return to menu");
      await driver.tap(backButton);

      print("Write user protected data");
      final responceWriteProtectedUserData = await writeProtectedUserDataMethod.writeProtectedUserData(driver, cid, userProtectedData, userProtectedCounter);
      print("Check responce after writing protected user data");
      expect(responceWriteProtectedUserData['cardId'], responsePersonalize['cardId']);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read User Data after writing");
      final responseReadUserData = await readUserDataMethod.readUserData(driver, cid);
      print("checking the Result and Expected result of the cardId field");
      expect(responseReadUserData['cardId'], responsePersonalize['cardId']);
      print("checking the Result and Expected result of the userCounter field");
      expect(responseReadUserData['userCounter'], int.parse(userProtectedCounter));
      print("checking the Result and Expected result of the userData field");
      expect(responseReadUserData['userData'], userProtectedData);
    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
