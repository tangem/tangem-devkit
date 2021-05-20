import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';

class TestStepListBloc extends BaseBloc {
  final _bsStepList = BehaviorSubject<List<TestStep>>();

  final StorageRepository _storageRepo;
  final JsonTestDetailScreenData screenData;

  late JsonTest _jsonTest;

  TestStepListBloc(this._storageRepo, this.screenData) {
    final jsonTest = _storageRepo.testsStorage.get(screenData.testName);
    if (jsonTest == null) throw Exception("Can't initialize $this. Json test is null for name ${screenData.testName}");

    _jsonTest = jsonTest;
    _updateStepList();
  }

  Stream<List<TestStep>> get stepsListStream => _bsStepList.stream;

  _updateStepList() {
    _bsStepList.add(_jsonTest.steps);
  }

  delete(int index) {
    _jsonTest.steps.removeAt(index);
    _jsonTest = _jsonTest.copyWith(steps: _jsonTest.steps);
    _storageRepo.testsStorage.set(_jsonTest.setup.name, _jsonTest);
    _updateStepList();
  }
}
