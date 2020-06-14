import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'dart:convert';
import 'SignCard.dart';

void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final signCardMethod = SignCard();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Sign_Card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Sign_Card test",() async {
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cardId= personalize['cardId'];
      final walletRemainingSignatures= personalize['walletRemainingSignatures']-1; //ToDO: hardcode
      final walletSignedHashes = personalize['walletSignedHashes']+1; //ToDO: hardcode


      await driver.tap(backButton);

      final responceSign = await signCardMethod.signCard(driver, 'bb03000000000004', '123qwertyq');
      final cidSign = responceSign['cardId'];
      final walletRemainingSignaturesSign = responceSign['walletRemainingSignatures'];
      final walletSignedHashesSign = responceSign['walletSignedHashes'];

      print("Reconciliation of Results and Expected Result");
      expect(cardId, cidSign);
      expect(walletRemainingSignatures, walletRemainingSignaturesSign);
      expect(walletSignedHashes, walletSignedHashesSign);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
