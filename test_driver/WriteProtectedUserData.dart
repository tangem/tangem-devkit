import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';

class WriteProtectedUserData {
  final writeProtectedUserDataItem = find.byValueKey("user_write_protected_data");
  final readCardButton =find.byValueKey('cid.btn');
  final cidTextEdit =find.byValueKey('cid');
  final userProtectedDataTextEdit =find.byValueKey('userProtectedData');
  final userProtectedCounterTextEdit =find.byValueKey('userProtectedCounter');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();


  writeProtectedUserData(driver, cid, userProtectedData, userProtectedCounter) async {
    print("Search for the WriteProtectedUserData element in the menu");
    await methods.isExist(writeProtectedUserDataItem, driver);
    print("Click WriteProtectedUserData element in menu");
    await driver.tap(writeProtectedUserDataItem);

    if (cid ==null) {
      print("Search Read Card button");
      await methods.isExist(readCardButton, driver);
      print("Click Read card button");
      await driver.tap(readCardButton);
      sleep(const Duration(seconds: 7));
      print("Scan card");
      //ToDo: Robot. A code to rotate the robot.
    } else {
      print("Search CID input field");
      await methods.isExist(cidTextEdit, driver);
      print("Click CID input field");
      await driver.tap(cidTextEdit);
      print("Enter CID in the input field");
      await driver.enterText(cid);
      final cidInput = find.text(cid);
      await methods.isExist(cidInput, driver);
    }

    print("Search User Protected Data input field");
    await methods.isExist(userProtectedDataTextEdit, driver);
    print("Click userProtectedData input field");
    await driver.tap(userProtectedDataTextEdit);
    print("Enter userProtectedData in the input field");
    await driver.enterText(userProtectedData);
    final userProtectedDataInput = find.text(userProtectedData);
    await methods.isExist(userProtectedDataInput, driver);

    print("Search User Protected Counter input field");
    await methods.isExist(userProtectedCounterTextEdit, driver);
    print("Click userProtectedCounter input field");
    await driver.tap(userProtectedCounterTextEdit);
    print("Enter userProtectedCounter in the input field");
    await driver.enterText(userProtectedCounter);
    final userProtectedCounterInput = find.text(userProtectedCounter);
    await methods.isExist(userProtectedCounterInput, driver);

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