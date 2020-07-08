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

  group('Sign card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Sign card test",() async {
      print("Preparing the data");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);

      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cardId= personalize['cardId'];
      final walletRemainingSignatures= personalize['walletRemainingSignatures']-1; //ToDO: hardcode
      final walletSignedHashes = personalize['walletSignedHashes']+1; //ToDO: hardcode

      print("Return to menu");
      await driver.tap(backButton);

      print("Sign card");
      final responceSign = await signCardMethod.signCard(driver, cardId, '123qwertyq');
      final cidSign = responceSign['cardId'];
      final walletRemainingSignaturesSign = responceSign['walletRemainingSignatures'];
      final walletSignedHashesSign = responceSign['walletSignedHashes'];

      print("checking the Result and Expected result of the cardId field");
      expect(cardId, cidSign);
      print("checking the Result and Expected result of the walletRemainingSignatures field");
      expect(walletRemainingSignatures, walletRemainingSignaturesSign);
      print("checking the Result and Expected result of the walletSignedHashesSign field");
      expect(walletSignedHashes, walletSignedHashesSign);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
