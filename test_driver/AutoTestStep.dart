import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';


class AutoTestStep {
  final menuButton = find.byValueKey('menu.btn');
  final testItem = find.byValueKey("navigateToTestScreen.btn");
  final commandJsonField =  find.byValueKey('commandJson');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseSuccessJsonField = find.byValueKey('responseSuccessJson');
  final responseErrorJsonField = find.byValueKey('responseErrorJson');
  final methods = Methods();

  stepsInAutoTestingScreen(driver, commandJson, responseType) async {
    print("Search for the menu element in header");
    await methods.isExist(menuButton, driver);
    print("Tap on the menu in header");
    await driver.tap(menuButton);
    print("Search for the testItem element in menu");
    await methods.isExist(testItem, driver);
    print("Tap on the testItem in menu");
    await driver.tap(testItem);

    print("Field search for a JSON insertion");
    await methods.isExist(commandJsonField, driver);
    print("Tap on the commandJsonField");
    await driver.tap(commandJsonField);
    print("Entering command Json");
    await driver.enterText(commandJson);

    print("Search action button element");
    await methods.isExist(floatingActionButton, driver);
    print("Tap on action button");
    await driver.tap(floatingActionButton);
    //ToDO: Robot

    Map<String, dynamic> response;
    if (responseType== "error") {
      print("Wait Error response");
      await methods.isExist(responseErrorJsonField, driver);
      print("Get response");
      String getResponse = await methods.getResponce(responseErrorJsonField, driver);
      Map<String, dynamic> response = jsonDecode(getResponse);
      return response;

    }
    else {
      print("Wait Success response");
      await methods.isExist(responseSuccessJsonField, driver);
      print("Get response");
      String getResponse = await methods.getResponce(responseSuccessJsonField, driver);
      Map<String, dynamic> response = jsonDecode(getResponse);
      return response;
    }

  }
}