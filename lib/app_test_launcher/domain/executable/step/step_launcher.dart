import 'dart:collection';
import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:devkit/app_test_launcher/domain/error/error.dart';
import 'package:devkit/app_test_launcher/domain/error/test_executable_error.dart';
import 'package:devkit/app_test_launcher/domain/executable/assert/assert.dart';
import 'package:devkit/app_test_launcher/domain/executable/assert/assert_launcher.dart';
import 'package:devkit/app_test_launcher/domain/executable/executable.dart';
import 'package:devkit/app_test_launcher/domain/variable_service.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class StepLauncher implements Executable {
  final StepModel _model;
  final AssertsFactory _assertsFactory;

  StepLauncher(this._model, this._assertsFactory) {
    VariableService.registerStep(_model.name, _model.toJson());
  }

  @override
  void run(OnComplete callback) {
    _fetchVariables();

    final jsonRpcRequestCallback = Callback((result) {
      VariableService.registerResult(_model.name, result);
      _executeAsserts(callback);
    }, (error) {
      callback(Failure(CustomError(jsonEncode(error))));
    });

    TangemSdk.runJSONRPCRequest(jsonRpcRequestCallback, JSONRPCRequest(_model.method, _model.params));
  }

  void _fetchVariables() {
    _model.params.clear();
    _model.rawParams.forEach((key, value) {
      _model.params[key] = VariableService.getValue(_model.name, value);
    });
    _model.expectedResult.forEach((key, value) {
      _model.expectedResult[key] = VariableService.getValue(_model.name, value);
    });
  }

  void _executeAsserts(OnComplete callback) {
    if (_model.asserts.isEmpty) {
      callback(Success());
      return;
    }

    final assertsQueue = Queue<TestAssert>();
    _model.asserts.forEach((element) {
      final testAssert = _assertsFactory.getAssert(element.type);
      if (testAssert == null) {
        callback(Failure(ExecutableNotFoundError(element.type)));
        return;
      }

      testAssert.init(_model.name, element.fields);
      assertsQueue.add(testAssert);
    });

    AssertsLauncher(assertsQueue).run(callback);
  }
}
