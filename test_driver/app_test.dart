import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tangem DevKit app', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final scanItem = find.byValueKey("scan");
    final fab = find.byType("FloatingActionButton");
    final responseText = find.byValueKey('response_text');
    final expectResult = "OPA!";

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Test ReadCard", () async {
      print("Start Read Card test");
      await Future.delayed(Duration(seconds: 1));
      print("Tap ReadCard in menu");
      await driver.tap(scanItem);
      await Future.delayed(Duration(seconds: 1));
      print("Tab action button");
      await driver.tap(fab);
      await Future.delayed(Duration(seconds: 7));
      print("AAAAAAA");
     // await driver.tap(responseText);
     expect(await driver.getText(responseText), expectResult);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}

