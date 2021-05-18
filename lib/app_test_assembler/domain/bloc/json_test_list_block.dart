import 'dart:async';
import 'dart:convert';

import 'package:devkit/app/domain/typed_storage.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

class JsonTestListBloc extends DisposableBloc {
  final bsRecords = BehaviorSubject<List<JsonTest>>();

  final TestStorageRepository _testStorageRepository;
  late final JsonTestsStorage _jsonTestsStorage;
  final _storedJsonTests = <JsonTest>[];
  final _subscriptions = <StreamSubscription>[];
  final _subjects = <Subject>[];

  JsonTestListBloc(this._testStorageRepository) {
    this._jsonTestsStorage = _testStorageRepository.testsStorage;
    _subjects.add(bsRecords);
    _subscriptions.add(_jsonTestsStorage.isReadyToUseStream.listen(_listenStorageReady));
    _subscriptions.add(_jsonTestsStorage.onStorageModifiedStream.listen(_listenStorageModification));
  }

  _listenStorageReady(bool isReady) {
    if (isReady) {
      _storedJsonTests.clear();
      _storedJsonTests.addAll(_jsonTestsStorage.values());
      _notifyRecordListChanged();
    }
  }

  _listenStorageModification(StorageModifyEvent<JsonTest> event) {
    if (event.type == StorageModification.SET) {
      _storedJsonTests.add(event.value);
    } else {
      _storedJsonTests.remove(event.value);
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

  @override
  dispose() {
    _subscriptions.forEach((element) => element.cancel());
    _subjects.forEach((element) => element.close());
  }
}
