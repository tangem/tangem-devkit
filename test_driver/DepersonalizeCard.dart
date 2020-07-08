import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';

class DepersonalizeCard {
  final depersonalizeItem = find.byValueKey("depersonalize");
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();

  depersonalizeCard(driver) async {
    print("Search for the Depersonalize element in the menu");
    await methods.isExist(depersonalizeItem, driver);
    print("Click Depersonalize element in menu");
    await driver.tap(depersonalizeItem);
    print("Search action button element");
    await methods.isExist(floatingActionButton, driver);
    print("Click action button");
    await driver.tap(floatingActionButton);
    print("Scan card");
    //ToDo: Robot. A code to rotate the robot.
    print("Wait responce");
    sleep(const Duration(seconds: 7));
    String getResponse = await methods.getResponce(responseTextWidget, driver);
    Map<String, dynamic> responce = jsonDecode(getResponse);
    return responce;
  }

  // Depersonalize without response
  depersonalize(driver) async {
    print("Search for the Depersonalize element in the menu");
    await methods.isExist(depersonalizeItem, driver);
    print("Click Depersonalize element in menu");
    await driver.tap(depersonalizeItem);
    print("Search action button element");
    await methods.isExist(floatingActionButton, driver);
    print("Click action button");
    await driver.tap(floatingActionButton);
  }
}