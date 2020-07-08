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

  group('Create wallet test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Create wallet test",() async {
      print("Preparing the data");
      final config = await configForPersonalize.returnConfig('config4');
      String jsonString = jsonEncode(config);
      print("Personalization card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      print("Return to menu");
      await driver.tap(backButton);

      print("Create wallet");
      final responceCreateWallet = await createWalletMethod.createWallet(driver, cid);
      print("Reconciliation of Results and Expected Result cardId field");
      expect(cid, responceCreateWallet['cardId']);
      print("Reconciliation of Results and Expected Result status field");
      expect(responceCreateWallet['status'], "Loaded");
      print("Reconciliation of Results and Expected Result walletPublicKey field");
      expect(responceCreateWallet['walletPublicKey'], isNotNull);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });
}