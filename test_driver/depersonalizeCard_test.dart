import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'DepersonalizeCard.dart';
import 'ReadCard.dart';
import 'dart:convert';

void main() {
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final depersonalizeCardMethod = DepersonalizeCard();
  final readCardMethod = ReadCard();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Depersonalize card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Depersonalize card test",() async {
      print("Preparing the config");
      final config = await configForPersonalize.returnConfig('config4');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final responcePersonalize = await personalizeCardMethod.personalizeCard(driver, jsonString);

      await driver.tap(backButton);

      print("Depersonalization card");
      final responceDepersonalizeCard = await depersonalizeCardMethod.depersonalizeCard(driver);
      print("Reconciliation of Results and Expected Result");
      expect(responceDepersonalizeCard['success'], true);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read a depersonalized card");
      final responceReadCard = await readCardMethod.readCard(driver);
      print("Reconciliation of Results and Expected Result cardId, after reading the depersonalized card");
      expect(responceReadCard['cardId'], "000000000000");
      print("Reconciliation of Results and Expected Result status, after reading the depersonalized card");
      expect(responceReadCard['status'], "NotPersonalized");
      print("Reconciliation of Results and Expected Result manufacturerName, after reading the depersonalized card");
      expect(responceReadCard['manufacturerName'], responcePersonalize['manufacturerName']);
      print("Reconciliation of Results and Expected Result health, after reading the depersonalized card");
      expect(responceReadCard['health'], responcePersonalize['health']);
      print("Reconciliation of Results and Expected Result isActivated, after reading the depersonalized card");
      expect(responceReadCard['isActivated'], responcePersonalize['isActivated']);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}

