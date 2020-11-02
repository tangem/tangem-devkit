import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'ReadCard.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'PurgeWallet.dart';
import 'dart:convert';
import 'DepersonalizeCard.dart';


void main() {

  final readCardMethod = ReadCard();
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final purgeWalletMethod = PurgeWallet();
  final backButton = find.byTooltip('Back');
  final depersonalize = DepersonalizeCard();

  FlutterDriver driver;

  group('Read card test when settingMask =true', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read Card test when settingMask =true",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config1');
      String jsonString = jsonEncode(config);

      print("Personalize card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      expect(readResponce['cardId'].contains(cardId), true);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], "TANGEM");

      print("Reconciliation status");
      expect(readResponce['status'], "Empty");

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], null);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], null);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], null);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], isNotNull);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], isNotNull);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], isNotNull);

      print("Reconciliation curve");
      expect(readResponce['curve'], null);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], null);

      print("Reconciliation pauseBeforePin2");
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(readResponce['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(readResponce['pauseBeforePin2'], null );
      }

      print("Reconciliation health");
      expect(readResponce['health'], 0);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], true);

      print("Reconciliation signingMethods");
      expect(readResponce['signingMethods'], null);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], "TANGEM SDK");

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], isNotNull);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(readResponce['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(readResponce['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
      }

      print("Reconciliation productMask");
      List productMask = readResponce['cardData']['productMask'];
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
      List settingsMask = readResponce['settingsMask'];
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

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], false);

     // TODO: manufactureDateTime

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

  group('Read card test when settingMask =false', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read Card test when settingMask =false",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);

      print("Personalize card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      expect(readResponce['cardId'].contains(cardId), true);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], "TANGEM");

      print("Reconciliation createWallet");
      if (config['createWallet']==0) {
        print("Reconciliation status");
        expect(readResponce['status'], "Empty");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], null);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], null);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], null);
      }
      else {
        print("Reconciliation status");
        expect(readResponce['status'], "Loaded");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], isNotNull);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], isNotNull);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], isNotNull);
      }

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], isNotNull);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], isNotNull);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], isNotNull);

      print("Reconciliation curve");
      expect(readResponce['curve'], config['curveID']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation pauseBeforePin2");
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(readResponce['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(readResponce['pauseBeforePin2'], null );
      }

      print("Reconciliation health");
      expect(readResponce['health'], 0);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], false);

      print("Reconciliation signingMethods");
      expect(readResponce['signingMethods'],  config['SigningMethod']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], "TANGEM SDK");

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], isNotNull);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(readResponce['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(readResponce['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
      }

      print("Reconciliation productMask");
      List productMask = readResponce['cardData']['productMask'];
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
      List settingsMask = readResponce['settingsMask'];
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

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], false);

      // TODO: manufactureDateTime

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

  group('Read Token card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read Token card test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config3');
      String jsonString = jsonEncode(config);

      print("Personalize card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      expect(readResponce['cardId'].contains(cardId), true);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], "TANGEM");

      print("Reconciliation createWallet");
      if (config['createWallet']==0) {
        print("Reconciliation status");
        expect(readResponce['status'], "Empty");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], null);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], null);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], null);
      }
      else {
        print("Reconciliation status");
        expect(readResponce['status'], "Loaded");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], isNotNull);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], isNotNull);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], isNotNull);
      }

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], isNotNull);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], isNotNull);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], isNotNull);

      print("Reconciliation curve");
      expect(readResponce['curve'], config['curveID']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation pauseBeforePin2");
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(readResponce['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(readResponce['pauseBeforePin2'], null );
      }

      print("Reconciliation health");
      expect(readResponce['health'], 0);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], false);

      print("Reconciliation signingMethods");
      expect(readResponce['signingMethods'],  config['SigningMethod']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], "TANGEM SDK");

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], isNotNull);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(readResponce['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(readResponce['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
      }

      print("Reconciliation productMask");
      List productMask = readResponce['cardData']['productMask'];
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
      List settingsMask = readResponce['settingsMask'];
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

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], false);

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

  group('Read ID-card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read ID-card test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config5');
      String jsonString = jsonEncode(config);

      print("Personalize card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      expect(readResponce['cardId'].contains(cardId), true);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], "TANGEM");

      print("Reconciliation createWallet");
      if (config['createWallet']==0) {
        print("Reconciliation status");
        expect(readResponce['status'], "Empty");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], null);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], null);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], null);
      }
      else {
        print("Reconciliation status");
        expect(readResponce['status'], "Loaded");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], isNotNull);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], isNotNull);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], isNotNull);
      }

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], isNotNull);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], isNotNull);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], isNotNull);

      print("Reconciliation curve");
      expect(readResponce['curve'], config['curveID']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation pauseBeforePin2");
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(readResponce['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(readResponce['pauseBeforePin2'], null );
      }

      print("Reconciliation health");
      expect(readResponce['health'], 0);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], false);

      print("Reconciliation signingMethods");
      expect(readResponce['signingMethods'],  config['SigningMethod']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], "TANGEM SDK");

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], isNotNull);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(readResponce['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(readResponce['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
      }

      print("Reconciliation productMask");
      List productMask = readResponce['cardData']['productMask'];
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
      List settingsMask = readResponce['settingsMask'];
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

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], false);

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

  group('Read IDIssuer-card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read IDIssuer-card test",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config6');
      String jsonString = jsonEncode(config);

      print("Personalize card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);

      print("Return to menu");
      await driver.tap(backButton);

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      expect(readResponce['cardId'].contains(cardId), true);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], "TANGEM");

      print("Reconciliation createWallet");
      if (config['createWallet']==0) {
        print("Reconciliation status");
        expect(readResponce['status'], "Empty");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], null);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], null);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], null);
      }
      else {
        print("Reconciliation status");
        expect(readResponce['status'], "Loaded");

        print("Reconciliation walletPublicKey");
        expect(readResponce['walletPublicKey'], isNotNull);

        print("Reconciliation walletRemainingSignatures");
        expect(readResponce['walletRemainingSignatures'], isNotNull);

        print("Reconciliation walletSignedHashes");
        expect(readResponce['walletSignedHashes'], isNotNull);
      }

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], isNotNull);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], isNotNull);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], isNotNull);

      print("Reconciliation curve");
      expect(readResponce['curve'], config['curveID']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation pauseBeforePin2");
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(readResponce['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(readResponce['pauseBeforePin2'], null );
      }

      print("Reconciliation health");
      expect(readResponce['health'], 0);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], false);

      print("Reconciliation signingMethods");
      expect(readResponce['signingMethods'],  config['SigningMethod']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], "TANGEM SDK");

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], isNotNull);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(readResponce['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(readResponce['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
      }

      print("Reconciliation productMask");
      List productMask = readResponce['cardData']['productMask'];
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
      List settingsMask = readResponce['settingsMask'];
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

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], false);

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

  group('Read Card test when status=Purged', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("Read Card test with the status=Purged",() async {
      print("Preparing config");
      final config = await configForPersonalize.returnConfig('config2');
      String jsonString = jsonEncode(config);

      print("Personalize card");
      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
      final cid = personalize['cardId'];

      await driver.tap(backButton);

      print("Purge wallet");
      final responcePurgeWallet = await purgeWalletMethod.purgeWallet(driver, cid);
      print("Reconciliation status in Purge screen");
      expect(responcePurgeWallet['status'], "Purged");

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      final startNumber = config['startNumber'].toString();
      final cardId = config['series']+ startNumber;
      print(cardId);
      expect(readResponce['cardId'].contains(cardId), true);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], "TANGEM");

      print("Reconciliation status");
      expect(readResponce['status'], "Purged");

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], null);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], null);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], null);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], isNotNull);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], isNotNull);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], isNotNull);

      print("Reconciliation curve");
      expect(readResponce['curve'], config['curveID']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], config['MaxSignatures']);

      print("Reconciliation pauseBeforePin2");
      if (config['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = config['pauseBeforePIN2']/10;
        expect(readResponce['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(readResponce['pauseBeforePin2'], null );
      }

      print("Reconciliation health");
      expect(readResponce['health'], 0);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], false);

      print("Reconciliation signingMethods");
      expect(readResponce['signingMethods'],  config['SigningMethod']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], config['cardData']['batch']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], "TANGEM SDK");

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], config['cardData']['blockchain']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], isNotNull);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], config['cardData']['token_symbol']);
        expect(readResponce['cardData']['tokenContractAddress'], config['cardData']['token_contract_address']);
        expect(readResponce['cardData']['tokenDecimal'], config['cardData']['token_decimal']);
      }

      print("Reconciliation productMask");
      List productMask = readResponce['cardData']['productMask'];
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
      List settingsMask = readResponce['settingsMask'];
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

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], false);

    });

    tearDownAll(() async {
      await driver.tap(backButton);
      await depersonalize.depersonalize(driver);
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

//  group('Read TangemTAG test', () {
//    setUpAll(() async {
//      driver = await FlutterDriver.connect();
//      await driver.requestData('restart');
//    });
//
//    test("Read TangemTAG test",() async {
//      print("Preparing config");
//      final config = await configForPersonalize.returnConfig('config3');
//      String jsonString = jsonEncode(config);
//
//      print("Personalize card");
//      final personalize = await personalizeCardMethod.personalizeCard(driver, jsonString);
//
//      print("Return to menu");
//      await driver.tap(backButton);
//
//      print("Read card");
//      final readResponce = await readCardMethod.readCard(driver);
//      print(personalize);
//      print(readResponce);
//
//      print("Reconciliation cardId");
//      expect(readResponce['cardId'], personalize['cardId']);
//
//      print("Reconciliation manufacturerName");
//      expect(readResponce['manufacturerName'], personalize['manufacturerName']);
//
//      print("Reconciliation status");
//      expect(readResponce['status'], personalize['status']);
//
//      print("Reconciliation firmwareVersion");
//      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);
//
//      print("Reconciliation cardPublicKey");
//      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);
//
//      print("Reconciliation issuerPublicKey");
//      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);
//
//      print("Reconciliation curve");
//      expect(readResponce['curve'], personalize['curve']);
//
//      print("Reconciliation maxSignatures");
//      expect(readResponce['maxSignatures'], personalize['maxSignatures']);
//
//      print("Reconciliation pauseBeforePin2");
//      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);
//
//      print("Reconciliation walletPublicKey");
//      expect(readResponce['walletPublicKey'], personalize['walletPublicKey']);
//
//      print("Reconciliation walletRemainingSignatures");
//      expect(readResponce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);
//
//      print("Reconciliation walletSignedHashes");
//      expect(readResponce['walletSignedHashes'], personalize['walletSignedHashes']);
//
//      print("Reconciliation health");
//      expect(readResponce['health'], personalize['health']);
//
//      print("Reconciliation isActivated");
//      expect(readResponce['isActivated'], personalize['isActivated']);
//
//      print("Reconciliation isActivated");
//      expect(readResponce['signingMethods'], personalize['signingMethods']);
//
//      print("Reconciliation batchId");
//      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);
//
//      print("Reconciliation batchId");
//      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);
//
//      print("Reconciliation issuerName");
//      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);
//
//      print("Reconciliation blockchainName");
//      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);
//
//      print("Reconciliation manufacturerSignature");
//      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);
//
//      if (jsonString.contains('token_symbol')) {
//        print("Reconciliation token info");
//        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
//        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
//        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
//      }
//
//      print("Reconciliation productMask");
//      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);
//
//      print("Reconciliation settingsMask");
//      expect(readResponce['settingsMask'], personalize['settingsMask']);
//
//      print("Reconciliation terminalIsLinked");
//      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);
//
//    });
//
//    tearDownAll(() async {
//      await Future.delayed(Duration(seconds: 3));
//      driver?.close();
//    });
//  });

}



