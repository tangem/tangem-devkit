import 'dart:convert';

import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/commons/global/shared_preferences.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:prefs/prefs.dart';

typedef DefaultConfigGetter = PersonalizationConfig Function();

class PersonalizationConfigStore {
  static final SP_PERSONALIZATION_KEY = "personalizationJsonStore";

  final String spaceKey = "#@%";

  SharedPreferences shPref = AppSharedPreferences.shPref;
  StoreObject storeObject = StoreObject();
  DefaultConfigGetter _defaultConfigGetter;

  PersonalizationConfigStore(DefaultConfigGetter defaultConfigGetter) {
    logD(this, "new instance");
    _defaultConfigGetter = defaultConfigGetter;
  }

  load() {
    String jsonString = shPref.getString(SP_PERSONALIZATION_KEY);
    storeObject.fromJsonString(jsonString);
    if (!storeObject.hasDefault()) {
      final defConfig = _defaultConfigGetter();
      storeObject.setDefault(defConfig);
      storeObject.setCurrent(defConfig);
      save();
    }
    if (!storeObject.hasCurrent()) {
      storeObject.setCurrent(_defaultConfigGetter());
      save();
    }
  }

  save() {
    final jsonString = storeObject.toJsonString();
    shPref.setString(SP_PERSONALIZATION_KEY, jsonString);
  }

  PersonalizationConfig get(String name) => storeObject.get(_replaceSpaces(name));

  PersonalizationConfig getCurrent() => storeObject.getCurrent();

  PersonalizationConfig getDefault() => storeObject.getDefault();

  set(String name, PersonalizationConfig config) {
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
    return storeObject.keys().map((e) => _replaceKey(e)).where((element) => !element.contains(StoreObject.hidden)).toList();
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

  PersonalizationConfig get(String key) => _store[key];

  PersonalizationConfig getDefault() => get(defaultKey);

  PersonalizationConfig getCurrent() => get(current);

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

  fromJsonString(String jsonString) {
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
