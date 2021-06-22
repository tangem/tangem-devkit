import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'common/test_result.dart';
import 'common/typedefs.dart';
import 'error/error.dart';
import 'error/test_error.dart';
import 'executable/assert/assert.dart';
import 'executable/step/step_launcher.dart';
import 'variable_service.dart';

class TestLauncher {
  final JsonTest _jsonTest;
  final AssertsFactory _assertsFactory;

  OnComplete? onTestComplete;

  Queue _testQueue = Queue<JsonTest>();
  Queue _stepQueue = Queue<StepModel>();

  TestLauncher(this._jsonTest, this._assertsFactory);

  void launch() {
    _startSession(() {
      _testQueue = _generateTestQueue();
      final nextTest = _testQueue.poll();
      if (nextTest == null) {
        onTestComplete?.call(Failure(TestIsEmptyError()));
      } else {
        _runTest(nextTest);
      }
    }, (startingSessionError) {
      onTestComplete?.call(Failure(startingSessionError));
    });
  }

  void _startSession(Function onSuccess, Function(dynamic error) onError) {
    TangemSdk.startSession(Callback((success) => onSuccess(), onError), {
      TangemSdk.initialMessage: _jsonTest.setup.sdkConfig[TangemSdk.initialMessage],
      TangemSdk.cardId: _jsonTest.setup.sdkConfig[TangemSdk.cardId],
    });
  }

  void _stopSession(Function onSuccess, Function(dynamic error) onError) {
    TangemSdk.stopSession(Callback((success) => onSuccess(), (error) => onError(error)));
  }

  void _runTest(JsonTest test) {
    VariableService.reset();
    _prepare().then((value) {
      _stepQueue = Queue.from(test.steps);
      final nextStep = _stepQueue.poll();
      if (nextStep == null) {
        _onStepSequenceComplete(Success(test.setup.name));
      } else {
        _runStep(nextStep);
      }
    }).onError((error, stackTrace) {
      _handleError(error);
    });
  }

  void _onStepComplete(TestResult result) {
    if (result is Success) {
      final nextStep = _stepQueue.poll();
      if (nextStep == null) {
        _onStepSequenceComplete(result);
      } else {
        _runStep(nextStep);
      }
    } else {
      _onStepSequenceComplete(result);
    }
  }

  void _runStep(StepModel step) {
    StepLauncher(step, _assertsFactory).run(_onStepComplete);
  }

  void _onStepSequenceComplete(TestResult result) {
    if (result is Success) {
      final nextTest = _testQueue.poll();
      if (nextTest == null) {
        _stopSession((){
          onTestComplete?.call(Success(_jsonTest.setup.name));
        }, (error) {
          _handleError(error);
        });
      } else {
        _runTest(nextTest);
      }
    } else {
      _handleError(result);
    }
  }

  void _handleError(dynamic error) {
    onTestComplete?.call(Failure(CustomError(jsonEncode(error))));
  }

  Queue<JsonTest> _generateTestQueue() {
    final tests = [];
    if (_jsonTest.setup.iterations == null) {
      tests.add(_jsonTest);
    } else {
      _jsonTest.setup.iterations?.foreach((e) => tests.add(_jsonTest));
    }
    return Queue.from(tests);
  }

  Future _prepare() {
    final completer = Completer();
    _configureSdk(() {
      _rePersonalize(() {
        completer.complete();
      }, _handleError);
    }, _handleError);
    return completer.future;
  }

  void _configureSdk(Function onSuccess, Function(dynamic error) onError) {
    onSuccess();
  }

  void _rePersonalize(Function onSuccess, Function(dynamic error) onError) {
    onSuccess();
  }
}
