import 'dart:collection';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_tester/domain/common/test_executable_error.dart';
import 'package:devkit/app_tester/domain/common/test_result.dart';
import 'package:devkit/app_tester/domain/common/typedefs.dart';
import 'package:devkit/app_tester/domain/executable/assert/assert.dart';
import 'package:devkit/app_tester/domain/executable/assert/assert_launcher.dart';
import 'package:devkit/app_tester/domain/executable/executable.dart';
import 'package:devkit/app_tester/domain/variable_service.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

abstract class Step extends Executable {
  int getIterationCount();

  String getActionType() => "NFC_SESSION_RUNNABLE";

  void init(CardSession session, JSONRPCConverter jsonRpcConverter, AssertsFactory assertsFactory);
}

class TestStep extends Step {
  final StepModel model;

  late CardSession session;
  late JSONRPCConverter jsonRpcConverter;
  late AssertsFactory assertsFactory;

  TestStep(this.model);

  @override
  int getIterationCount() => model.iterations ?? 1;

  @override
  String getMethod() => model.method;

  @override
  void init(CardSession session, JSONRPCConverter jsonRpcConverter, AssertsFactory assertsFactory) {
    this.session = session;
    this.jsonRpcConverter = jsonRpcConverter;
    this.assertsFactory = assertsFactory;
  }

  @override
  run(OnComplete callback) {
    _fetchVariables();
    final runnable = jsonRpcConverter.convert(JSONRPCRequest(model.method, model.params));
    if (runnable == null) {
      callback(Failure(MissingJsonAdapterError(model.method)));
      return;
    }

    _runInternal(runnable, callback);
  }

  void _runInternal(JSONRPCConvertible<dynamic> runnable, OnComplete callback) {
    // runnable.run(session) { result ->
    //   when (result) {
    //     is CompletionResult.Success -> {
    //         val jsonResponse = (result.data as? JSONRPCResponse).guard {
    //           callback(TestResult.Failure(ExecutableError.UnexpectedResponseError(result.data)))
    //           return@run
    //         }
    //
    //         VariableService.registerResult(model.name, jsonResponse)
    //         executeAsserts(callback)
    //     }
    //     is CompletionResult.Failure -> callback(TestResult.Failure(result.error.toFrameworkError()))
    //   }
    // }
  }

  void _fetchVariables() {
    model.params.clear();
    model.rawParams.forEach((key, value) {
      model.params[key] = VariableService.getValue(model.name, value);
    });
  }

  void _executeAsserts(OnComplete callback) {
    if (model.asserts.isEmpty) {
      callback(Success());
      return;
    }

    final assertsQueue = Queue<Assert>();
    model.asserts.forEach((element) {
      final exAssert = assertsFactory.getAssert(element.type);
      if (exAssert == null) {
        callback(Failure(ExecutableNotFoundError(element.type)));
        return;
      }

      exAssert.init(model.name, element.fields);
      assertsQueue.add(exAssert);
    });

    AssertsLauncher(assertsQueue).run(callback);
  }
}