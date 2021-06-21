import 'dart:async';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

abstract class JsonTestsRepository {
  Future init();

  List<JsonTest> getList();

  JsonTest? get(String name);
}

class JsonTestRepository implements JsonTestsRepository {
  final JsonTestsStorage storage = JsonTestsStorage();

  @override
  Future init() {
    final completer = Completer();
    storage.isReadyToUseStream.listen((event) {
      if (event) completer.complete();
    });
    return completer.future;
  }

  @override
  JsonTest? get(String name) {
    return storage.get(name);
  }

  @override
  List<JsonTest> getList() {
    return storage.names().map((e) => storage.get(e)).toList().toNullSafe();
  }
}
