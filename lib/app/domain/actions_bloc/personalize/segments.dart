import 'dart:async';

import 'package:devkit/app/domain/model/personalization/signing_method_mask.dart';
import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/model/sdk.dart';

import 'personalization_bloc.dart';
import 'personalization_values.dart';

abstract class BaseSegment {
  final PersonalizationBloc _bloc;
  final List<StreamSubscription> _subscriptions = [];

  PersonalizationConfig _config;

  BaseSegment(this._bloc, this._config) {
    _initSubscriptions();
  }

  update(PersonalizationConfig config) {
    this._config = config;
    _configWasUpdated();
  }

  bool isCustom(Pair pair) => pair.a == PersonalizationValues.CUSTOM && pair.b == PersonalizationValues.CUSTOM;

  dispose() {
    _subscriptions.forEach((element) => element.cancel());
  }

  _initSubscriptions();

  _configWasUpdated();
}

class CardNumberSegment extends BaseSegment {
  final bsSeries = BehaviorSubject<String>();
  final bsNumber = BehaviorSubject<String>();
  final bsBatchId = BehaviorSubject<String>();

  CardNumberSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _initSubscriptions() {
    _subscriptions.add(bsSeries.listen((value) => _config.series = value));
    _subscriptions.add(bsNumber.listen((value) => _config.startNumber = int.parse(value)));
    _subscriptions.add(bsBatchId.listen((value) => _config.cardData.batch = value));
  }

  @override
  _configWasUpdated() {
    bsSeries.add(_config.series);
    bsNumber.add(_config.startNumber.toString());
    bsBatchId.add(_config.cardData.batch);
  }
}

class CommonSegment extends BaseSegment {
  final bsBlockchain = BehaviorSubject<Pair<String, String>>();
  final bsCustomBlockchain = BehaviorSubject<String>();
  final bsCurve = BehaviorSubject<Pair<String, String>>();
  final bsMaxSignatures = BehaviorSubject<String>();
  final bsCreateWallet = BehaviorSubject<bool>();
  final bsWalletsCount = BehaviorSubject<String>();
  final bsPauseBeforePin = BehaviorSubject<Pair<String, int>>();

  CommonSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _initSubscriptions() {
    _subscriptions.add(bsBlockchain.listen(_listenBlockchain));
    _subscriptions.add(bsCustomBlockchain.listen(_listenCustomBlockchain));
    _subscriptions.add(bsCurve.listen((value) => _config.curveID = value.b));
    _subscriptions.add(bsMaxSignatures.listen((value) => _config.MaxSignatures = value.isEmpty ? 0 : int.parse(value)));
    _subscriptions.add(bsCreateWallet.listen((value) => _config.createWallet = value ? 1 : 0));
    _subscriptions.add(bsWalletsCount.listen((value) => _config.walletsCount = int.tryParse(value) ?? 1));
    _subscriptions.add(bsPauseBeforePin.listen((value) => _config.pauseBeforePIN2 = value.b));

    bsWalletsCount.add("1");
  }

  _listenBlockchain(Pair<String, String> value) {
    if (isCustom(value)) return;

    _config.cardData.blockchain = value.b;
    bsCustomBlockchain.add("");
  }

  _listenCustomBlockchain(String value) {
    if (value.isEmpty || value == _config.cardData.blockchain) return;

    _config.cardData.blockchain = value;
    bsBlockchain.add(_bloc.values.getCustom());
  }

  @override
  _configWasUpdated() {
    final blockchainName = _config.cardData.blockchain;
    final blockchain = _bloc.values.getBlockchain(blockchainName);
    if (blockchain == null) {
      bsBlockchain.add(_bloc.values.getCustom());
      bsCustomBlockchain.add(blockchainName);
    } else {
      bsBlockchain.add(blockchain);
    }

    bsCurve.add(_bloc.values.getCurve(_config.curveID) ?? _bloc.values.curves[0]);
    bsCreateWallet.add(_config.createWallet == 1);
    bsPauseBeforePin.add(_bloc.values.getPauseBeforePin(_config.pauseBeforePIN2) ?? _bloc.values.pauseBeforePin[0]);
    bsMaxSignatures.add(_config.MaxSignatures.toString());
  }
}

