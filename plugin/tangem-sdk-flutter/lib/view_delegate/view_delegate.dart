import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tangem_sdk/tangem_sdk.dart';
import 'package:tangem_sdk/view_delegate/model.dart';

typedef void MultiUseCallback(dynamic msg);
typedef void CancelListening();

abstract class TangemSdkViewDelegate {
  dismiss();

  onDelay(int total, int current, int step);

  onError(String error);

  onPinChangeRequested(PinType pinType, Function(String pin) callback);

  onPinRequested(PinType pinType, bool isFirstAttempt, Function(String pin) callback);

  onSecurityDelay(int ms, int totalDurationSeconds);

  onSessionStarted(String cardId, Message message, bool enableHowTo);

  onSessionStopped(Message message);

  onTagConnected();

  onTagLost();

  onWrongCard(WrongValueType wrongValueType);

  // setConfig(Config config);

  setMessage(Message message);
}

class ViewDelegate {
  final TangemSdkViewDelegate _viewDelegate;
  MethodChannel _channel;

  ViewDelegate(this._viewDelegate) {
    _channel = const MethodChannel('tangemSdk.viewDelegate');
  }

  subscribe() {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  unsubscribe() {
    _channel.setMethodCallHandler(null);
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case "dismiss":
        _dismiss(call);
        break;
      case "onDelay":
        _onDelay(call);
        break;
      case "onError":
        _onError(call);
        break;
      case "onPinChangeRequested":
        _onPinChangeRequested(call);
        break;
      case "onPinRequested":
        _onPinRequested(call);
        break;
      case "onSecurityDelay":
        _onSecurityDelay(call);
        break;
      case "onSessionStarted":
        _onSessionStarted(call);
        break;
      case "onSessionStopped":
        _onSessionStopped(call);
        break;
      case "onTagConnected":
        _onTagConnected(call);
        break;
      case "onTagLost":
        _onTagLost(call);
        break;
      case "onWrongCard":
        _onWrongCard(call);
        break;
      case "setConfig":
        _setConfig(call);
        break;
      case "setMessage":
        _setMessage(call);
        break;
      default:
        print('TestFairy: Ignoring invoke from native. This normally shouldn\'t happen.');
    }
  }

  _dismiss(MethodCall call) {
    _viewDelegate.dismiss();
  }

  _onDelay(MethodCall call) {
    OnDelay delay = jsonDecode(call.arguments);
    _viewDelegate.onDelay(delay.total, delay.current, delay.step);
  }

  _onError(MethodCall call) {
    String error = jsonDecode(call.arguments);
    _viewDelegate.onError(error);
  }

  _onPinChangeRequested(MethodCall call) {
    PinType pinType = jsonDecode(call.arguments);
    _viewDelegate.onPinChangeRequested(pinType, (pin) => {});
  }

  _onPinRequested(MethodCall call) {
    OnPinRequested pinRequested = jsonDecode(call.arguments);
    _viewDelegate.onPinRequested(pinRequested.pinType, pinRequested.isFirstAttempt, (pin) => {});
  }

  _onSecurityDelay(MethodCall call) {
    OnSecurityDelay sd = jsonDecode(call.arguments);
    _viewDelegate.onSecurityDelay(sd.ms, sd.totalDurationSeconds);
  }

  _onSessionStarted(MethodCall call) {
    OnSessionStarted started = jsonDecode(call.arguments);
    _viewDelegate.onSessionStarted(started.cardId, started.message, started.enableHowTo);
  }

  _onSessionStopped(MethodCall call) {
    Message message = jsonDecode(call.arguments);
    _viewDelegate.onSessionStopped(message);
  }

  _onTagConnected(MethodCall call) {
    _viewDelegate.onTagConnected();
  }

  _onTagLost(MethodCall call) {
    _viewDelegate.onTagLost();
  }

  _onWrongCard(MethodCall call) {
    final mapValues = WrongValueType.values.toMap((e) => MapEntry(e, e.toString()));
    final wrongValueType = enumDecode(mapValues, call.arguments);
    _viewDelegate.onWrongCard(wrongValueType);
  }

  _setConfig(MethodCall call) {
    //empty
  }

  _setMessage(MethodCall call) {
    Message message = jsonDecode(call.arguments);
    _viewDelegate.setMessage(message);
  }
}
