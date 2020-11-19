import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'ConfigForPersonalize.dart';
import 'Methods.dart';
import 'AutoTestStep.dart';


void main() {
  final configForPersonalize = ConfigForPersonalize();
  final autoTestSteps = AutoTestStep();

  FlutterDriver driver;

  group('Personalization test when enabled SettingMask', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("read",() async {

      print("DATA PREPARATION:");
      print("Preparing config for personalise");
      final personaliseConfig = await configForPersonalize.returnConfig('config2');
      String personaliseConfigToJson = jsonEncode(personaliseConfig);
      print(personaliseConfig);

      print("Preparing config for issuer");
      final issuerConfig = await configForPersonalize.returnConfig('issuerConfig1');
      String issuerConfigToJson = jsonEncode(issuerConfig);
      print(issuerConfig);

      print("Create command JSON");
      String commandJson = '''{
      "config": $personaliseConfigToJson,
      "issuer":$issuerConfigToJson,
      "commandType":"personalize" 
      }''';
      print(commandJson);

      print("PERSONALISATION CARD:");
      final personalizeResponse = await autoTestSteps.stepsInAutoTestingScreen(driver, commandJson, 'success');
      print(personalizeResponse);

      print("CHECKING RESULT");
      print("Reconciliation curve");
      expect(personalizeResponse['curve'], personaliseConfig['curveID']);






    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });

}



