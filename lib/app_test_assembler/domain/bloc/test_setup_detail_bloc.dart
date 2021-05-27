import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';

class TestSetupDetailBloc extends BaseBloc {
  final JsonEncoder _encoder = JsonEncoder.withIndent("  ");

  final StorageRepository _storageRepository;
  final JsonTestsStorage _testsStorage;
  final JsonTestDetailScreenData screenData;

  final _bsJsonTestName = BehaviorSubject<String>();
  final _bsSetupJsonValue = BehaviorSubject<String>();
  final bsName = BehaviorSubject<String>();
  final bsDescription = BehaviorSubject<String>();
  final bsIterationCount = BehaviorSubject<String>();

  late JsonTest _jsonTest;
  late String _name;
  late String _description;
  late int _iterations;

  TestSetupDetailBloc(this._storageRepository, this.screenData) : this._testsStorage = _storageRepository.testsStorage {
    init();
    addSubscription(bsName.listen((value) => _name = value));
    addSubscription(bsDescription.listen((value) => _description = value));
    addSubscription(bsIterationCount.listen((value) => _iterations = int.tryParse(value) ?? 1));
    _updateSetupJsonValue();
  }

  Stream<String> get jsonTestNameStream => _bsJsonTestName.stream;

  Stream<String> get setupJsonValueStream => _bsSetupJsonValue.stream;

  init() {
    final jsonTest = _storageRepository.testsStorage.get(screenData.testName);
    if (jsonTest == null) throw Exception("Can't initialize $this. Json test is null for name ${screenData.testName}");

    _jsonTest = jsonTest;
    _name = _jsonTest.setup.name;
    _description = _jsonTest.setup.description;
    _iterations = _jsonTest.setup.iterations ?? 1;

    bsName.add(_name);
    bsDescription.add(_description);
    bsIterationCount.add(_iterations.toString());
    _bsJsonTestName.add(_name);
  }

  _updateSetupJsonValue() {
    _bsSetupJsonValue.add(_encoder.convert(_jsonTest.setup));
  }

  void save() {
    if (!_setupHasChanges()) {
      sendSnackbarMessage("Nothing to save");
      return;
    }

    final oldName = _jsonTest.setup.name;
    final newSetup = _jsonTest.setup.copyWith(name: _name, description: _description, iterations: _iterations);
    _jsonTest = _jsonTest.copyWith(setup: newSetup);

    if (oldName == _name) {
      // The name has not changed. No need to remove it from the file system
      _testsStorage.set(oldName, _jsonTest);
    } else {
      _testsStorage.remove(oldName);
      _testsStorage.add(_jsonTest.setup.name, _jsonTest);
      _bsJsonTestName.add(_jsonTest.setup.name);
    }
    _updateSetupJsonValue();
  }

  bool _setupHasChanges() {
    final setup = _jsonTest.setup;
    if (_name != setup.name) return true;
    if (_description != setup.description) return true;
    if (_iterations != setup.iterations) return true;
    return false;
  }
}
