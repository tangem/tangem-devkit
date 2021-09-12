import 'dart:convert';

import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

abstract class Repository<T> implements Disposable {
  final _bsContent = BehaviorSubject<T>();
  final bool lazyInit;

  T? _content;
  bool _alreadyInitialized = false;

  Repository({this.lazyInit = false}) {
    if (!lazyInit) init();
    _bsContent.listen((value) {
      _alreadyInitialized = true;
      _content = value;
    });
  }

  void init();

  bool isInitialized() => _alreadyInitialized;

  Stream<T> get streamContent => _bsContent.stream;

  T? get() => _content;

  @override
  dispose() {
    _bsContent.close();
  }
}

class PersonalizationConfigAssetRepository extends Repository<List<PresetInfo>> {

  PersonalizationConfigAssetRepository(bool isLazy) : super(lazyInit: isLazy);

  @override
  void init() async {
    if (_alreadyInitialized) return;

    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final testPaths = manifestMap.keys
        .where((String key) => key.contains('json/personalization/'))
        .where((String key) => key.contains('.json'))
        .toList();

    int inconvertibleCount = 0;
    final configList = <PresetInfo>[];
    testPaths.forEach((element) {
      rootBundle.loadString(element).then((value) {
        try {
          final map = jsonDecode(value);
          final name = basenameWithoutExtension(element);
          configList.add(PresetInfo(name, PersonalizationConfig.fromJson(map), false));
        } catch (ex) {
          inconvertibleCount++;
        }
        if (testPaths.length - inconvertibleCount == configList.length) _bsContent.add(configList);
      });
    });
  }
}

class PresetInfo {
  final String name;
  final PersonalizationConfig? config;
  final bool isPersonal;

  PresetInfo(this.name, this.config, this.isPersonal);
}