class SigningMethodSegment extends BaseSegment {
  final bsTxHashes = BehaviorSubject<bool>();
  final bsRawTx = BehaviorSubject<bool>();
  final bsValidatedTxHashes = BehaviorSubject<bool>();
  final bsValidatedRawTx = BehaviorSubject<bool>();
  final bsValidatedTxHashesWithIssuerData = BehaviorSubject<bool>();
  final bsValidatedRawTxWithIssuerData = BehaviorSubject<bool>();
  final bsExternalHash = BehaviorSubject<bool>();

  final maskBuilder = SigningMethodMaskBuilder();

  SigningMethodSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    final method = _config.SigningMethod;
    bsTxHashes.add(SigningMethodMaskBuilder.maskContainsMethod(method, 0));
    bsRawTx.add(SigningMethodMaskBuilder.maskContainsMethod(method, 1));
    bsValidatedTxHashes.add(SigningMethodMaskBuilder.maskContainsMethod(method, 2));
    bsValidatedRawTx.add(SigningMethodMaskBuilder.maskContainsMethod(method, 3));
    bsValidatedTxHashesWithIssuerData.add(SigningMethodMaskBuilder.maskContainsMethod(method, 4));
    bsValidatedRawTxWithIssuerData.add(SigningMethodMaskBuilder.maskContainsMethod(method, 5));
    bsExternalHash.add(SigningMethodMaskBuilder.maskContainsMethod(method, 6));
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(bsTxHashes.listen((isChecked) {
      _handleMethodChanges(isChecked, 0);
    }));
    _subscriptions.add(bsRawTx.listen((isChecked) {
      _handleMethodChanges(isChecked, 1);
    }));
    _subscriptions.add(bsValidatedTxHashes.listen((isChecked) {
      _handleMethodChanges(isChecked, 2);
    }));
    _subscriptions.add(bsValidatedRawTx.listen((isChecked) {
      _handleMethodChanges(isChecked, 3);
    }));
    _subscriptions.add(bsValidatedTxHashesWithIssuerData.listen((isChecked) {
      _handleMethodChanges(isChecked, 4);
    }));
    _subscriptions.add(bsValidatedRawTxWithIssuerData.listen((isChecked) {
      _handleMethodChanges(isChecked, 5);
    }));
    _subscriptions.add(bsExternalHash.listen((isChecked) {
      _handleMethodChanges(isChecked, 6);
    }));
  }

  _handleMethodChanges(bool isChecked, int method) {
    if (isChecked)
      maskBuilder.addMethod(method);
    else
      maskBuilder.removeMethod(method);
    _config.SigningMethod = maskBuilder.build();
  }
}

class SignHashExPropSegment extends BaseSegment {
  final pinLessFloorLimit = BehaviorSubject<String>();
  final hexCrExKey = BehaviorSubject<String>();
  final requireTerminalCertSignature = BehaviorSubject<bool>();
  final requireTerminalTxSignature = BehaviorSubject<bool>();
  final checkPIN3OnCard = BehaviorSubject<bool>();

  SignHashExPropSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    pinLessFloorLimit.add("100000");
    hexCrExKey.add(_config.hexCrExKey);
    requireTerminalCertSignature.add(_config.requireTerminalCertSignature);
    requireTerminalTxSignature.add(_config.requireTerminalTxSignature);
    checkPIN3OnCard.add(_config.checkPIN3OnCard);
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(pinLessFloorLimit.listen((value) => logE(this, "Attribute not implemented in the personalization JSON")));
    _subscriptions.add(hexCrExKey.listen((value) => _config.hexCrExKey = value));
    _subscriptions.add(requireTerminalCertSignature.listen((value) => _config.requireTerminalCertSignature = value));
    _subscriptions.add(requireTerminalTxSignature.listen((value) => _config.requireTerminalTxSignature = value));
    _subscriptions.add(checkPIN3OnCard.listen((value) => _config.checkPIN3OnCard = value));
  }
}

