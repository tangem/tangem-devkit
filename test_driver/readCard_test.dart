import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'ReadCard.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';
import 'PurgeWallet.dart';
import 'dart:convert';


void main() {

  final readCardMethod = ReadCard();
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final purgeWalletMethod = PurgeWallet();
  final backButton = find.byTooltip('Back');

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
      expect(readResponce['cardId'], personalize['cardId']);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation status");
      expect(readResponce['status'], personalize['status']);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation curve");
      expect(readResponce['curve'], personalize['curve']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], personalize['walletPublicKey']);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], personalize['walletSignedHashes']);

      print("Reconciliation health");
      expect(readResponce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], personalize['isActivated']);

      print("Reconciliation isActivated");
      expect(readResponce['signingMethods'], personalize['signingMethods']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
      }

      print("Reconciliation productMask");
      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);

      print("Reconciliation settingsMask");
      expect(readResponce['settingsMask'], personalize['settingsMask']);

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);

    });

    tearDownAll(() async {
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
      expect(readResponce['cardId'], personalize['cardId']);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation status");
      expect(readResponce['status'], personalize['status']);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation curve");
      expect(readResponce['curve'], personalize['curve']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], personalize['walletPublicKey']);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], personalize['walletSignedHashes']);

      print("Reconciliation health");
      expect(readResponce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], personalize['isActivated']);

      print("Reconciliation isActivated");
      expect(readResponce['signingMethods'], personalize['signingMethods']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
      }

      print("Reconciliation productMask");
      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);

      print("Reconciliation settingsMask");
      expect(readResponce['settingsMask'], personalize['settingsMask']);

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);

    });

    tearDownAll(() async {
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
      expect(readResponce['cardId'], personalize['cardId']);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation status");
      expect(readResponce['status'], personalize['status']);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation curve");
      expect(readResponce['curve'], personalize['curve']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], personalize['walletPublicKey']);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], personalize['walletSignedHashes']);

      print("Reconciliation health");
      expect(readResponce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], personalize['isActivated']);

      print("Reconciliation isActivated");
      expect(readResponce['signingMethods'], personalize['signingMethods']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
      }

      print("Reconciliation productMask");
      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);

      print("Reconciliation settingsMask");
      expect(readResponce['settingsMask'], personalize['settingsMask']);

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);

    });

    tearDownAll(() async {
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
      expect(readResponce['cardId'], personalize['cardId']);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation status");
      expect(readResponce['status'], personalize['status']);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation curve");
      expect(readResponce['curve'], personalize['curve']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], personalize['walletPublicKey']);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], personalize['walletSignedHashes']);

      print("Reconciliation health");
      expect(readResponce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], personalize['isActivated']);

      print("Reconciliation isActivated");
      expect(readResponce['signingMethods'], personalize['signingMethods']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
      }

      print("Reconciliation productMask");
      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);

      print("Reconciliation settingsMask");
      expect(readResponce['settingsMask'], personalize['settingsMask']);

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);

    });

    tearDownAll(() async {
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
      expect(readResponce['cardId'], personalize['cardId']);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation status");
      expect(readResponce['status'], personalize['status']);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation curve");
      expect(readResponce['curve'], personalize['curve']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], personalize['walletPublicKey']);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], personalize['walletSignedHashes']);

      print("Reconciliation health");
      expect(readResponce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], personalize['isActivated']);

      print("Reconciliation isActivated");
      expect(readResponce['signingMethods'], personalize['signingMethods']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
      }

      print("Reconciliation productMask");
      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);

      print("Reconciliation settingsMask");
      expect(readResponce['settingsMask'], personalize['settingsMask']);

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);

    });

    tearDownAll(() async {
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

      print("Read card");
      final readResponce = await readCardMethod.readCard(driver);
      print(personalize);
      print(readResponce);

      print("Reconciliation cardId");
      expect(readResponce['cardId'], personalize['cardId']);

      print("Reconciliation manufacturerName");
      expect(readResponce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation status");
      expect(readResponce['status'], responcePurgeWallet['status']);

      print("Reconciliation firmwareVersion");
      expect(readResponce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation cardPublicKey");
      expect(readResponce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation issuerPublicKey");
      expect(readResponce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation curve");
      expect(readResponce['curve'], personalize['curve']);

      print("Reconciliation maxSignatures");
      expect(readResponce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(readResponce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation walletPublicKey");
      expect(readResponce['walletPublicKey'], null);

      print("Reconciliation walletRemainingSignatures");
      expect(readResponce['walletRemainingSignatures'], null);

      print("Reconciliation walletSignedHashes");
      expect(readResponce['walletSignedHashes'], null);

      print("Reconciliation health");
      expect(readResponce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(readResponce['isActivated'], personalize['isActivated']);

      print("Reconciliation isActivated");
      expect(readResponce['signingMethods'], personalize['signingMethods']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['batchId'], personalize['cardData']['batchId']);

      print("Reconciliation batchId");
      expect(readResponce['cardData']['manufactureDateTime'], personalize['cardData']['manufactureDateTime']);

      print("Reconciliation issuerName");
      expect(readResponce['cardData']['issuerName'], personalize['cardData']['issuerName']);

      print("Reconciliation blockchainName");
      expect(readResponce['cardData']['blockchainName'], personalize['cardData']['blockchainName']);

      print("Reconciliation manufacturerSignature");
      expect(readResponce['cardData']['manufacturerSignature'], personalize['cardData']['manufacturerSignature']);

      if (jsonString.contains('token_symbol')) {
        print("Reconciliation token info");
        expect(readResponce['cardData']['tokenSymbol'], personalize['cardData']['tokenSymbol']);
        expect(readResponce['cardData']['tokenContractAddress'], personalize['cardData']['tokenContractAddress']);
        expect(readResponce['cardData']['tokenDecimal'], personalize['cardData']['tokenDecimal']);
      }

      print("Reconciliation productMask");
      expect(readResponce['cardData']['productMask'], personalize['cardData']['productMask']);

      print("Reconciliation settingsMask");
      expect(readResponce['settingsMask'], personalize['settingsMask']);

      print("Reconciliation terminalIsLinked");
      expect(readResponce['terminalIsLinked'], personalize['terminalIsLinked']);

    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });

}



