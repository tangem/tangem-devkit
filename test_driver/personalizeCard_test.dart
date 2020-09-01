import 'dart:convert';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'ConfigForPersonalize.dart';
import 'PersonalizeCard.dart';

void main() {

  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();

  FlutterDriver driver;

  group('Personalization test when enabled SettingMask', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Personalization test when enabled SettingMask",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config1');
      String jsonString = jsonEncode(config);
      print("Personalize card");
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
        expect(personalize['walletPublicKey'], isNotNull);
        expect(personalize['walletRemainingSignatures'], isNotNull);
        expect(personalize['walletSignedHashes'], isNotNull);
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
      if (config['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (config['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (config['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (config['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (config['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
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
      if (config['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (config['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(personalize['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(personalize['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(personalize['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
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

  group('Personalization test when disabled SettingMask', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Personalization test when disabled SettingMask",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);
      print("Personalize card");
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
        expect(personalize['walletPublicKey'], isNotNull);
        expect(personalize['walletRemainingSignatures'], isNotNull);
        expect(personalize['walletSignedHashes'], isNotNull);
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
      if (config['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (config['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (config['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (config['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (config['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
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
      if (config['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (config['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(personalize['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(personalize['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(personalize['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
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

  group('Personalization Token test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Personalization Token test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config3');
      String jsonString = jsonEncode(config);
      print("Personalize card");
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
        expect(personalize['walletPublicKey'], isNotNull);
        expect(personalize['walletRemainingSignatures'], isNotNull);
        expect(personalize['walletSignedHashes'], isNotNull);
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
      if (config['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (config['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (config['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (config['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (config['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
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
      if (config['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (config['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(personalize['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(personalize['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(personalize['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
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

  group('Personalization ID-card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Personalization ID-card test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config5');
      String jsonString = jsonEncode(config);
      print("Personalize card");
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
        expect(personalize['walletPublicKey'], isNotNull);
        expect(personalize['walletRemainingSignatures'], isNotNull);
        expect(personalize['walletSignedHashes'], isNotNull);
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
      if (config['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (config['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (config['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (config['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (config['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
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
      if (config['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (config['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(personalize['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(personalize['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(personalize['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
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

  group('Personalization ID-Issuer test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Personalization ID-Issuer test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config6');
      String jsonString = jsonEncode(config);
      print("Personalize card");
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
        expect(personalize['walletPublicKey'], isNotNull);
        expect(personalize['walletRemainingSignatures'], isNotNull);
        expect(personalize['walletSignedHashes'], isNotNull);
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
      if (config['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (config['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (config['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (config['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (config['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
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
      if (config['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (config['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(personalize['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(personalize['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(personalize['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
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

  group('Personalization TangemTAG test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Personalization TangemTAG test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config8');
      String jsonString = jsonEncode(config);
      print("Personalize card");
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
        expect(personalize['walletPublicKey'], isNotNull);
        expect(personalize['walletRemainingSignatures'], isNotNull);
        expect(personalize['walletSignedHashes'], isNotNull);
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
      if (config['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (config['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (config['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (config['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (config['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (config['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (config['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (config['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (config['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (config['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (config['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (config['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (config['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (config['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (config['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (config['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
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
      if (config['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (config['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(personalize['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(personalize['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(personalize['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
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



