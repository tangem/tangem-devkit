import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';

class WriteUserData {
  final writeUserDataItem = find.byValueKey("user_write_data");
  final readCardButton =find.byValueKey('cid.btn');
  final cidTextEdit =find.byValueKey('cid');
  final userDataTextEdit =find.byValueKey('userData');
  final userCounterTextEdit =find.byValueKey('userCounter');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();


  writeUserData(driver, cid, userData, userCounter) async {
    print("Search for the WriteUserData element in the menu");
    await methods.isExist(writeUserDataItem, driver);
    print("Click WriteUserData element in menu");
    await driver.tap(writeUserDataItem);

    if (cid ==null) {
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

      print("Search User data input field");
      await methods.isExist(userDataTextEdit, driver);
      await driver.tap(userDataTextEdit);
      await driver.enterText(userData);
      final userDataInput = find.text(userData);
      await methods.isExist(userDataInput, driver);

      print("Search User Counter input field");
      await methods.isExist(userCounterTextEdit, driver);
      await driver.tap(userCounterTextEdit);
      await driver.enterText(userCounter);
      final userCounterInput = find.text(userCounter);
      await methods.isExist(userCounterInput, driver);

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