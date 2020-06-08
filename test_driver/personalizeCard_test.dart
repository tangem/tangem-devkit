import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'dart:convert';

void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();

  FlutterDriver driver;

  group('Sign_Card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Test Personalize ",() async {
      final config = await configForPersonalize.returnConfig('config1');
      String jsonString = jsonEncode(config);
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
