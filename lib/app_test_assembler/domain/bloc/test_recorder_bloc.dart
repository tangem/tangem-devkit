import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:tangem_sdk/model/command_data.dart';
import 'package:tangem_sdk/sdk_plugin.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class TestRecorderBlock extends BaseBloc {
  final bsRecordingState = StatedBehaviorSubject<bool>(false);

  final StorageRepository _storageRepo;
  late final TestAssembler _testAssembler;

  JsonTest? _currentJsonTestRecord;
  StepRecord? _currentRecord;

  TestRecorderBlock(this._storageRepo) {
    _testAssembler = TestAssembler(_storageRepo);
    addSubject(bsRecordingState.subject);
    addSubscription(bsRecordingState.stream.listen(_listenRecordingState));
  }

  _listenRecordingState(bool isRecording) {
    if (isRecording) {
      sendSnackbarMessage("Starting record");
      JsonTest jsonTest = _testAssembler.createEmptyJsonTest();
      _storageRepo.testsStorage.add(jsonTest.setup.name, jsonTest);
      _currentJsonTestRecord = jsonTest;
      return;
    }

    if (_currentJsonTestRecord == null) return;

    final currentJsonTestRecord = _currentJsonTestRecord!;
    if (currentJsonTestRecord.steps.isEmpty) {
      _storageRepo.testsStorage.remove(currentJsonTestRecord.setup.name);
      _currentJsonTestRecord = null;
      sendSnackbarMessage("No one records has been recorded");
      return;
    }
    sendSnackbarMessage("Recording is success");
    _storageRepo.testsStorage.set(currentJsonTestRecord.setup.name, currentJsonTestRecord);
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
    if (_currentJsonTestRecord == null || _currentRecord == null) return;

    _currentJsonTestRecord = _testAssembler.addStepRecord(
      _currentJsonTestRecord!,
      _currentRecord!..response = response,
    );
    _storageRepo.testsStorage.set(_currentJsonTestRecord!.setup.name, _currentJsonTestRecord!);
    _currentRecord = null;
  }

  handleCommandError(TangemSdkBaseError? error) {
    _currentRecord = null;
  }
}

class StorageRepository {
  final personalizationConfigStorage = PersonalizationConfigStorage();
  final testsStorage = JsonTestsStorage();
  final setupConfigStorage = TestSetupConfigStorage();
  final stepConfigStorage = TestStepConfigStorage();
}

typedef ErrorHandler = Function(String);

class TestAssembler {
  final StorageRepository _storageRepo;

  ErrorHandler? onErrorListener;

  TestAssembler(this._storageRepo);

  JsonTest createEmptyJsonTest() {
    final setup = _storageRepo.setupConfigStorage.getCurrent();
    final testsCount = _storageRepo.testsStorage.size();
    return JsonTest(setup.copyWith(name: "${setup.name}_$testsCount"), []);
  }

  JsonTest addStepRecord(JsonTest jsonTest, StepRecord stepRecord) {
    final newStepList = List.of(jsonTest.steps);
    final stepConfig = _storageRepo.stepConfigStorage.getCurrent();
    final newStep = _createStep(stepRecord, newStepList.length, stepConfig);
    if (newStep == null) {
      return jsonTest;
    } else {
      newStepList.add(newStep);
      return jsonTest.copyWith(steps: newStepList);
    }
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

    final jsonRpc = JSONRPCRequest.fromCommandDataJson(jsonData);
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
