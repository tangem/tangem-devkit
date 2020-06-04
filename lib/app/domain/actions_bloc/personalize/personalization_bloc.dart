import 'package:devkit/app/domain/actions_bloc/personalize/personalization_values.dart';
import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'segments.dart';
import 'store.dart';

abstract class PersonalizationState {}

class Loading extends PersonalizationState {}

class Done extends PersonalizationState {}

class ShowLoadConfig extends PersonalizationState {}

class PersonalizationBloc {
  final PersonalizationValues values = PersonalizationValues();
  final List<BaseSegment> _configSegments = [];
  final _scrollingState = PublishSubject<bool>();

  PublishSubject<List<String>> psSavedConfigNames = PublishSubject();

  PersonalizationConfigStore _store;

  CardNumberSegment cardNumber;
  CommonSegment common;
  SigningMethodSegment signingMethod;
  SignHashExPropertiesSegment signHashExProperties;
  TokenSegment token;
  ProductMaskSegment productMask;
  SettingsMaskSegment settingsMask;
  SettingMaskProtocolEncryptionSegment settingMaskProtocolEncryption;
  SettingsMaskNdefSegment settingsMaskNdef;
  PinsSegmentSegment pins;

  PublishSubject _successResponse = PublishSubject<Card>();
  PublishSubject _errorResponse = PublishSubject<ErrorResponse>();

  Stream<Card> get successResponseStream => _successResponse.stream;

  Stream<ErrorResponse> get errorResponseStream => _errorResponse.stream;

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
    signHashExProperties = SignHashExPropertiesSegment(this, currentConfig);
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

  resetToDefaultConfig() {
    _store.setCurrent(_store.getDefault());
    _store.save();
    _updateConfigIntoTheSegments(_store.getCurrent());
  }

  saveConfig() {
    _store.save();
  }

  fetchSavedConfigNames() {
    List<String> listNames = _store.getNames();
    psSavedConfigNames.add(listNames);
  }

  saveNewConfig(String name) {
    _store.set(name, _store.getCurrent());
    _store.save();
  }

  deleteConfig(String name) {
    _store.remove(name);
    _store.save();
  }

  _updateConfigIntoTheSegments(PersonalizationConfig config) {
    _configSegments.forEach((element) => element.update(config));
  }

  PersonalizationConfig _getDefaultConfig() => PersonalizationConfig.getDefault();

  personalize() {
    final issuer = Issuer.def();
    final acquirer = Acquirer.def();
    final manufacturer = Manufacturer.def();

    final callback = Callback((result) {
      _successResponse.add(result);
    }, (error) {
      _errorResponse.add(error);
    });

    TangemSdk.personalize(callback, {
      TangemSdk.cardConfig: Utils.createCardConfig(_store.getCurrent(), issuer, acquirer),
      TangemSdk.issuer: issuer,
      TangemSdk.acquirer: acquirer,
      TangemSdk.manufacturer: manufacturer,
    });
  }

  dispose() {
    _configSegments.forEach((element) => element.dispose());
    _store.save();
  }
}
