import 'package:devkit/app/domain/actions_bloc/personalize/personalization_values.dart';
import 'package:devkit/app/domain/model/personalization/peresonalization.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/src/widgets/scroll_notification.dart';
import 'package:rxdart/rxdart.dart';

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
  //SignHashExProp
  //Token
  ProductMask productMask;
  SettingsMask settingsMask;
  SettingMaskProtocolEncryption settingMaskProtocolEncryption;
  SettingsMaskNdef settingsMaskNdef;
  PinsSegment pins;

  Stream<bool> get scrollingStateStream => _scrollingState.stream;

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
    //SignHashExProp
    //Token
    productMask = ProductMask(this, currentConfig);
    settingsMask = SettingsMask(this, currentConfig);
    settingMaskProtocolEncryption = SettingMaskProtocolEncryption(this, currentConfig);
    settingsMaskNdef = SettingsMaskNdef(this, currentConfig);
    pins = PinsSegment(this, currentConfig);

    _configSegments.add(cardNumber);
    _configSegments.add(common);
    _configSegments.add(signingMethod);
    //SignHashExProp
    //Token
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

  dispose() {
    _configSegments.forEach((element) => element.dispose());
    _store.save();
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      _scrollingState.add(true);
    } else if (notification is ScrollEndNotification) {
      _scrollingState.add(false);
    }
    return false;
  }
}
