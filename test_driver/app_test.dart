import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tangem DevKit app', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final scanItem = find.byValueKey("Scan");
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });

    test("test scan", () async {
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(scanItem);
      await Future.delayed(Duration(seconds: 1));
      final fab = find.byType("FloatingActionButton");
      await driver.tap(fab);
    });
  });
}
