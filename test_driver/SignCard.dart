import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'Methods.dart';

class SignCard {
  final signItem = find.byValueKey("sign");
  final readCardButton =find.byValueKey('cid.btn');
  final cidTextEdit =find.byValueKey('cid');
  final dataForHashingTextEdit =find.byValueKey('dataForHashing');
  final floatingActionButton = find.byType("FloatingActionButton");
  final responseTextWidget = find.byValueKey('responseJson');
  final methods = Methods();


  signCard(driver, cid, dataForHashing) async {
    print("Search for the Sign element in the menu");
    await methods.isExist(signItem, driver);
    print("Click Sign element in menu");
    await driver.tap(signItem);

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

    if (dataForHashing !=null) {
      print("Search Data dof hashing input field");
      await methods.isExist(dataForHashingTextEdit, driver);
      await driver.tap(dataForHashingTextEdit);
      await driver.enterText(dataForHashing);
      final dataForHashingInput = find.text(dataForHashing);
      await methods.isExist(dataForHashingInput, driver);

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
    //print('${responce['cardId']}');
    return responce;
  }

}