import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'ReadCard.dart';
import 'PersonalizeCard.dart';
import 'ConfigForPersonalize.dart';

void main() {

  final readCardMethod = ReadCard();
  final configForPersonalize = ConfigForPersonalize();
  final personalizeCardMethod = PersonalizeCard();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Read_Card test with config1', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Read_Card test with config1",() async {
      final config = await configForPersonalize.returnConfig('config1');
      final personalize = await personalizeCardMethod.personalizeCard(driver, config);
      await driver.tap(backButton);
      final responce = await readCardMethod.readCard2(driver);
      print("Reconciliation cardId");
      expect(responce['cardId'], personalize['cardId']);

      print("Reconciliation cardPublicKey");
      expect(responce['cardPublicKey'], personalize['cardPublicKey']);

      print("Reconciliation curve");
      expect(responce['curve'], personalize['curve']);

      print("Reconciliation firmwareVersion");
      expect(responce['firmwareVersion'], personalize['firmwareVersion']);

      print("Reconciliation health");
      expect(responce['health'], personalize['health']);

      print("Reconciliation isActivated");
      expect(responce['isActivated'], personalize['isActivated']);

      print("Reconciliation issuerPublicKey");
      expect(responce['issuerPublicKey'], personalize['issuerPublicKey']);

      print("Reconciliation manufacturerName");
      expect(responce['manufacturerName'], personalize['manufacturerName']);

      print("Reconciliation maxSignatures");
      expect(responce['maxSignatures'], personalize['maxSignatures']);

      print("Reconciliation pauseBeforePin2");
      expect(responce['pauseBeforePin2'], personalize['pauseBeforePin2']);

      print("Reconciliation status");
      expect(responce['status'], personalize['status']);

      print("Reconciliation terminalIsLinked");
      expect(responce['terminalIsLinked'], personalize['terminalIsLinked']);

      print("Reconciliation walletPublicKey");
      expect(responce['walletPublicKey'], personalize['walletPublicKey']);

      print("Reconciliation walletRemainingSignatures");
      expect(responce['walletRemainingSignatures'], personalize['walletRemainingSignatures']);

      print("Reconciliation walletSignedHashes");
      expect(responce['walletSignedHashes'], personalize['walletSignedHashes']);

      print("Reconciliation productMask");
      expect(responce['productMask'], personalize['productMask']);
      //ToDo: cardData / settingsMask
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
