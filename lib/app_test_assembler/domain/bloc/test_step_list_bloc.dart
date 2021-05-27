import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';

class TestStepListBloc extends BaseBloc {
  final _bsStepList = BehaviorSubject<JsonTest>();

  final StorageRepository _storageRepo;

  late JsonTest _jsonTest;

  TestStepListBloc(this._storageRepo, Stream<String> testNameStream) {
    addSubscription(testNameStream.listen((event) {
      final jsonTest = _storageRepo.testsStorage.get(event);
      if (jsonTest == null) throw Exception("Can't initialize $this. Json test is null for name $event");

      _updateStepList(jsonTest);
    }));
  }

  Stream<JsonTest> get stepsListStream => _bsStepList.stream;

  _updateStepList(JsonTest jsonTest) {
    _jsonTest = jsonTest;
    _bsStepList.add(jsonTest.copyWith());
  }

  delete(int index) {
    _jsonTest.steps.removeAt(index);
    final copyOfJsonTest = _jsonTest.copyWith(steps: _jsonTest.steps);
    _storageRepo.testsStorage.set(copyOfJsonTest.setup.name, _jsonTest);
    _updateStepList(copyOfJsonTest);
  }
}
