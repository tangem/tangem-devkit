import 'dart:convert';

import 'package:devkit/app_test_launcher/domain/JsonValueFinder.dart';
import 'package:test/test.dart';

import 'assets.dart';

void main() {
  group("JsonValueFinder", () {
    test("Find a variable by a simple variable path", findBySimplePath);
    test("Find a variable by by an array element and into the element", findByArrayElement);
  });
}

void findBySimplePath() {
  final map = jsonDecode(json);
  final finder = JsonValueFinder();
  finder.setValue("test", map);
  dynamic resultValue = finder.getValue("{test.setup.name}");
  expect(resultValue, "Twins");
  resultValue = finder.getValue("{test.setup.iterations}");
  expect(resultValue, 2);
  resultValue = finder.getValue("{test.setup.personalizationConfig.config.pin}");
  expect(resultValue, "000000");
  resultValue = finder.getValue("{test.setup.personalizationConfig.config.p}");
  expect(resultValue, null);
}

void findByArrayElement() {
  final map = jsonDecode(json);
  final finder = JsonValueFinder();
  finder.setValue("test", map);
  dynamic resultValue = finder.getValue("{test.setup.personalizationConfig.config.signingMethods.0}");
  expect(resultValue, "SignHash");
  resultValue = finder.getValue("{test.setup.personalizationConfig.config.ndefRecords.0.type}");
  expect(resultValue, "AAR");
  resultValue = finder.getValue("{test.setup.personalizationConfig.config.signingMethods.1}");
  expect(resultValue, null);
  resultValue = finder.getValue("{test.setup.personalizationConfig.config.signingMethods.qwe}");
  expect(resultValue, null);
}
