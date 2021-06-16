import 'package:devkit/app_tester/domain/common/test_assert_error.dart';
import 'package:devkit/app_tester/domain/common/test_result.dart';
import 'package:devkit/app_tester/domain/common/typedefs.dart';

import 'assert.dart';

class EqualsAssert extends BaseAssert {
  EqualsAssert() : super("EQUALS");

  @override
  runAssert(OnComplete callback) {
    final firstValue = getFieldValue(fields[0]);
    final secondValue = getFieldValue(fields[1]);
    if (firstValue == secondValue) {
      callback(Success(getMethod()));
    } else {
      final error = EqualsError(firstValue, secondValue);
      callback(Failure(error));
    }
  }
}
