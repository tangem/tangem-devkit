import 'dart:collection';

import 'package:devkit/app_tester/domain/common/test_result.dart';
import 'package:devkit/app_tester/domain/common/typedefs.dart';

import 'assert.dart';

class AssertsLauncher {
  final Queue<Assert> _assertsQueue;

  AssertsLauncher(this._assertsQueue);

  void run(OnComplete callback) {
    if (_assertsQueue.isEmpty) {
      callback(Success());
      return;
    }

    _executeAssert(_assertsQueue.removeFirst(), callback);
  }

  void _executeAssert(Assert exAssert, OnComplete callback) {
    exAssert.run((result) {
      if (result is Success) {
        if (_assertsQueue.isEmpty) {
          callback(Success());
        } else {
          _executeAssert(_assertsQueue.removeFirst(), callback);
        }
      } else {
        callback(result);
      }
    });
  }
}
