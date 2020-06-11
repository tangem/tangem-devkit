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
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(personalize['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(personalize['pauseBeforePin2'], null );
      }

      print("Reconciliation productMask"); //Todo: make this check a loop
      List productMask = personalize['cardData']['productMask'];
      if (config['cardData']['product_note']==true) {
        expect(productMask.contains('Note'), true);
      }
      if (config['cardData']['product_id_card']==true) {
        expect(productMask.contains('IdCard'), true);
      }
      if (config['cardData']['product_id_issuer']==true) {
        expect(productMask.contains('IdIssuer'), true);
      }
      if (config['cardData']['product_tag']==true) {
        expect(productMask.contains('Tag'), true);
      }

      print("Reconciliation settingsMask"); //Todo: make this check a loop
      List settingsMask = personalize['settingsMask'];
      if (config['isReusable']==true) {
        expect(settingsMask.contains('IsReusable'), true);
      }
      if (config['useActivation']==true) {
        expect(settingsMask.contains('UseActivation'), true);
      }
      if (config['useBlock']==true) {
        expect(settingsMask.contains('UseBlock'), true);
      }
      if (config['allowSwapPIN']==true) {
        expect(settingsMask.contains('AllowSwapPIN'), true);
      }
      if (config['allowSwapPIN2']==true) {
        expect(settingsMask.contains('AllowSwapPIN2'), true);
      }
      if (config['useCVC']==true) {
        expect(settingsMask.contains('UseCVC'), true);
      }
      if (config['forbidDefaultPIN']==true) {
        expect(settingsMask.contains('ForbidDefaultPIN'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNdef'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNdef'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['protocolAllowUnencrypted']==true) {
        expect(settingsMask.contains('ProtocolAllowUnencrypted'), true);
      }
      if (config['protocolAllowStaticEncryption']==true) {
        expect(settingsMask.contains('ProtocolAllowStaticEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerDataEx']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerDataEx'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNdef'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2andCVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPin2andCvcIfValidatedByIssuer'), true);
      }
      if (config['skipSecurityDelayIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByIssuer'), true);
      }
      if (config['requireTerminalTxSignature']==true) {
        expect(settingsMask.contains('RequireTermTxSignature'), true);
      }
      if (config['requireTerminalCertSignature']==true) {
        expect(settingsMask.contains('RequireTermCertSignature'), true);
      }
      if (config['checkPIN3onCard']==true) {
        expect(settingsMask.contains('CheckPIN3onCard'), true);
      }
      if (config['forbidPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      print(personalize['cardId']);
      expect(personalize['cardId'].contains(cardId), true);

      //Todo: add expect for , health, firmware, all keys, issuer name, manufact sign, msnum date

    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}



