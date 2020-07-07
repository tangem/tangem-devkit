import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';


class ReadUserData {
  final readUserDataItem = find.byValueKey("user_read_data");
  final floatingActionButton = find.byType("FloatingActionButton");
  final readCardButton =find.byValueKey('cid.btn');
  final cidTextEdit =find.byValueKey('cid');
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();

  readUserData(driver, cid) async {
    print("Search for the ReadUserData element in the menu");
    await methods.isExist(readUserDataItem, driver);
    print("Click ReadUserData element in menu");
    await driver.tap(readUserDataItem);

    if (cid == null) {
      print("Search Read Card button");
      await methods.isExist(readCardButton, driver);
      print("Click Read card button");
      await driver.tap(readCardButton);
      sleep(const Duration(seconds: 7));

      //ToDo: Robot. A code to rotate the robot.

    } else {
      print("Search CID input field");
      await methods.isExist(cidTextEdit, driver);
      await driver.tap(cidTextEdit);
      await driver.enterText(cid);
      final cidInput = find.text(cid);
      await methods.isExist(cidInput, driver);
    }

    print("Search action button element");
    await methods.isExist(floatingActionButton, driver);
    print("Click action button");
    await driver.tap(floatingActionButton);
    //ToDo: Robot. A code to rotate the robot.
    print("Wait responce");
    sleep(const Duration(seconds: 7));
    String getResponse = await methods.getResponce(responseTextWidget, driver);
    Map<String, dynamic> responce = jsonDecode(getResponse);
    return responce;
  }
}