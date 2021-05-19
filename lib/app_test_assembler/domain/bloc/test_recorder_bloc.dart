import 'dart:async';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/model/command_data.dart';
import 'package:tangem_sdk/sdk_plugin.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class TestRecorderBlock extends BaseBloc {
  final bsRecordingState = StatedBehaviorSubject<bool>();

  final TestStorageRepository _storageRepo;
  final _stepRecordsList = <StepRecord>[];
  final _subscriptions = <StreamSubscription>[];
  final _subjects = <Subject>[];

  late final TestAssembler _testAssembler;

  StepRecord? _currentRecord;

  TestRecorderBlock(this._storageRepo) {
    _testAssembler = TestAssembler(_storageRepo);
    _subjects.add(bsRecordingState.subject);
    _subscriptions.add(bsRecordingState.stream.listen(_listenRecordingState));
  }

  _listenRecordingState(bool isRecording) {
    if (isRecording) {
      sendSnackbarMessage("Starting record");
      return;
    }
    if (_stepRecordsList.isEmpty) {
      sendSnackbarMessage("No one records has been recorded");
      return;
    }

    sendSnackbarMessage("Recording is success");
    // if record is stopped and _recordingList is not empty -> create jsonTest and store it to the testsStorage
    final jsonTest = _testAssembler.assembleTest(_stepRecordsList);
    final name = jsonTest.setup.name;
    _storageRepo.testsStorage.set(name, jsonTest);
    _storageRepo.testsStorage.save(name: name);
    _stepRecordsList.clear();
  }

  toggleRecordState() {
    final newState = bsRecordingState.state ?? false;
    bsRecordingState.subject.add(!newState);
  }

  bool recordIsActive() => bsRecordingState.state ?? false;

  handleCommand(CommandDataModel commandData) {
    _currentRecord = StepRecord(commandData);
  }

  handleCommandResponse(dynamic response) {
    if (_currentRecord == null) return;

    final record = _currentRecord!;
    record.response = response;
    _stepRecordsList.add(record);
  }

  handleCommandError(TangemSdkBaseError? error) {
    _currentRecord = null;
  }

  @override
  dispose() {
    _subscriptions.forEach((element) => element.cancel());
    _subjects.forEach((element) => element.close());
  }
}

class TestStorageRepository {
  final testsStorage = JsonTestsStorage();
  final setupConfigStorage = TestSetupConfigStorage();
  final stepConfigStorage = TestStepConfigStorage();
}

typedef ErrorHandler = Function(String);

class TestAssembler {
  final TestStorageRepository _storageRepo;

  ErrorHandler? onErrorListener;

  TestAssembler(this._storageRepo);

  JsonTest assembleTest(List<StepRecord> records) {
    final testsCount = _storageRepo.testsStorage.size();
    final currentSetup = _storageRepo.setupConfigStorage.getCurrent();
    final setup = currentSetup.copyWith(name: "${currentSetup.name}_$testsCount");
    return JsonTest(setup, _createSteps(setup.name, records));
  }

  List<TestStep> _createSteps(String testName, List<StepRecord> records) {
    final stepConfig = _storageRepo.stepConfigStorage.getCurrent();
    return records.mapIndexed((index, e) => _createStep(e, index, stepConfig)).toNullSafe();
  }

  TestStep? _createStep(StepRecord record, int index, TestStep stepConfig) {
    final errorMessage = "Can't create a test step for the command: ${record.commandData.type}";
    if (!record.commandData.isPrepared()) {
      onErrorListener?.call("$errorMessage. Command isn't prepared.");
      return null;
    }
    if (record.response is! TangemSdkResponse) {
      onErrorListener?.call("$errorMessage. Command response isn't TangemSdkResponse.");
      return null;
    }
    final jsonData = record.commandData.toJson((error) {
      onErrorListener?.call("$errorMessage. Command conversion error. Error: $error");
      return null;
    });
    if (jsonData == null) {
      onErrorListener?.call("$errorMessage. Command conversion result is NULL");
      return null;
    }

    final jsonRpc = JsonRpcRequest.fromCommandDataJson(jsonData);
    final expectedResult = (record.response as TangemSdkResponse).toJson();
    return TestStep(
      "$index.${stepConfig.name}.${jsonRpc.method}",
      jsonRpc.method,
      jsonRpc.parameters,
      expectedResult,
      stepConfig.asserts,
      stepConfig.actionType,
      stepConfig.iterations,
    );
  }
}

class StepRecord {
  final CommandDataModel commandData;
  dynamic response;

  StepRecord(this.commandData);
}
