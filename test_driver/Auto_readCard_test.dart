import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'ConfigForPersonalize.dart';
import 'AutoTestStep.dart';
import 'DepersonalizeCard.dart';

void main() {
  final configForPersonalize = ConfigForPersonalize();
  final autoTestSteps = AutoTestStep();
  final depersonalize = DepersonalizeCard();
  final backButton = find.byTooltip('Back');

  late FlutterDriver driver;

  group('Read card autotest when settingMask =true', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read Card autotest when settingMask =true",() async {

      print("DATA PREPARATION FOR PERSONALISE:");
      print("Preparing config for personalise");
      final personaliseConfig = await configForPersonalize.returnConfig('config1');
      String personaliseConfigToJson = jsonEncode(personaliseConfig);
      print(personaliseConfig);

      print("Preparing config for issuer");
      final issuerConfig = await configForPersonalize.returnConfig('issuerConfig1');
      String issuerConfigToJson = jsonEncode(issuerConfig);
      print(issuerConfig);

      print("Create command JSON for personalise");
      String persCommandJson = '''{
      "config": $personaliseConfigToJson,
      "issuer":$issuerConfigToJson,
      "commandType":"personalize"
      }''';
      print(persCommandJson);

      print("PERSONALISATION CARD:");
      final personalizeResponse = await autoTestSteps.stepsInAutoTestingScreen(driver, persCommandJson, 'success');
      print(personalizeResponse);

      print("Return to menu");
      await driver.tap(backButton);

      print("DATA PREPARATION FOR SCAN CARD:");
      print("Create command JSON for scan card");
      String readCommandJson = '''{
      "commandType":"scanCard"
      }''';
      print(readCommandJson);

      print("READ CARD:");
      final readResponse = await autoTestSteps.stepsInAutoTestingScreen(driver, readCommandJson, 'success');
      print(readResponse);

      print("CHECKING RESULT");

      print("Reconciliation cardId");
      final startNumber = personaliseConfig['startNumber'].toString();
      final cardId = personaliseConfig['series']+ startNumber;
      expect(readResponse['cardId'].contains(cardId), true);

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver.close();
    });
  });


}
