import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'dart:convert';
import 'Methods.dart';

class PurgeWallet {
  final purgeWalletItem = find.byValueKey("purge_wallet");
  final readCardButton = find.byValueKey('cid.btn');
  final cidTextEdit = find.byValueKey('cid');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();

  purgeWallet(driver, cid) async {
    print("Search for the PurgeWallet element in the menu");
    await methods.isExist(purgeWalletItem, driver);
    print("Click PurgeWallet element in menu");
    await driver.tap(purgeWalletItem);

    if (cid ==null) {
      print("Search Read Card button");
      await methods.isExist(readCardButton, driver);
      print("Click Read card button");
      await driver.tap(readCardButton);
      sleep(const Duration(seconds: 7));
      //ToDo: Robot. A code to rotate the robot.
    }
    else {
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