import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'ReadCard.dart';
import 'SignCard.dart';

void main() {

  final readCardMethod = ReadCard();
  final signCardMethod = SignCard();
  final backButton = find.byTooltip('Back');

  FlutterDriver driver;

  group('Sign_Card test', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Sign_Card test",() async {
      final responceRead = await readCardMethod.readCard2(driver);
      final cid = responceRead['cardId'];
      final walletRemainingSignatures= responceRead['walletRemainingSignatures']-1;
      final walletSignedHashes = responceRead['walletSignedHashes']+2;

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

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}
