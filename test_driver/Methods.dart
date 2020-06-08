import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';

class Methods {
  isExist(parameter, driver) async {
    final isExists = await isPresent(parameter, driver);
    if (isExists) {
      print('Widget is present');
    } else {
      print('Widget is not present');
    }
  }

  isPresent(SerializableFinder byValueKey, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 3)}) async {
    try {
      await driver.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  Future<String> getResponce(responceElement, driver) async {
    final response = await driver.getText(responceElement);
    return response;
  }
}