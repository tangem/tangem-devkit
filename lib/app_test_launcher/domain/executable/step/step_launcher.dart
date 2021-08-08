import 'dart:collection';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:devkit/app_test_launcher/domain/error/error.dart';
import 'package:devkit/app_test_launcher/domain/error/test_assert_error.dart';
import 'package:devkit/app_test_launcher/domain/error/test_step_error.dart';
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
      final jsonRpcResponse = result as JSONRPCResponse;
      if (jsonRpcResponse.result == null && jsonRpcResponse.error != null) {
        if (jsonRpcResponse.error?.isInterruptTest() == true) {
          // TODO: приудмать что отправить
          // callback(Failure());
          return;
        } else {
          VariableService.registerError(_model.name, jsonRpcResponse.error);
        }
      } else {
        final error = _checkExpectedWithActualResult(_model.expectedResult, jsonRpcResponse);
        if (error != null) {
          callback(StepFailure(_model.name, error));
          return;
        }
        VariableService.registerActualResult(_model.name, jsonRpcResponse.result);
      }
      _executeAsserts(callback);
    }, (error) {
      callback(StepFailure(_model.name, TangemSdkPluginWrappedError(error)));
    });

    TangemSdk.runJSONRPCRequest(jsonRpcRequestCallback, JSONRPCRequest(_model.method, _model.params));
  }

  void _fetchVariables() {
    _model.params.clear();
    _model.rawParams.forEach((key, value) {
      //TODO: добавить раскрытие переменных во вложенных структурах
      final extractedValue = VariableService.getValue(_model.name, value);
      _model.params[key] = extractedValue;
    });
  }

  void _executeAsserts(OnComplete callback) {
    if (_model.asserts.isEmpty) {
      callback(StepSuccess(_model.name));
      return;
    }

    final assertsQueue = Queue<TestAssert>();
    for (final element in _model.asserts){
      final testAssert = _assertsFactory.getAssert(element.type);
      if (testAssert == null) {
        callback(StepFailure(_model.name, AssertNotRegisteredError(element.type)));
        return;
      }

      testAssert.init(_model.name, element.fields);
      assertsQueue.add(testAssert);
    }

    AssertsLauncher(assertsQueue).run((result) {
      if (result is Success) {
        callback(StepSuccess(_model.name));
      } else {
        callback(StepFailure.fromAssert(_model.name, result as AssertFailure));
      }
    });
  }

  TestAssertError? _checkExpectedWithActualResult(Map<String, dynamic> expResult, JSONRPCResponse jsonRpcResponse) {
    if (jsonRpcResponse.result is! Map<String, dynamic>)
      return ExpectedAndActualResultError("JsonRpc result is not a map");

    return null;

    final actualResult = jsonRpcResponse.result as Map<String, dynamic>;
    if (expResult.length != actualResult.length) return ExpectedAndActualResultError("Results length doesn't match");

    final missedKeys = expResult.keys.toList()..removeWhere((element) => actualResult.containsKey(element));
    final unexpectedKeys = actualResult.keys.toList()..removeWhere((element) => expResult.containsKey(element));

    if (missedKeys.isNotEmpty || unexpectedKeys.isNotEmpty) {
      final missed = "Missed keys in the actual result: [${missedKeys.join(", ")}]";
      final unexpected = "Unexpected keys in the actual result: [${unexpectedKeys.join(", ")}]";
      return ExpectedAndActualResultError("$missed. $unexpected");
    }

    return null;
  }
}
