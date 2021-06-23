import 'dart:async';
import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tangem_sdk/extensions/exp_extensions.dart';

abstract class JsonTestsRepository {
  Future init();

  List<JsonTest> getList();

  JsonTest? get(String name);
}

class JsonTestStorageRepository implements JsonTestsRepository {
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

class JsonTestAssetsRepository implements JsonTestsRepository {
  List<JsonTest> _jsonTests = [];

  @override
  Future init() async {
    final completer = Completer();

    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final testPaths = manifestMap.keys
        .where((String key) => key.contains('json/'))
        .where((String key) => key.contains('.json'))
        .toList();

    int inconvertibleCount = 0;
    testPaths.forEach((element) {
      rootBundle.loadString(element).then((value) {
        try {
          final map = jsonDecode(value);
          _jsonTests.add(JsonTest.fromJson(map));
        } catch (ex) {
          inconvertibleCount++;
        }
        if (testPaths.length - inconvertibleCount == _jsonTests.length) completer.complete();
      });
    });

    return completer.future;
  }

  @override
  JsonTest? get(String name) {
    return _jsonTests.firstWhereOrNull((e) => e.setup.name == name);
  }

  @override
  List<JsonTest> getList() {
    return _jsonTests;
  }
}
