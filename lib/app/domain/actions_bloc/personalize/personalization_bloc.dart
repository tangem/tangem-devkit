import 'dart:async';
import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/personalization_values.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/repository/personalization_config_repository.dart';
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
  final bsPersonalConfigNames = BehaviorSubject<List<String>>();
  final bsDefaultConfigNames = BehaviorSubject<List<String>>();
  final statedFieldsVisibility = StatedBehaviorSubject<bool>(false);

  final Repository<List<PresetInfo>> _defaultConfigRepository = PersonalizationConfigAssetRepository(true);
  late PersonalizationConfigStorage _personalConfigStorage;

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

  PersonalizationBloc(this._personalConfigStorage) {
    logD(this, "new instance");
    _initSegments();
    updateConfigIntoTheSegments(_personalConfigStorage.getCurrent());
  }

  _initSegments() {
    final currentConfig = _personalConfigStorage.getCurrent();
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
    _restoreConfig(_personalConfigStorage.getDefault());
  }

  restoreConfig(String name) {
    _restoreConfig(getConfig(name));
  }

  PersonalizationConfig? getConfig(String name) {
    PersonalizationConfig? config = _personalConfigStorage.get(name);
    if (config != null) return config;

    final configList = _defaultConfigRepository.get();
    if (configList == null) return null;

    return configList.firstWhereOrNull((e) => e.name == name)?.config;
  }

  _restoreConfig(PersonalizationConfig? config) {
    if (config == null) return;

    final newCopyOfConfig = PersonalizationConfig.fromJson(json.decode(json.encode(config)));
    _personalConfigStorage.setCurrent(newCopyOfConfig);
    _personalConfigStorage.save();
    updateConfigIntoTheSegments(newCopyOfConfig);
  }

  saveConfig() {
    _personalConfigStorage.save();
  }

  fetchPersonalConfigNames() {
    List<String> listNames = _personalConfigStorage.names();
    bsPersonalConfigNames.add(listNames);
  }

  fetchDefaultConfigNames() {
    _defaultConfigRepository.init();
    _defaultConfigRepository.streamContent.listen((event) {
      final namesList = event.map((e) => e.name).toList();
      bsDefaultConfigNames.add(namesList);
    });
  }

  saveNewConfig(String name) {
    final copyOfCurrent = PersonalizationConfig.fromJson(_personalConfigStorage.getCurrent().toJson());
    _personalConfigStorage.add(name, copyOfCurrent);
    _personalConfigStorage.save();
  }

  deleteConfig(String name) {
    _personalConfigStorage.remove(name);
    _personalConfigStorage.save();
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
    _shareConfig(getConfig(name));
  }

  shareCurrentConfig() {
    _shareConfig(_personalConfigStorage.getCurrent());
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

  updateConfigIntoTheSegments(PersonalizationConfig? config) {
    if (config == null) return;

    _configSegments.forEach((element) => element.update(config));
  }

  @override
  invokeAction() async {
    final personalizationMap = Utils.createPersonalizationCommandConfig(_personalConfigStorage.getCurrent());
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
    _personalConfigStorage.save();
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
