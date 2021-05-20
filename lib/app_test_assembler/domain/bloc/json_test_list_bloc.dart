import 'dart:convert';

import 'package:devkit/app/domain/typed_storage.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

class JsonTestListBloc extends BaseBloc {
  final bsRecords = BehaviorSubject<List<JsonTest>>();

  final StorageRepository _storageRepo;
  late final JsonTestsStorage _jsonTestsStorage;
  final _storedJsonTests = <JsonTest>[];

  JsonTestListBloc(this._storageRepo) {
    this._jsonTestsStorage = _storageRepo.testsStorage;
    addSubject(bsRecords);
    addSubscription(_jsonTestsStorage.isReadyToUseStream.listen(_listenStorageReady));
    addSubscription(_jsonTestsStorage.onStorageModifiedStream.listen(_listenStorageModification));
  }

  _listenStorageReady(bool isReady) {
    if (isReady) {
      _storedJsonTests.clear();
      _storedJsonTests.addAll(_jsonTestsStorage.values());
      _notifyRecordListChanged();
    }
  }

  _listenStorageModification(StorageModifyEvent<JsonTest> event) {
    switch (event.type) {
      case StorageModification.ADD:
        {
          _storedJsonTests.add(event.value);
          break;
        }
      case StorageModification.SET:
        {
          final index = _storedJsonTests.indexWhere((element) => element.setup.name == event.value.setup.name);
          if (index != -1) _storedJsonTests[index] = event.value;
          break;
        }
      case StorageModification.REMOVE:
        {
          _storedJsonTests.remove(event.value);
          break;
        }
    }
    _notifyRecordListChanged();
  }

  delete(int index) {
    if (index < 0 || index > _storedJsonTests.length) return;

    final jsonTest = _storedJsonTests[index];
    _jsonTestsStorage.remove(jsonTest.setup.name);
  }

  share(int index) {
    if (index < 0 || index > _storedJsonTests.length) return;

    final jsonTest = _storedJsonTests[index];
    Share.share(JsonEncoder.withIndent("  ").convert(jsonTest));
  }

  _notifyRecordListChanged() {
    _storedJsonTests.sort((a, b) => a.setup.creationDateMs.compareTo(b.setup.creationDateMs));
    bsRecords.add(_storedJsonTests);
  }
}
