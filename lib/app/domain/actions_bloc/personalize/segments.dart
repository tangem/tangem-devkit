import 'dart:async';

import 'package:devkit/app/domain/model/personalization/peresonalization.dart';
import 'package:devkit/app/domain/utils/signing_method_mask_builder.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';

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
  final bsPauseBeforePin = BehaviorSubject<Pair<String, int>>();

  CommonSegment(PersonalizationBloc bloc, PersonalizationConfig config) : super(bloc, config);

  @override
  _initSubscriptions() {
    _subscriptions.add(bsBlockchain.listen(_listenBlockchain));
    _subscriptions.add(bsCustomBlockchain.listen(_listenCustomBlockchain));
    _subscriptions.add(bsCurve.listen((value) => _config.curveID = value.b));
    _subscriptions.add(bsMaxSignatures.listen((value) => _config.maxSignatures = value.isEmpty ? 0 : int.parse(value)));
    _subscriptions.add(bsCreateWallet.listen((value) => _config.createWallet = value ? 1 : 0));
    _subscriptions.add(bsPauseBeforePin.listen((value) => _config.pauseBeforePIN2 = value.b));
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
    bsMaxSignatures.add(_config.maxSignatures.toString());
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
    final method = _config.signingMethod;
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
    _subscriptions.add(bsTxHashes.listen((value) {
      _handleMethodChanges(value, 0);
    }));
    _subscriptions.add(bsRawTx.listen((value) {
      _handleMethodChanges(value, 1);
    }));
    _subscriptions.add(bsValidatedTxHashes.listen((value) {
      _handleMethodChanges(value, 2);
    }));
    _subscriptions.add(bsValidatedRawTx.listen((value) {
      _handleMethodChanges(value, 3);
    }));
    _subscriptions.add(bsValidatedTxHashesWithIssuerData.listen((value) {
      _handleMethodChanges(value, 4);
    }));
    _subscriptions.add(bsValidatedRawTxWithIssuerData.listen((value) {
      _handleMethodChanges(value, 5);
    }));
    _subscriptions.add(bsExternalHash.listen((value) {
      _handleMethodChanges(value, 6);
    }));
  }

  _handleMethodChanges(bool isChecked, int method) {
    if (isChecked)
      maskBuilder.addMethod(method);
    else
      maskBuilder.removeMethod(method);
    _config.signingMethod = maskBuilder.build();
  }
}
