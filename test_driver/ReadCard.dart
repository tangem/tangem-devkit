import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';

class ReadCard {
  final readItem = find.byValueKey("scan");
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();


  readCard(driver) async {
    print("Search for the Read Card element in the menu");
    await methods.isExist(readItem, driver);
    print("Click Read Card element in menu");
    await driver.tap(readItem);
    print("Search action button element");
    await methods.isExist(floatingActionButton, driver);
    print("Click action button");
    await driver.tap(floatingActionButton);
    //ToDo: Robot. A code to rotate the robot.
    String getResponse = await methods.getResponce(responseTextWidget, driver);
    Map<String, dynamic> responce = jsonDecode(getResponse);
    //print('${responce['cardId']}');
    return responce;
  }

}