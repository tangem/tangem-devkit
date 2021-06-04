import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:devkit/commons/global/shared_preferences.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prefs/prefs.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

abstract class TypedStorage<T> {
  final _bsIsReadyToUse = BehaviorSubject<bool>();
  final _psStorageModified = PublishSubject<StorageModifyEvent<T>>();
  bool _isChangeListenersActive = false;

  final Map<String, T> _storage = {};

  TypedStorage() {
    logD(this, "new instance");
    restore(() {
      _isChangeListenersActive = true;
      _bsIsReadyToUse.add(true);
    });
  }

  Stream<bool> get isReadyToUseStream => _bsIsReadyToUse.stream;

  Stream<StorageModifyEvent<T>> get onStorageModifiedStream => _psStorageModified.stream;

  restore(VoidCallback onComplete);

  save({String? name, VoidCallback? onComplete});

  bool has(String name) => _storage.containsKey(name);

  T? get(String name) => _storage[name];

  add(String name, T? value) {
    if (value == null) return;

    _storage[name] = value;
    _notifyAdd(value);
  }

  set(String name, T? value) {
    if (value == null) return;

    _storage[name] = value;
    _notifySet(value);
  }

  remove(String name) {
    final removedValue = _storage.remove(name);
    _notifyRemove(removedValue);
  }

  List<String> names() => _storage.keys.toList();

  List<T> values() => _storage.values.toList();

  int size() => _storage.length;

  _notifyAdd(T? value) {
    if (value != null && _isChangeListenersActive) _psStorageModified.add(StorageModifyEvent.add(value));
  }

  _notifySet(T? value) {
    if (value != null && _isChangeListenersActive) _psStorageModified.add(StorageModifyEvent.set(value));
  }

  _notifyRemove(T? value) {
    if (value != null && _isChangeListenersActive) _psStorageModified.add(StorageModifyEvent.remove(value));
  }
}

enum StorageModification { ADD, SET, REMOVE }

class StorageModifyEvent<T> {
  final T value;
  final StorageModification type;

  StorageModifyEvent(this.value, this.type);

  factory StorageModifyEvent.add(T value) => StorageModifyEvent(value, StorageModification.ADD);

  factory StorageModifyEvent.set(T value) => StorageModifyEvent(value, StorageModification.SET);

  factory StorageModifyEvent.remove(T value) => StorageModifyEvent(value, StorageModification.REMOVE);
}

abstract class ConfigStorage<T> extends TypedStorage<T> {
  static final String defaultKey = "default";

  final String _hidden = "hidden";
  final String _current = "hidden.current";

  @override
  restore(VoidCallback onComplete) {
    if (!hasDefault()) {
      final defaultValue = getDefaultValue();
      setDefault(defaultValue);
      setCurrent(defaultValue);
      save();
    }
    if (!hasCurrent()) {
      final defaultValue = getDefaultValue();
      setCurrent(defaultValue);
      save();
    }
    onComplete();
  }

  bool hasDefault() => has(defaultKey);

  bool hasCurrent() => has(_current);

  T getDefault() => get(defaultKey)!;

  T getCurrent() => get(_current) ?? getDefault();

  setDefault(T value) {
    set(defaultKey, value);
  }

  setCurrent(T value) {
    set(_current, value);
  }

  List<String> names() {
    return _storage.keys.toList().where((e) => !e.contains(_hidden)).toList();
  }

  T getDefaultValue();
}

abstract class MapToTypeConvertible<T> {
  T convertFrom(Map<String, dynamic> json);
}

abstract class ConfigSharedPrefsStorage<T> extends ConfigStorage<T> with MapToTypeConvertible<T> {
  final String _storageKey;
  final SharedPreferences _shPref = AppSharedPreferences.shPref;

  ConfigSharedPrefsStorage(this._storageKey) : super();

  @override
  restore(VoidCallback onComplete) {
    String? jsonString = _shPref.getString(_storageKey);
    if (jsonString == null) {
      super.restore(onComplete);
      return;
    }

    Map jsonMap = json.decode(jsonString);
    jsonMap.forEach((key, value) => _storage[key] = convertFrom(value));
    super.restore(onComplete);
  }

  @override
  save({String? name, VoidCallback? onComplete}) {
    if (name == null) {
      _shPref.setString(_storageKey, json.encode(_storage));
    } else {
      _storage[name]?.let((it) => _shPref.setString(name, json.encode(it)));
    }
    onComplete?.call();
  }
}

abstract class FileStorage<T> extends TypedStorage<T> with MapToTypeConvertible<T> {
  late Directory _appDocDir;
  final String _fileExtension = ".json";

  @override
  restore(VoidCallback onComplete) async {
    _appDocDir = await getApplicationDocumentsDirectory();
    final files = _appDocDir.listSync().map((e) => File(e.path));
    files.forEach((element) {
      if (extension(element.path) == _fileExtension) {
        final content = element.readAsStringSync();
        final fileName = basenameWithoutExtension(element.path);
        final value = json.decode(content);
        _storage[fileName] = convertFrom(value);
      }
    });
    onComplete();
  }

  @override
  add(String name, T? value) {
    _saveToFile(name, value);
    super.add(name, value);
  }

  @override
  set(String name, T? value) {
    _saveToFile(name, value);
    super.set(name, value);
  }

  @override
  remove(String name) {
    final file = File(_assembleFilePath(name));
    if (file.existsSync()) file.deleteSync();
    super.remove(name);
  }

  @Deprecated("All modification triggers files modification by default")
  @override
  save({String? name, VoidCallback? onComplete}) {
    if (name == null) {
      _storage.forEach((key, value) => _saveToFile(key, value));
    } else {
      _storage[name]?.let((it) => _saveToFile(name, it));
    }
    onComplete?.call();
  }

  _saveToFile(String key, T? value) {
    if (value == null) return;

    final file = File(_assembleFilePath(key));
    final encodedContent = json.encode(value);
    file.writeAsStringSync(encodedContent);
  }

  String _assembleFilePath(String key) => join(_appDocDir.path, key) + _fileExtension;
}
