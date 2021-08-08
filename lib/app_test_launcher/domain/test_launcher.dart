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

    VariableService.reset();
    VariableService.registerSetup(test.setup.toJson());

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

  void _runStep(StepModel step, [bool isNewIteration = true]) async {
    await Future.delayed(Duration(milliseconds: 500));
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
      final failure = result as StepFailure;
      _stopSession(() {
        _onStepError(failure);
      }, _extractErrorMessage(failure));
    }
  }

  void _prepare(Function onSuccess) {
    print("Test: Prepare");
    _stepFailure = null;
    _rePersonalize(onSuccess);
  }

  void _rePersonalize(Function onSuccess) {
    final config = _jsonTest.setup.personalizationConfig;
    final personalizationRequest = JSONRPCRequest(TangemSdk.getJsonRpcMethod(TangemSdk.cPersonalize)!, config);
    final onPersonalizeCallback = Callback((result) {
      print("Test: Prepare: PERSONALIZE complete");
      _stopSession(onSuccess);
    }, _onSdkError);

    final depersonalizeRequest = JSONRPCRequest(TangemSdk.getJsonRpcMethod(TangemSdk.cDepersonalize)!, {});
    final onDepersonalizeCallback = Callback((result) {
      print("Test: Prepare: DEPERSONALIZE complete");
      TangemSdk.runJSONRPCRequest(onPersonalizeCallback, personalizationRequest);
    }, _onSdkError);

    _startSession(() {
      print("Test: Prepare: Run: DE/PERSONALIZE");
      TangemSdk.runJSONRPCRequest(onDepersonalizeCallback, depersonalizeRequest);
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
    final message = _extractErrorMessage(failure);
    print(message);
    print(jsonEncode(failure.error));
  }

  String _extractErrorMessage(StepFailure failure) {
    if (failure.error is TangemSdkPluginWrappedError) {
      return "TangemSdkPluginWrappedError: ${failure.error.errorMessage}";
    } else if (failure.error is TestAssertError) {
      return "${failure.error.runtimeType.toString()}. ${failure.error.errorMessage}";
    } else if (failure.error is TestStepError) {
      return "Step failure: ${failure.error.runtimeType.toString()}";
    } else {
      return "Some undefined failure: ${failure.error.runtimeType.toString()}";
    }
  }

  void _startSession(Function onSuccess) {
    // print("Starting session...");
    TangemSdk.startSession(
        Callback((success) {
          print("Session started +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
          onSuccess();
        }, _onSdkError),
        {
          TangemSdk.initialMessage: _jsonTest.setup.sdkConfig[TangemSdk.initialMessage],
          TangemSdk.cardId: _jsonTest.setup.sdkConfig[TangemSdk.cardId],
        });
  }

  //TODO: останавливать сессию только при ошибке ассертов
  void _stopSession([Function? onSuccess, String? error]) {
    // print("Stopping session...");
    TangemSdk.stopSession(
        Callback((success) {
          print("Session stopped ---------------------------------------------------------------------");
          onSuccess?.call();
        }, _onSdkError),
        error != null ? {"error": error} : {});
  }
}
