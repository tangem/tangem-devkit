import 'dart:async';

import 'package:devkit/app/domain/model/personalization/peresonalization.dart';
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
