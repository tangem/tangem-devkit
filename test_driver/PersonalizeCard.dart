import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'Methods.dart';

class PersonalizeCard {
  final personalizeItem = find.byValueKey("personalize");
  final menuButton = find.byValueKey('menu.btn');
  final menuImportButton = find.byValueKey('menuImport.btn');
  final personalizationImportInput = find.byValueKey('personalizationImportInput');
  final importButton = find.byValueKey('personalizationImportInput.btn');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();

  personalizeCard(driver, config) async {
    print("Search for the Persinalize element in the menu");
    await methods.isExist(personalizeItem, driver);
    print("Click Persinalize element in menu");
    await driver.tap(personalizeItem);
    print("Search menu button");
    await methods.isExist(menuButton, driver);
    print("Tap menu");
    await driver.tap(menuButton);
    print("Search Import button in menu");
    await methods.isExist(menuImportButton, driver);
    print("Click  Import button in menu");
    await driver.tap(menuImportButton);

    print("Search text input for config");
    await methods.isExist(personalizationImportInput, driver);
    print("Click text input for config");
    await driver.tap(personalizationImportInput);
    print("Entering config");
    await driver.enterText(config);
    print("Search Import button");
    await methods.isExist(importButton, driver);
    print("Click  Import button");
    await driver.tap(importButton);

    print("Search action button element");
    await methods.isExist(floatingActionButton, driver);
    print("Click action button");
    await driver.tap(floatingActionButton);

    print("Wait responce");
    await methods.isExist(responseTextWidget, driver);
    String getResponse = await methods.getResponce(responseTextWidget, driver);
    Map<String, dynamic> responce = jsonDecode(getResponse);
    //print('${responce['cardId']}');
    return responce;





  }
}
