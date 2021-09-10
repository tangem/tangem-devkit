import 'dart:async';
import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/personalization_values.dart';
import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../../typed_storage.dart';
import 'segments.dart';

class PersonalizationBloc extends ActionBloc<CardResponse> {
  final PersonalizationValues values = PersonalizationValues();
  final List<BaseSegment> _configSegments = [];
  final _scrollingState = PublishSubject<bool>();
  final bsSavedConfigNames = BehaviorSubject<List<String>>();
  final statedFieldsVisibility = StatedBehaviorSubject<bool>(false);

  late PersonalizationConfigStorage _storage;

  late CardSegment cardNumber;
  late CommonSegment common;
  late SigningMethodSegment signingMethod;
  late SignHashExPropSegment signHashExProperties;
  late TokenSegment token;
  late ProductMaskSegment productMask;
  late SettingsMaskSegment settingsMask;
  late SettingMaskProtocolEncryptionSegment settingMaskProtocolEncryption;
  late SettingsMaskNdefSegment settingsMaskNdef;
  late PinsSegmentSegment pins;

  Stream<bool> get scrollingStateStream => _scrollingState.stream;

  Sink<bool> get scrollingStateSink => _scrollingState.sink;

  PersonalizationBloc(this._storage) {
    logD(this, "new instance");
    _initSegments();
    _updateConfigIntoTheSegments(_storage.getCurrent());
  }

  _initSegments() {
    final currentConfig = _storage.getCurrent();
    cardNumber = CardSegment(this, currentConfig);
    common = CommonSegment(this, currentConfig);
    signingMethod = SigningMethodSegment(this, currentConfig);
    signHashExProperties = SignHashExPropSegment(this, currentConfig);
    token = TokenSegment(this, currentConfig);
    productMask = ProductMaskSegment(this, currentConfig);
    settingsMask = SettingsMaskSegment(this, currentConfig);
    settingMaskProtocolEncryption = SettingMaskProtocolEncryptionSegment(this, currentConfig);
    settingsMaskNdef = SettingsMaskNdefSegment(this, currentConfig);
    pins = PinsSegmentSegment(this, currentConfig);

    _configSegments.add(cardNumber);
    _configSegments.add(common);
    _configSegments.add(signingMethod);
    _configSegments.add(signHashExProperties);
    _configSegments.add(token);
    _configSegments.add(productMask);
    _configSegments.add(settingsMask);
    _configSegments.add(settingMaskProtocolEncryption);
    _configSegments.add(settingsMaskNdef);
    _configSegments.add(pins);
  }

  restoreDefaultConfig() {
    _restoreConfig(_storage.getDefault());
  }

  restoreConfig(String name) {
    _restoreConfig(_storage.get(name));
  }

  PersonalizationConfig? getConfig(String name) => _storage.get(name);

  _restoreConfig(PersonalizationConfig? config) {
    if (config == null) return;

    final newCopyOfConfig = PersonalizationConfig.fromJson(json.decode(json.encode(config)));
    _storage.setCurrent(newCopyOfConfig);
    _storage.save();
    _updateConfigIntoTheSegments(newCopyOfConfig);
  }

  saveConfig() {
    _storage.save();
  }

  fetchSavedConfigNames() {
    List<String> listNames = _storage.names();
    bsSavedConfigNames.add(listNames);
  }

  saveNewConfig(String name) {
    final copyOfCurrent = PersonalizationConfig.fromJson(_storage.getCurrent().toJson());
    _storage.add(name, copyOfCurrent);
    _storage.save();
  }

  deleteConfig(String name) {
    _storage.remove(name);
    _storage.save();
  }

  importConfig(String jsonConfig) {
    try {
      final cleanJson = jsonConfig.replaceAll("\n", "").replaceAll(String.fromCharCode(160), "");
      final configMap = json.decode(cleanJson);
      _restoreConfig(PersonalizationConfig.fromJson(configMap));
    } catch (ex) {
      sendSnackbarMessage(ex);
      _restoreConfig(PersonalizationConfig.getDefault());
    }
  }

  shareConfig(String name) {
    _shareConfig(_storage.get(name));
  }

  shareCurrentConfig() {
    _shareConfig(_storage.getCurrent());
  }

  _shareConfig(PersonalizationConfig? config) {
    if (config == null) {
      sendSnackbarMessage("Config not found");
      return;
    }

    try {
      final jsonConfig = json.encode(config);
      Share.share(jsonConfig);
    } catch (ex) {
      sendSnackbarMessage(ex);
    }
  }

  _updateConfigIntoTheSegments(PersonalizationConfig? config) {
    if (config == null) return;

    _configSegments.forEach((element) => element.update(config));
  }

  @override
  invokeAction() async {
    final personalizationMap = Utils.createPersonalizationCommandConfig(_storage.getCurrent());
    TangemSdk.personalize(callback, personalizationMap);
  }

  @override
  void createCommandData(Function(CommandDataModel) onSuccess, Function(String) onError) {
    throw UnimplementedError();
  }

  bool isDefaultConfigName(String name) => ConfigStorage.defaultKey == name;

  @override
  dispose() {
    statedFieldsVisibility.dispose();
    _configSegments.forEach((element) => element.dispose());
    _storage.save();
    super.dispose();
  }
}

class PersonalizationConfigStorage extends ConfigSharedPrefsStorage<PersonalizationConfig> {
  final String _spaceKey = "#@%";

  PersonalizationConfigStorage() : super("personalizationConfigStorage");

  @override
  PersonalizationConfig? get(String name) => super.get(_replaceSpaces(name));

  @override
  add(String name, PersonalizationConfig? config) {
    super.add(_replaceSpaces(name), config);
  }

  @override
  set(String name, PersonalizationConfig? config) {
    super.set(_replaceSpaces(name), config);
  }

  @override
  remove(String name) {
    super.remove(_replaceSpaces(name));
  }

  @override
  List<String> names() {
    return super.names().map((e) => _replaceKey(e)).toList();
  }

  String _replaceSpaces(String withSpaces) => withSpaces.replaceAll(" ", _spaceKey);

  String _replaceKey(String withKeys) => withKeys.replaceAll(_spaceKey, " ");

  @override
  PersonalizationConfig getDefaultValue() => PersonalizationConfig.getDefault();

  @override
  PersonalizationConfig convertFrom(Map<String, dynamic> jsonMap) {
    return PersonalizationConfig.fromJson(jsonMap);
  }
}
