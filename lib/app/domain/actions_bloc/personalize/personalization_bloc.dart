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

import 'segments.dart';
import 'store.dart';

class PersonalizationBloc extends ActionBloc<CardResponse> {
  final PersonalizationValues values = PersonalizationValues();
  final List<BaseSegment> _configSegments = [];
  final _scrollingState = PublishSubject<bool>();
  final bsSavedConfigNames = BehaviorSubject<List<String>>();
  final statedFieldsVisibility = StatedBehaviorSubject<bool>(false);

  PersonalizationConfigStore _store;

  CardNumberSegment cardNumber;
  CommonSegment common;
  SigningMethodSegment signingMethod;
  SignHashExPropSegment signHashExProperties;
  TokenSegment token;
  ProductMaskSegment productMask;
  SettingsMaskSegment settingsMask;
  SettingMaskProtocolEncryptionSegment settingMaskProtocolEncryption;
  SettingsMaskNdefSegment settingsMaskNdef;
  PinsSegmentSegment pins;

  Stream<bool> get scrollingStateStream => _scrollingState.stream;

  Sink<bool> get scrollingStateSink => _scrollingState.sink;

  PersonalizationBloc() {
    logD(this, "new instance");
    _store = PersonalizationConfigStore(_getDefaultConfig);
    _store.load();
    _initSegments();
    _updateConfigIntoTheSegments(_store.getCurrent());
  }

  _initSegments() {
    final currentConfig = _store.getCurrent();

    cardNumber = CardNumberSegment(this, currentConfig);
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
    _restoreConfig(_store.getDefault());
  }

  restoreConfig(String name) {
    _restoreConfig(_store.get(name));
  }

  _restoreConfig(PersonalizationConfig config) {
    if (config == null) return;

    final newCopyOfConfig = PersonalizationConfig.fromJson(json.decode(json.encode(config)));
    _store.setCurrent(newCopyOfConfig);
    _store.save();
    _updateConfigIntoTheSegments(newCopyOfConfig);
  }

  saveConfig() {
    _store.save();
  }

  fetchSavedConfigNames() {
    List<String> listNames = _store.getNames();
    bsSavedConfigNames.add(listNames);
  }

  saveNewConfig(String name) {
    _store.set(name, _store.getCurrent());
    _store.save();
  }

  deleteConfig(String name) {
    _store.remove(name);
    _store.save();
  }

  importConfig(String jsonConfig) {
    try {
      final configMap = json.decode(jsonConfig);
      _restoreConfig(PersonalizationConfig.fromJson(configMap));
    } catch (ex) {
      sendSnackbarMessage(ex);
    }
  }

  exportCurrentConfig() {
    try {
      final jsonConfig = json.encode(_store.getCurrent());
      Share.share(jsonConfig);
    } catch (ex) {
      sendSnackbarMessage(ex);
    }
  }

  _updateConfigIntoTheSegments(PersonalizationConfig config) {
    _configSegments.forEach((element) => element.update(config));
  }

  PersonalizationConfig _getDefaultConfig() => PersonalizationConfig.getDefault();

  @override
  invokeAction() {
    final issuer = Issuer.def();
    final acquirer = Acquirer.def();
    final manufacturer = Manufacturer.def();

    TangemSdk.personalize(callback, {
      TangemSdk.cardConfig: json.encode(Utils.createCardConfig(_store.getCurrent(), issuer, acquirer)),
      TangemSdk.issuer: json.encode(issuer),
      TangemSdk.acquirer: json.encode(acquirer),
      TangemSdk.manufacturer: json.encode(manufacturer),
    });
  }

  bool isDefaultConfigName(String name) => StoreObject.defaultKey == name;

  @override
  dispose() {
    statedFieldsVisibility.dispose();
    _configSegments.forEach((element) => element.dispose());
    _store.save();
    super.dispose();
  }
}