class TokenSegment extends BaseSegment {
  final itsToken = BehaviorSubject<bool>();
  final tokenSymbol = BehaviorSubject<String>();
  final tokenContractAddress = BehaviorSubject<String>();
  final tokenDecimal = BehaviorSubject<String>();

  TokenSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    itsToken.add(_itsToken());
    tokenSymbol.add(stringOf(_config.cardData.tokenSymbol));
    tokenContractAddress.add(stringOf(_config.cardData.tokenContractAddress));
    tokenDecimal.add(stringOf(_config.cardData.tokenDecimal));
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(itsToken.listen((value) {
      if (!value) {
        tokenSymbol.add("");
        tokenContractAddress.add("");
        tokenDecimal.add("");
      }
    }));
    _subscriptions.add(tokenSymbol.listen((value) {
      final symbol = value.isEmpty ? null : value;
      if (_config.cardData.tokenSymbol == symbol) return;

      _config.cardData.tokenSymbol = symbol;
      itsToken.add(_itsToken());
    }));
    _subscriptions.add(tokenContractAddress.listen((value) {
      final address = value.isEmpty ? null : value;
      if (_config.cardData.tokenContractAddress == address) return;

      _config.cardData.tokenContractAddress = address;
      itsToken.add(_itsToken());
    }));
    _subscriptions.add(tokenDecimal.listen((value) {
      final decimal = value.isEmpty ? null : int.parse(value);
      if (_config.cardData.tokenDecimal == decimal) return;

      _config.cardData.tokenDecimal = decimal;
      itsToken.add(_itsToken());
    }));
  }

  bool _itsToken() {
    final symbol = stringOf(_config.cardData.tokenSymbol);
    final address = stringOf(_config.cardData.tokenContractAddress);
    final decimal = stringOf(_config.cardData.tokenDecimal);
    return symbol.isNotEmpty || address.isNotEmpty || decimal.isNotEmpty;
  }
}

class ProductMaskSegment extends BaseSegment {
  final note = BehaviorSubject<bool>();
  final tag = BehaviorSubject<bool>();
  final idCard = BehaviorSubject<bool>();
  final idIssuer = BehaviorSubject<bool>();
  final twinCard = BehaviorSubject<bool>();

  ProductMaskSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    note.add(_config.cardData.productNote);
    tag.add(_config.cardData.productTag);
    idCard.add(_config.cardData.productIdCard);
    idIssuer.add(_config.cardData.productIdIssuer);
    twinCard.add(_config.cardData.productTwinCard);
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(note.listen((isChecked) => _config.cardData.productNote = isChecked));
    _subscriptions.add(tag.listen((isChecked) => _config.cardData.productTag = isChecked));
    _subscriptions.add(idCard.listen((isChecked) => _config.cardData.productIdCard = isChecked));
    _subscriptions.add(idIssuer.listen((isChecked) => _config.cardData.productIdIssuer = isChecked));
    _subscriptions.add(twinCard.listen((isChecked) => _config.cardData.productTwinCard = isChecked));
  }
}

class SettingsMaskSegment extends BaseSegment {
  final isReusable = BehaviorSubject<bool>();
  final useActivation = BehaviorSubject<bool>();
  final prohibitPurgeWallet = BehaviorSubject<bool>();
  final allowSelectBlockchain = BehaviorSubject<bool>();
  final useBlock = BehaviorSubject<bool>();
  final useOneCommandAtTime = BehaviorSubject<bool>();
  final useCvc = BehaviorSubject<bool>();
  final allowSetPIN1 = BehaviorSubject<bool>();
  final allowSetPIN2 = BehaviorSubject<bool>();
  final prohibitDefaultPIN1 = BehaviorSubject<bool>();
  final smartSecurityDelay = BehaviorSubject<bool>();
  final protectIssuerDataAgainstReplay = BehaviorSubject<bool>();
  final skipSecurityDelayIfValidatedByIssuer = BehaviorSubject<bool>();
  final skipCheckPIN2CVCIfValidatedByIssuer = BehaviorSubject<bool>();
  final skipSecurityDelayIfValidatedByLinkedTerminal = BehaviorSubject<bool>();
  final restrictOverwriteIssuerExtraData = BehaviorSubject<bool>();

  SettingsMaskSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    isReusable.add(_config.isReusable);
    useActivation.add(_config.useActivation);
    prohibitPurgeWallet.add(_config.prohibitPurgeWallet);
    allowSelectBlockchain.add(_config.allowSelectBlockchain);
    useBlock.add(_config.useBlock);
    useOneCommandAtTime.add(_config.useOneCommandAtTime);
    useCvc.add(_config.useCvc);
    allowSetPIN1.add(_config.allowSetPIN1);
    allowSetPIN2.add(_config.allowSetPIN2);
    prohibitDefaultPIN1.add(_config.prohibitDefaultPIN1);
    smartSecurityDelay.add(_config.smartSecurityDelay);
    protectIssuerDataAgainstReplay.add(_config.protectIssuerDataAgainstReplay);
    skipSecurityDelayIfValidatedByIssuer.add(_config.skipSecurityDelayIfValidatedByIssuer);
    skipCheckPIN2CVCIfValidatedByIssuer.add(_config.skipCheckPIN2CVCIfValidatedByIssuer);
    skipSecurityDelayIfValidatedByLinkedTerminal.add(_config.skipSecurityDelayIfValidatedByLinkedTerminal);
    restrictOverwriteIssuerExtraData.add(_config.restrictOverwriteIssuerExtraData);
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(isReusable.listen((isChecked) => _config.isReusable = isChecked));
    _subscriptions.add(useActivation.listen((isChecked) => _config.useActivation = isChecked));
    _subscriptions.add(prohibitPurgeWallet.listen((isChecked) => _config.prohibitPurgeWallet = isChecked));
    _subscriptions.add(allowSelectBlockchain.listen((isChecked) => _config.allowSelectBlockchain = isChecked));
    _subscriptions.add(useBlock.listen((isChecked) => _config.useBlock = isChecked));
    _subscriptions.add(useOneCommandAtTime.listen((isChecked) => _config.useOneCommandAtTime = isChecked));
    _subscriptions.add(useCvc.listen((isChecked) => _config.useCvc = isChecked));
    _subscriptions.add(allowSetPIN1.listen((isChecked) => _config.allowSetPIN1 = isChecked));
    _subscriptions.add(allowSetPIN2.listen((isChecked) => _config.allowSetPIN2 = isChecked));
    _subscriptions.add(prohibitDefaultPIN1.listen((isChecked) => _config.prohibitDefaultPIN1 = isChecked));
    _subscriptions.add(smartSecurityDelay.listen((isChecked) => _config.smartSecurityDelay = isChecked));
    _subscriptions.add(protectIssuerDataAgainstReplay.listen((isChecked) => _config.protectIssuerDataAgainstReplay = isChecked));
    _subscriptions.add(skipSecurityDelayIfValidatedByIssuer.listen((isChecked) => _config.skipSecurityDelayIfValidatedByIssuer = isChecked));
    _subscriptions.add(skipCheckPIN2CVCIfValidatedByIssuer.listen((isChecked) => _config.skipCheckPIN2CVCIfValidatedByIssuer = isChecked));
    _subscriptions
        .add(skipSecurityDelayIfValidatedByLinkedTerminal.listen((isChecked) => _config.skipSecurityDelayIfValidatedByLinkedTerminal = isChecked));
    _subscriptions.add(restrictOverwriteIssuerExtraData.listen((isChecked) => _config.restrictOverwriteIssuerExtraData =
        isChecked));
  }
}

