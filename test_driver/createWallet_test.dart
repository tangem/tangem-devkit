import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'CreateWallet.dart';
import 'dart:convert';

void main() {
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final createWalletMethod = CreateWallet();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Create_Wallet test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Create_Wallet test",() async {
      print("Preparing the config");
      final config = await configForPersonalize.returnConfig('config4');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      await driver.tap(backButton);

      final responceCreateWallet = await createWalletMethod.createWallet(driver, cid);
      print("Reconciliation of Results and Expected Result");
      expect(cid, responceCreateWallet['cardId']);
      expect(responceCreateWallet['status'], "Loaded");
      expect(responceCreateWallet['walletPublicKey'], isNotNull);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });
}