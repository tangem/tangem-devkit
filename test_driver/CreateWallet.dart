import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';

class CreateWallet {
  final createWalletItem = find.byValueKey("create_wallet");
  final readCardButton = find.byValueKey('cid.btn');
  final cidTextEdit = find.byValueKey('cid');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();

  createWallet(driver, cid) async {
    print("Search for the CreateWallet element in the menu");
    await methods.isExist(createWalletItem, driver);
    print("Click CreateWallet element in menu");
    await driver.tap(createWalletItem);

    if (cid ==null) {
      print("Search Read Card button");
      await methods.isExist(readCardButton, driver);
      print("Click Read card button");
      await driver.tap(readCardButton);
      sleep(const Duration(seconds: 7));
      print("Scan card");
      //ToDo: Robot. A code to rotate the robot.
    }
    else {
      print("Search CID input field");
      await methods.isExist(cidTextEdit, driver);
      print("Click CID input field");
      await driver.tap(cidTextEdit);
      print("Enter CID in the input field");
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