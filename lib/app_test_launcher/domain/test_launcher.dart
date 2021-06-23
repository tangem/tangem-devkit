import 'dart:collection';
import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_launcher/domain/error/error.dart';
import 'package:devkit/app_test_launcher/domain/error/test_step_error.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'common/test_result.dart';
import 'common/typedefs.dart';
import 'error/test_assert_error.dart';
import 'executable/assert/assert.dart';
import 'executable/step/step_launcher.dart';
import 'variable_service.dart';

class TestLauncher {
  static final int defaultIterationsCount = 1;

  final JsonTest _jsonTest;
  final AssertsFactory _assertsFactory;
  OnComplete? onTestComplete;

  Queue<StepModel> _stepQueue = Queue<StepModel>();

  late JsonTest _testTemplate;
  late StepModel _stepTemplate;

  int _testIterationsLeft = defaultIterationsCount;
  int _stepIterationsLeft = defaultIterationsCount;

  List<String> _successSteps = [];
  StepFailure? _stepFailure;

  TestLauncher(this._jsonTest, this._assertsFactory);

  void launch() async {
    if (_jsonTest.steps.isEmpty) {
      onTestComplete?.call(Success(_jsonTest.setup.name));
      return;
    }

    _testTemplate = _jsonTest.copyWith();
    _testIterationsLeft = _jsonTest.setup.iterations ?? defaultIterationsCount;
    _startNewTest(_jsonTest);
  }

  void _startNewTest(JsonTest test) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (_testIterationsLeft == 0) {
      onTestComplete?.call(Success(_jsonTest.setup.name));
      return;
    }

    print("");
    print("Test: ${test.setup.name}: Start");
    _prepare(() async {
      print("Test: Prepare: Complete");
      await Future.delayed(Duration(milliseconds: 1000));
      _startSession(() {
        _runTest(test);
      });
    });
  }

  void _runTest(JsonTest test) {
    print("Test: ${test.setup.name}: Run: iterations left: $_testIterationsLeft");
    _testIterationsLeft--;
    _stepQueue = Queue.from(test.steps);
    final nextStep = _stepQueue.poll();
    if (nextStep == null) {
      _onStepSequenceComplete(Success(test.setup.name));
    } else {
      _runStep(nextStep);
    }
  }

  void _runStep(StepModel step, [bool isNewIteration = true]) async{
    await Future.delayed(Duration(milliseconds: 300));
    if (isNewIteration) {
      _stepTemplate = step.copyWith();
      _stepIterationsLeft = step.iterations ?? defaultIterationsCount;
    }
    print("Test: ${_testTemplate.setup.name}: Step: ${step.name}: Run: iterations left: $_stepIterationsLeft");
    _stepIterationsLeft--;
    StepLauncher(step, _assertsFactory).run(_onStepComplete);
  }

  void _onStepComplete(TestResult result) {
    if (result is Success) {
      final stepName = result.name ?? "Undefined";
      _successSteps.add(stepName);
      print("Test: ${_testTemplate.setup.name}: Step: $stepName: Complete");
      if (_stepIterationsLeft == 0) {
        final nextStep = _stepQueue.poll();
        if (nextStep == null) {
          _onStepSequenceComplete(result);
        } else {
          _runStep(nextStep);
        }
      } else {
        _runStep(_stepTemplate, false);
      }
    } else {
      _onStepSequenceComplete(result);
    }
  }

  void _onStepSequenceComplete(TestResult result) {
    print("Test: ${_testTemplate.setup.name}: Complete");
    if (result is Success) {
      _stopSession(() {
        _startNewTest(_testTemplate);
      });
    } else {
      _stopSession(() {
        _onStepError(result as StepFailure);
      });
    }
  }

  void _prepare(Function onSuccess) {
    print("Test: Prepare");
    VariableService.reset();
    _stepFailure = null;
    _rePersonalize(onSuccess);
  }

  void _rePersonalize(Function onSuccess) {
    final depersonalize = JSONRPCRequest(TangemSdk.getJsonRpcMethod(TangemSdk.cDepersonalize)!, {});
    final personalize = JSONRPCRequest(
      TangemSdk.getJsonRpcMethod(TangemSdk.cPersonalize)!,
      _jsonTest.setup.personalizationConfig,
    );

    _startSession(() {
      print("Test: Prepare: Run: DE/PERSONALIZE");
      TangemSdk.runJSONRPCRequest(
          Callback((_) {
            TangemSdk.runJSONRPCRequest(Callback((_) => _stopSession(onSuccess), _onSdkError), personalize);
          }, _onSdkError),
          depersonalize);
    });
  }

  // все ошибки TangemSdkPluginError должны прерывать выполнение теста, т.к. они формируется
  // не в результате работы jsonRPC

  _onSdkError(dynamic error) {
    print("Error type: ${error.runtimeType.toString()}");
    print(jsonEncode(error));
  }

  _onStepError(StepFailure failure) {
    _stepFailure = failure;
    if (failure.error is TangemSdkPluginWrappedError) {
    } else if (failure.error is TestAssertError) {
      print("Assert failure: ${failure.error.runtimeType.toString()}");
      print(jsonEncode(failure.error));
    } else if (failure.error is TestStepError) {
      print("Step failure: ${failure.error.runtimeType.toString()}");
      print(jsonEncode(failure.error));
    } else {
      print("Some undefined failure: ${failure.error.runtimeType.toString()}");
      print(jsonEncode(failure.error));
    }
  }

  void _startSession(Function onSuccess) {
    // print("Starting session...");
    TangemSdk.startSession(Callback((success) {
      print("Session started +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      onSuccess();
    }, _onSdkError), {
      TangemSdk.initialMessage: _jsonTest.setup.sdkConfig[TangemSdk.initialMessage],
      TangemSdk.cardId: _jsonTest.setup.sdkConfig[TangemSdk.cardId],
    });
  }

  void _stopSession([Function? onSuccess]) {
    // print("Stopping session...");
    TangemSdk.stopSession(Callback((success) {
      print("Session stopped ---------------------------------------------------------------------");
      onSuccess?.call();
    }, _onSdkError));
  }
}
