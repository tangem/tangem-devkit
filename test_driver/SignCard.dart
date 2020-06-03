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


  signCard(driver) async {
    print("Search for the Sign element in the menu");
    await methods.isExist(signItem, driver);
    print("Click Sign element in menu");
    await driver.tap(signItem);
    if (cid==null) {
      await methods.isExist(readCardButton, driver);
      await driver.tap(readCardButton);
      //ToDo: Robot. A code to rotate the robot.
    }
    else {


    }
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