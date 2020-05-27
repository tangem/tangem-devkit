import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tangem DevKit app', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final scanItem = find.byValueKey("scan");
    final floatingActionButton = find.byType("FloatingActionButton");
    final responseText = find.byValueKey('responseJson');
    final expectedResult = "OPA!";

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("Test ReadCard", () async {
      print("Start Read Card test");

      print("Checking whether an element ReadCard is present");
      await isExist(scanItem, driver);
      print("Tap ReadCard in menu");
      await driver.tap(scanItem);

      print("Checking whether an element ActionButton is present");
      await isExist(floatingActionButton, driver);
      print("Tab action button");
      await driver.tap(floatingActionButton);

      print("Checking whether an element ResponseText is present");
      await isExist(responseText, driver);

      print("Reconciliation of Results and Expected Result");
      expect(await driver.getText(responseText), expectedResult);
    });

    tearDownAll(() async {
      await Future.delayed(Duration(seconds: 3));
      driver?.close();
    });
  });
}

isExist(parameter, driver) async{
  final isExists = await isPresent(parameter, driver);
  if (isExists) {
    print('Widget is present');
  } else {
    print('Widget is not present');
  }
}

isPresent(SerializableFinder byValueKey, FlutterDriver driver, {Duration timeout = const Duration(seconds: 3)}) async {
  try {
    await driver.waitFor(byValueKey,timeout: timeout);
    return true;
  } catch(exception) {
    return false;
  }
}

