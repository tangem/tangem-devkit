import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'PurgeWallet.dart';
import 'dart:convert';
import 'DepersonalizeCard.dart';

void main() {
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final purgeWalletMethod = PurgeWallet();
  final backButton = find.byTooltip('Back');
  final depersonalize = DepersonalizeCard();

  FlutterDriver driver;

  group('Purge Wallet test when isReusable=false', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Purge Wallet test when isReusable=false",() async {
      print("Preparing the config");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      print("Return to menu");
      await driver.tap(backButton);

      print("Purge wallet");
      final responcePurgeWallet = await purgeWalletMethod.purgeWallet(driver, cid);
      print("Reconciliation of Results and Expected Result cardId field");
      expect(cid, responcePurgeWallet['cardId']);
      print("Reconciliation of Results and Expected Result status field");
      expect(responcePurgeWallet['status'], "Purged");
    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });

  group('Purge Wallet test when isReusable=true', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Purge Wallet test when isReusable=true",() async {
      print("Preparing the config");
      final config = await configForPersonalize.returnConfig('config3');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      print("Return to menu");
      await driver.tap(backButton);

      print("Purge wallet");
      final responcePurgeWallet = await purgeWalletMethod.purgeWallet(driver, cid);
      print("Reconciliation of Results and Expected Result cardId field");
      expect(cid, responcePurgeWallet['cardId']);
      print("Reconciliation of Results and Expected Result status field");
      expect(responcePurgeWallet['status'], "Empty");
    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });
}