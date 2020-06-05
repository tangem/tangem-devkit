import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'Methods.dart';

class PersonalizeCard {
  final personalizeItem = find.byValueKey("personalize");
  final menuButton = find.byValueKey('series'); //ToDo: need keys for menu button and menuItem

  final methods = Methods();

  personalizeCard(driver, config) async {
    print("Search for the Persinalize element in the menu");
    await methods.isExist(personalizeItem, driver);
    print("Click Persinalize element in menu");
    await driver.tap(personalizeItem);
    print("Search menu button");
    await methods.isExist(menuButton, driver);
    print("Tap menu");
    sleep(const Duration(seconds: 7));
    await driver.tap(menuButton);
    await driver.enterText(config);


  }
}