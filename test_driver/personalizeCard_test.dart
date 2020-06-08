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
      print(config);

      // ToDo: cid, manufacturerName,

      print("Reconciliation maxSignatures");
      expect(personalize['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation manufacturerName");
      expect(personalize['manufacturerName'], "TANGEM");

      print("Reconciliation status");
      expect(personalize['status'], "Empty");

      print("Reconciliation curve");
      expect(personalize['curve'], config['curveID']);

    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}