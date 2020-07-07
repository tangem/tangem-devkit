import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'dart:convert';
import 'WriteUserData.dart';
import 'ReadUserData.dart';


void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final writeUserDataMethod = WriteUserData();
  final readUserDataMethod = ReadUserData();

  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Write_User_Data test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Write_User_Data test",() async {
      print("Data preparation");
      final config = await configForPersonalize.returnConfig('config7');
      String jsonString = jsonEncode(config);
      final userData = "User Data";
      final userCounter = "2";

      print("Personalize card");
      final responsePersonalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = responsePersonalize['cardId'];

      await driver.tap(backButton);

      print("Write user data");
      final responceWriteUserData = await writeUserDataMethod.writeUserData(driver, cid, userData, userCounter);
      print("Check responce after writing user data");
      expect(responceWriteUserData['cardId'], responsePersonalize['cardId']);

      await driver.tap(backButton);

      print("Read user data after writing");
      final responseReadUserData = await readUserDataMethod.readUserData(driver, cid);
      print("checking the Result and Expected result of the cardId field");
      expect(responseReadUserData['cardId'], responsePersonalize['cardId']);
      print("checking the Result and Expected result of the userCounter field");
      expect(responseReadUserData['userCounter'], int.parse(userCounter));
      print("checking the Result and Expected result of the userData field");
      expect(responseReadUserData['userData'], userData);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
