import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'ReadCard.dart';
import 'SignCard.dart';

void main() {

  final readCardMethod = ReadCard();
  final signCardMethod = SignCard();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  test("Test Sign Card ",() async {
    final responceRead = await readCardMethod.readCard2(driver);
    final cid = responceRead['cardId'];
    final walletRemainingSignatures= responceRead['walletRemainingSignatures']-1;
    final walletSignedHashes = responceRead['walletSignedHashes']+1;

    await driver.tap(backButton);

    final responceSign = await signCardMethod.signCard(driver, 'bb03000000000004', '123qwertyq');
    final cidSign = responceSign['cardId'];
    final walletRemainingSignaturesSign = responceSign['walletRemainingSignatures'];
    final walletSignedHashesSign = responceSign['walletSignedHashes'];

    print("Reconciliation of Results and Expected Result");
    expect(cid, cidSign);
    expect(walletRemainingSignatures, walletRemainingSignaturesSign);
    //print('${responceRead['walletSignedHashes']}' + '$walletSignedHashes' +'$walletSignedHashesSign');
    expect(walletSignedHashes, walletSignedHashesSign);

  });

  group('Tangem DevKit app', () {

    test("Test Read Card ",() async {
      final responce = await readCardMethod.readCard2(driver);
      var expectCardId = "bb03000000000004";
      print("Reconciliation of Results and Expected Result");
      expect(responce['cardId'], expectCardId);
    });

  });



  tearDownAll(() async {
    await Future.delayed(Duration(seconds: 3));
    driver?.close();
  });

}
