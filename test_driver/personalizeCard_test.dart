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
      final config = await configForPersonalize.returnConfig('config3');
      String jsonString = jsonEncode(config);
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      print(config);
      print(personalize);

      print("Reconciliation maxSignatures");
      expect(personalize['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation manufacturerName");
      expect(personalize['manufacturerName'], "TANGEM");

      print("Reconciliation createWallet");
      if (config['createWallet']==0) {
        expect(personalize['status'], "Empty");
        expect(personalize['walletPublicKey'], null);
        expect(personalize['walletRemainingSignatures'], null);
        expect(personalize['walletSignedHashes'], null);
      }
      else {
        expect(personalize['status'], "Loaded");
      }

      print("Reconciliation curve");
      expect(personalize['curve'], config['curveID']);

      print("Reconciliation terminalIsLinked");
      expect(personalize['terminalIsLinked'], false);

      print("Reconciliation isActivated");
      expect(personalize['isActivated'], false);

      print("Reconciliation batchId");
      expect(personalize['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation blockchainName");
      expect(personalize['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation pauseBeforePIN2");
      final pauseBeforePin2 = config['pauseBeforePIN2']/10;
      expect(personalize['pauseBeforePin2'], pauseBeforePin2 );

    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}

