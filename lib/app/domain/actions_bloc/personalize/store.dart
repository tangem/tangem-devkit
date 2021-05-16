import 'dart:convert';

import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/commons/global/shared_preferences.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:prefs/prefs.dart';

typedef DefaultConfigGetter = PersonalizationConfig Function();

class PersonalizationConfigStore {
  static final SP_PERSONALIZATION_KEY = "personalizationJsonStore";

  final String spaceKey = "#@%";

  final SharedPreferences shPref = AppSharedPreferences.shPref;
  final StoreObject storeObject = StoreObject();

  PersonalizationConfigStore(DefaultConfigGetter defaultConfigGetter) {
    logD(this, "new instance");

    final defConfig = defaultConfigGetter();
    String? jsonString = shPref.getString(SP_PERSONALIZATION_KEY);
    storeObject.fromJsonString(jsonString);
    if (!storeObject.hasDefault()) {
      storeObject.setDefault(defConfig);
      storeObject.setCurrent(defConfig);
      save();
    }
    if (!storeObject.hasCurrent()) {
      storeObject.setCurrent(defConfig);
      save();
    }
  }

  save() {
    final jsonString = storeObject.toJsonString();
    shPref.setString(SP_PERSONALIZATION_KEY, jsonString);
  }

  PersonalizationConfig? get(String name) => storeObject.get(_replaceSpaces(name));

  PersonalizationConfig getCurrent() => storeObject.getCurrent();

  PersonalizationConfig? getDefault() => storeObject.getDefault();

  set(String name, PersonalizationConfig? config) {
    if (config == null) return;
    storeObject.set(_replaceSpaces(name), config);
  }

  setCurrent(PersonalizationConfig config) {
    storeObject.setCurrent(config);
  }

  remove(String name) {
    storeObject.remove(_replaceSpaces(name));
  }

  String _replaceSpaces(String withSpaces) => withSpaces.replaceAll(" ", spaceKey);

  String _replaceKey(String withKeys) => withKeys.replaceAll(spaceKey, " ");

  List<String> getNames() {
    return storeObject
        .keys()
        .map((e) => _replaceKey(e))
        .where((element) => !element.contains(StoreObject.hidden))
        .toList();
  }
}

class StoreObject {
  static final String hidden = "hidden";
  static final String defaultKey = "default";
  final String current = "$hidden.current";

  Map<String, PersonalizationConfig> _store = {};

  int get length => _store.length;

  List<String> keys() => _store.keys.toList();

  bool has(String key) => _store.containsKey(key);

  bool hasDefault() => has(defaultKey);

  bool hasCurrent() => has(current);

  PersonalizationConfig? get(String key) => _store[key];

  PersonalizationConfig getDefault() => get(defaultKey)!;

  PersonalizationConfig getCurrent() => get(current) ?? getDefault();

  set(String key, PersonalizationConfig config) {
    _store[key] = config;
  }

  setDefault(PersonalizationConfig config) {
    set(defaultKey, config);
  }

  setCurrent(PersonalizationConfig config) {
    set(current, config);
  }

  remove(String replaceSpaces) {
    _store.remove(replaceSpaces);
  }

  fromJsonString(String? jsonString) {
    if (jsonString == null) return;

    Map map = json.decode(jsonString);
    map.forEach((key, value) {
      _store[key] = PersonalizationConfig.fromJson(value);
    });
  }

  String toJsonString() {
    return json.encode(_store);
  }
}
