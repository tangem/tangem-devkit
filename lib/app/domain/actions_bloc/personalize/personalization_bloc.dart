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

class Issuer {
  static final String dataPublic =
      "045f16bd1d2eafe463e62a335a09e6b2bbcbd04452526885cb679fc4d27af1bd22f553c7deefb54fd3d4f361d14e6dc3f11b7d4ea183250a60720ebdf9e110cd26";
  static final String dataPrivate = "11121314151617184771ED81F2BACF57479E4735EB1405083927372D40DA9E92";

  static final String transPublic =
      "0484c5192e9bfa6c528a344f442137a92b89ea835bfef1d04cb4362eb906b508c5889846cfea71ba6dc7b3120c2208df9c46127d3d85cb5cfbd1479e97133a39d8";
  static final String transPrivate = "11121314151617184771ED81F2BACF57479E4735EB1405081918171615141312";

  final String name;
  final String id;
  final KeyPairHex dataKeyPair;
  final KeyPairHex transactionKeyPair;

  Issuer(this.name, this.id, this.dataKeyPair, this.transactionKeyPair);

  factory Issuer.def() {
    final name = "TANGEM SDK";
    return Issuer(
      name,
      name + "\u0000",
      KeyPairHex(dataPublic, dataPrivate),
      KeyPairHex(transPublic, transPrivate),
    );
  }

  factory Issuer.fromJson(Map<String, dynamic> json) {
    return Issuer(
      json["name"],
      json["id"],
      KeyPairHex.fromJson(json["dataKeyPair"]),
      KeyPairHex.fromJson(json["transactionKeyPair"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "id": id, "dataKeyPair": dataKeyPair.toJson(), "transactionKeyPair": transactionKeyPair.toJson()};
  }
}

class Acquirer {
  static final publicKey =
      "0456ad1a82b22bcb40c38fd08939f87e6b80e40dec5b3bdb351c55fcd709e47f9fb2ed00c2304d3a986f79c5ae0ac3c84e88da46dc8f513b7542c716af8c9a2daf";
  static final privateKey = "21222324252627284771ED81F2BACF57479E4735EB1405083927372D40DA9E92";

  final String name;
  final String id;
  final KeyPairHex keyPair;

  Acquirer(this.name, this.id, this.keyPair);

  factory Acquirer.def() {
    final name = "Smart Cash";
    return Acquirer(
      name,
      name + "\u0000",
      KeyPairHex(publicKey, privateKey),
    );
  }

  factory Acquirer.fromJson(Map<String, dynamic> json) {
    return Acquirer(json["name"], json["id"], KeyPairHex.fromJson(json["keyPair"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "keyPair": keyPair.toJson(),
    };
  }
}

class Manufacturer {
  static final publicKey =
      "04bab86d56298c996f564a84fc88e28aed38184b12f07e519113bef48c76f3df3adc303599b08ac05b55ec3df98d9338573a6242f76f5d28f4f0f364e87e8fca2f";
  static final privateKey = "1b48cfd24bbb5b394771ed81f2bacf57479e4735eb1405083927372d40da9e92";

  final String name;
  final KeyPairHex keyPair;

  Manufacturer(this.name, this.keyPair);

  factory Manufacturer.def() => Manufacturer("Tangem", KeyPairHex(publicKey, privateKey));

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      json["name"],
      KeyPairHex.fromJson(json["keyPair"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "keyPair": keyPair.toJson(),
    };
  }
}

class KeyPairHex {
  final String publicKey;
  final String privateKey;

  KeyPairHex(this.publicKey, this.privateKey);

  factory KeyPairHex.fromJson(Map<String, dynamic> json) {
    return KeyPairHex(
      json["publicKey"],
      json["privateKey"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "publicKey": publicKey,
      "privateKey": privateKey,
    };
  }
}