import 'dart:collection';

import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:devkit/app_test_launcher/domain/executable/executable.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

import 'assert.dart';

class AssertsLauncher implements Executable {
  final Queue<TestAssert> _assertsQueue;

  AssertsLauncher(this._assertsQueue);

  @override
  void run(OnComplete callback) {
    _executeAssert(_assertsQueue.poll(), callback);
  }

  void _executeAssert(TestAssert? testAssert, OnComplete callback) {
    if (testAssert == null) {
      callback(Success());
    } else {
      testAssert.run((result) {
        if (result is AssertSuccess) {
          _executeAssert(_assertsQueue.poll(), callback);
        } else {
          callback(result);
        }
      });
    }
  }
}
