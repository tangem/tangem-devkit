import 'dart:core';

import 'package:devkit/app_tester/domain/common/typedefs.dart';
import 'package:devkit/app_tester/domain/executable/executable.dart';

abstract class Assert implements Executable {
  void init(String parentName, List<String> fields);
}

abstract class BaseAssert implements Assert {
  final String _type;

  late String parentName;
  late List<String> fields;

  BaseAssert(this._type);

  @override
  String getMethod() {
    return _type;
  }

  @override
  void init(String parentName, List<String> fields) {
    this.parentName = parentName;
    this.fields = fields;
  }

  @override
  run(OnComplete callback) {
    // if (isInitialized()) {
    //    callback(TestResult.Failure(ExecutableError.ExecutableNotInitialized(getMethod())))
    //    return
    // }
    runAssert(callback);
  }

  runAssert(OnComplete callback);

  dynamic getFieldValue(String pointer) {
    return null;
    // return VariableService.getValue(parentName, pointer);
  }
}
