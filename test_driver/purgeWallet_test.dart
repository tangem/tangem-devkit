import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'PurgeWallet.dart';
import 'dart:convert';

void main() {
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final purgeWalletMethod = PurgeWallet();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Purge_Wallet1 test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Purge_Wallet if isReusable=false",() async {
      print("Preparing the config");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      await driver.tap(backButton);

      final responcePurgeWallet = await purgeWalletMethod.purgeWallet(driver, cid);
      print("Reconciliation of Results and Expected Result");
      expect(cid, responcePurgeWallet['cardId']);
      expect(responcePurgeWallet['status'], "Purged");
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });

  group('Purge_Wallet2 test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Purge_Wallet if isReusable=true",() async {
      print("Preparing the config");
      final config = await configForPersonalize.returnConfig('config3');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      await driver.tap(backButton);

      final responcePurgeWallet = await purgeWalletMethod.purgeWallet(driver, cid);
      print("Reconciliation of Results and Expected Result");
      expect(cid, responcePurgeWallet['cardId']);
      expect(responcePurgeWallet['status'], "Empty");
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });
}