class SettingMaskProtocolEncryptionSegment extends BaseSegment {
  final allowUnencrypted = BehaviorSubject<bool>();
  final allowFastEncryption = BehaviorSubject<bool>();

  SettingMaskProtocolEncryptionSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    allowUnencrypted.add(_config.allowUnencrypted);
    allowFastEncryption.add(_config.allowFastEncryption);
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(allowUnencrypted.listen((isChecked) => _config.allowUnencrypted = isChecked));
    _subscriptions.add(allowFastEncryption.listen((isChecked) => _config.allowFastEncryption = isChecked));
  }
}

class SettingsMaskNdefSegment extends BaseSegment {
  final useNDEF = BehaviorSubject<bool>();
  final useDynamicNDEF = BehaviorSubject<bool>();
  final disablePrecomputedNDEF = BehaviorSubject<bool>();
  final aar = BehaviorSubject<Pair<String, String>>();
  final customAar = BehaviorSubject<String>();
  final uri = BehaviorSubject<String>();

  final typeAar = "AAR";
  final typeUri = "URI";

  SettingsMaskNdefSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    useNDEF.add(_config.useNDEF);
    useDynamicNDEF.add(_config.useDynamicNDEF);
    disablePrecomputedNDEF.add(_config.disablePrecomputedNDEF);
    _updateNdefRecords();
  }

  _updateNdefRecords() {
    NdefRecordSdk findNdef(String type) => _config.ndef.firstWhere((element) => element.type == type, orElse: () => null);
    final foundAar = findNdef(typeAar);
    if (foundAar == null) {
      aar.add(_bloc.values.getAar(""));
    } else {
      // isCustom?
      if (_bloc.values.hasAar(foundAar.value)) {
        aar.add(_bloc.values.getAar(foundAar.value));
      } else {
        customAar.add(foundAar.value);
      }
    }

    final foundUri = findNdef(typeUri);
    if (foundUri == null) return;

    uri.add(foundUri.value);
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(useNDEF.listen((value) => _config.useNDEF = value));
    _subscriptions.add(useDynamicNDEF.listen((value) => _config.useDynamicNDEF = value));
    _subscriptions.add(disablePrecomputedNDEF.listen((value) => _config.disablePrecomputedNDEF = value));
    _initNdefSubscriptions();
  }

  _initNdefSubscriptions() {
    removeAll(String type) => _config.ndef.removeWhere((element) => element.type == type);
    addNdef(String type, String value) => _config.ndef.add(NdefRecordSdk(type: type, value: value));

    _subscriptions.add(aar.listen((value) {
      if (isCustom(value)) return;

      removeAll(typeAar);
      addNdef(typeAar, value.b);
      customAar.add("");
    }));

    _subscriptions.add(customAar.listen((value) {
      if (value.isEmpty) return;

      removeAll(typeAar);
      aar.add(_bloc.values.getCustom());
      addNdef(typeAar, value);
    }));

    _subscriptions.add(uri.listen((value) {
      removeAll(typeUri);
      if (value.isEmpty) return;

      addNdef(typeUri, value);
    }));
  }
}

class PinsSegmentSegment extends BaseSegment {
  final pin1 = BehaviorSubject<String>();
  final pin2 = BehaviorSubject<String>();
  final pin3 = BehaviorSubject<String>();
  final cvc = BehaviorSubject<String>();

  PinsSegmentSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _configWasUpdated() {
    pin1.add(_config.PIN.toString());
    pin2.add(_config.PIN2.toString());
    pin3.add(_config.PIN3.toString());
    cvc.add(_config.CVC.toString());
  }

  @override
  _initSubscriptions() {
    _subscriptions.add(pin1.listen((value) => _config.PIN = value));
    _subscriptions.add(pin2.listen((value) => _config.PIN2 = value));
    _subscriptions.add(pin3.listen((value) => _config.PIN3 = value));
    _subscriptions.add(cvc.listen((value) => _config.CVC = value));
  }
}
