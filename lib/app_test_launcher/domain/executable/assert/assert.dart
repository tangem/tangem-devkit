import 'dart:core';

import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:devkit/app_test_launcher/domain/error/test_assert_error.dart';
import 'package:devkit/app_test_launcher/domain/executable/executable.dart';
import 'package:devkit/app_test_launcher/domain/variable_service.dart';

class AssertsFactory {
  Map<String, TestAssert Function()> _assertsBuilders = {};

  registerAssert(String type, TestAssert Function() assertBuilder) {
    _assertsBuilders[type] = assertBuilder;
  }

  TestAssert? getAssert(String type) {
    return _assertsBuilders[type]?.call();
  }
}

abstract class TestAssert implements Executable {
  final String _type;

  late String parentName;
  late List<dynamic> fields;

  TestAssert(this._type);

  void init(String parentName, List<dynamic>? fields) {
    this.parentName = parentName;
    this.fields = fields == null ? [] : fields;
  }

  @override
  void run(OnComplete callback);

  dynamic _getFieldValue(dynamic pointer) {
    return pointer is String ? VariableService.getValue(parentName, pointer) : pointer;
  }

  static String equals = "EQUALS";
  static String isNotEmpty = "IS_NOT_EMPTY";
  static String success = "SUCCESS";
}

class EqualsAssert extends TestAssert {
  EqualsAssert() : super(TestAssert.equals);

  @override
  run(OnComplete callback) {
    final firstValue = _getFieldValue(fields[0]);
    final secondValue = _getFieldValue(fields[1]);
    if (firstValue == secondValue) {
      callback(AssertSuccess(_type));
    } else {
      callback(AssertFailure(_type, EqualsError(firstValue, secondValue)));
    }
  }
}

class IsNotEmptyAssert extends TestAssert {
  IsNotEmptyAssert() : super(TestAssert.isNotEmpty);

  @override
  void run(OnComplete callback) {
    final value = _getFieldValue(fields[0]);
    if (value != null) {
      callback(AssertSuccess(_type));
    } else {
      _getFieldValue(fields[0]);
      callback(AssertFailure(_type, IsNotEmptyError("${fields[0]}")));
    }
  }
}

class SuccessAssert extends TestAssert {
  SuccessAssert() : super(TestAssert.success);

  @override
  void run(OnComplete callback) {
    callback(AssertSuccess(_type));
  }
}
