import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'ConfigForPersonalize.dart';
import 'AutoTestStep.dart';


void main() {
  final configForPersonalize = ConfigForPersonalize();
  final autoTestSteps = AutoTestStep();

  FlutterDriver driver;

  group('Personalization test when enabled SettingMask', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('restart');
    });

    test("read",() async {

      print("DATA PREPARATION:");
      print("Preparing config for personalise");
      final personaliseConfig = await configForPersonalize.returnConfig('config2');
      String personaliseConfigToJson = jsonEncode(personaliseConfig);
      print(personaliseConfig);

      print("Preparing config for issuer");
      final issuerConfig = await configForPersonalize.returnConfig('issuerConfig1');
      String issuerConfigToJson = jsonEncode(issuerConfig);
      print(issuerConfig);

      print("Create command JSON");
      String commandJson = '''{
      "config": $personaliseConfigToJson,
      "issuer":$issuerConfigToJson,
      "commandType":"personalize" 
      }''';
      print(commandJson);

      print("PERSONALISATION CARD:");
      final personalizeResponse = await autoTestSteps.stepsInAutoTestingScreen(driver, commandJson, 'success');
      print(personalizeResponse);

      print("CHECKING RESULT");
      print("Reconciliation curve");
      expect(personalizeResponse['curve'], personaliseConfig['curveID']);
      print("Reconciliation maxSignatures");
      expect(personalizeResponse['maxSignatures'], personaliseConfig['MaxSignatures']);
      print("Reconciliation manufacturerName");
      expect(personalizeResponse['manufacturerName'], "TANGEM");
      print("Reconciliation terminalIsLinked");
      expect(personalizeResponse['terminalIsLinked'], false);
      print("Reconciliation isActivated");
      expect(personalizeResponse['isActivated'], false);
      print("Reconciliation batchId");
      expect(personalizeResponse['cardData']['batchId'], personaliseConfig['cardData']['batch']);
      print("Reconciliation blockchainName");
      expect(personalizeResponse['cardData']['blockchainName'], personaliseConfig['cardData']['blockchain']);

      print("Reconciliation pauseBeforePIN2");
      if (personaliseConfig['pauseBeforePIN2']>0) {
        final pauseBeforePin2 = personaliseConfig['pauseBeforePIN2']/10;
        expect(personalizeResponse['pauseBeforePin2'], pauseBeforePin2 );
      }
      else{
        expect(personalizeResponse['pauseBeforePin2'], null );
      }

      print("Reconciliation productMask"); //Todo: make this check a loop
      List productMask = personalizeResponse['cardData']['productMask'];

      if (personaliseConfig['cardData']['product_note']==true) {
        expect(productMask.contains('Note'), true);
      }

      if (personaliseConfig['cardData']['product_id_card']==true) {
        expect(productMask.contains('IdCard'), true);
      }
      if (personaliseConfig['cardData']['product_id_issuer']==true) {
        expect(productMask.contains('IdIssuer'), true);
      }
      if (personaliseConfig['cardData']['product_tag']==true) {
        expect(productMask.contains('Tag'), true);
      }

      print("Reconciliation createWallet");
      if (personaliseConfig['createWallet']==0) {
        expect(personalizeResponse['status'], "Empty");
        expect(personalizeResponse['walletPublicKey'], null);
        expect(personalizeResponse['walletRemainingSignatures'], null);
        expect(personalizeResponse['walletSignedHashes'], null);
      }
      else {
        expect(personalizeResponse['status'], "Loaded");
        expect(personalizeResponse['walletPublicKey'], isNotNull);
        expect(personalizeResponse['walletRemainingSignatures'], isNotNull);
        expect(personalizeResponse['walletSignedHashes'], isNotNull);
      }

      print("Reconciliation settingsMask"); //Todo: make this check a loop
      List settingsMask = personalizeResponse['settingsMask'];
      if (personaliseConfig['isReusable']==true) {
        expect(settingsMask.contains('IsReusable'), true);
      }
      if (personaliseConfig['useActivation']==true) {
        expect(settingsMask.contains('UseActivation'), true);
      }
      if (personaliseConfig['useBlock']==true) {
        expect(settingsMask.contains('UseBlock'), true);
      }
      if (personaliseConfig['allowSetPIN1']==true) {
        expect(settingsMask.contains('AllowSetPIN1'), true);
      }
      if (personaliseConfig['allowSetPIN2']==true) {
        expect(settingsMask.contains('AllowSetPIN2'), true);
      }
      if (personaliseConfig['useCvc']==true) {
        expect(settingsMask.contains('UseCvc'), true);
      }
      if (personaliseConfig['prohibitDefaultPIN1']==true) {
        expect(settingsMask.contains('ProhibitDefaultPIN1'), true);
      }
      if (personaliseConfig['useOneCommandAtTime']==true) {
        expect(settingsMask.contains('UseOneCommandAtTime'), true);
      }
      if (personaliseConfig['useNDEF']==true) {
        expect(settingsMask.contains('UseNDEF'), true);
      }
      if (personaliseConfig['useDynamicNDEF']==true) {
        expect(settingsMask.contains('UseDynamicNDEF'), true);
      }
      if (personaliseConfig['smartSecurityDelay']==true) {
        expect(settingsMask.contains('SmartSecurityDelay'), true);
      }
      if (personaliseConfig['allowUnencrypted']==true) {
        expect(settingsMask.contains('AllowUnencrypted'), true);
      }
      if (personaliseConfig['allowFastEncryption']==true) {
        expect(settingsMask.contains('AllowFastEncryption'), true);
      }
      if (personaliseConfig['protectIssuerDataAgainstReplay']==true) {
        expect(settingsMask.contains('ProtectIssuerDataAgainstReplay'), true);
      }
      if (personaliseConfig['restrictOverwriteIssuerExtraData']==true) {
        expect(settingsMask.contains('RestrictOverwriteIssuerExtraData'), true);
      }
      if (personaliseConfig['allowSelectBlockchain']==true) {
        expect(settingsMask.contains('AllowSelectBlockchain'), true);
      }
      if (personaliseConfig['disablePrecomputedNDEF']==true) {
        expect(settingsMask.contains('DisablePrecomputedNDEF'), true);
      }
      if (personaliseConfig['skipSecurityDelayIfValidatedByLinkedTerminal']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByLinkedTerminal'), true);
      }
      if (personaliseConfig['skipCheckPIN2CVCIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipCheckPIN2CVCIfValidatedByIssuer'), true);
      }
      if (personaliseConfig['skipSecurityDelayIfValidatedByIssuer']==true) {
        expect(settingsMask.contains('SkipSecurityDelayIfValidatedByIssuer'), true);
      }
      if (personaliseConfig['requireTerminalTxSignature']==true) {
        expect(settingsMask.contains('RequireTermTxSignature'), true);
      }
      if (personaliseConfig['requireTerminalCertSignature']==true) {
        expect(settingsMask.contains('RequireTermCertSignature'), true);
      }
      if (personaliseConfig['checkPIN3OnCard']==true) {
        expect(settingsMask.contains('CheckPIN3OnCard'), true);
      }
      if (personaliseConfig['prohibitPurgeWallet']==true) {
        expect(settingsMask.contains('ProhibitPurgeWallet'), true);
      }

      print("Reconciliation cardId");
      final startNumber = personaliseConfig['startNumber'].toString();
      final cardId = personaliseConfig['series']+ startNumber;
      print(cardId);
      print(personalizeResponse['cardId']);
      expect(personalizeResponse['cardId'].contains(cardId), true);

      //ToDo: I don't know how to check the value
      print("Reconciliation manufacturerSignature");
      expect(personalizeResponse['manufacturerSignature'], isNotNull);
      print("Reconciliation cardPublicKey");
      expect(personalizeResponse['cardPublicKey'], isNotNull);
      print("Reconciliation firmwareVersion");
      expect(personalizeResponse['firmwareVersion'], isNotNull);
      print("Reconciliation health");
      expect(personalizeResponse['health'], isNotNull);

      //issuer data
      print("Reconciliation curve");
      expect(personalizeResponse['issuerPublicKey'], issuerConfig['dataKeyPair']['publicKey']);

      //ToDo: ADD signingMethods, issuerName

    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

  });

}



