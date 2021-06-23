import 'dart:core';

import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:devkit/app_test_launcher/domain/error/test_assert_error.dart';
import 'package:devkit/app_test_launcher/domain/executable/executable.dart';
import 'package:devkit/app_test_launcher/domain/variable_service.dart';

class AssertsFactory {
  TestAssert? getAssert(String type) {
    return null;
  }
}

abstract class TestAssert implements Executable {
  final String _type;

  late String parentName;
  late List<String> fields;

  TestAssert(this._type);

  void init(String parentName, List<String> fields) {
    this.parentName = parentName;
    this.fields = fields;
  }

  @override
  void run(OnComplete callback);

  dynamic getFieldValue(String pointer) {
    return VariableService.getValue(parentName, pointer);
  }
}

class EqualsAssert extends TestAssert {
  EqualsAssert() : super("EQUALS");

  @override
  run(OnComplete callback) {
    final firstValue = getFieldValue(fields[0]);
    final secondValue = getFieldValue(fields[1]);
    if (firstValue == secondValue) {
      callback(AssertSuccess(_type));
    } else {
      callback(AssertFailure(_type, EqualsError(firstValue, secondValue)));
    }
  }
}
