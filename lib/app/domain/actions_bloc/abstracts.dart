import 'dart:async';

import 'package:devkit/app/domain/model/command_data_models.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

abstract class ActionBloc<T> extends BaseBloc {
  final bsCard = BehaviorSubject<ReadResponse>();
  final bsCid = BehaviorSubject<String>();

  ReadResponse? _card;
  String? _cardId;
  Message? _initialMessage;

  final PublishSubject<CommandDataModel> _commandDataIsReady = PublishSubject<CommandDataModel>();

  //TODO: restore to T
  final PublishSubject<dynamic> _successResponse = PublishSubject<dynamic>();
  final PublishSubject<TangemSdkBaseError?> _errorResponse = PublishSubject<TangemSdkBaseError?>();

  ActionBloc() {
    addSubscription(bsCard.stream.listen((event) {
      _card = event;
      bsCid.add(event.cardId);
    }));
    addSubscription(bsCid.stream.listen((event) => _cardId = event));
  }

  Stream<CommandDataModel> get commandDataStream => _commandDataIsReady.stream;

  //TODO: restore to T
  Stream<dynamic> get successResponseStream => _successResponse.stream;

  Stream<TangemSdkBaseError?> get errorResponseStream => _errorResponse.stream;

  Callback get callback => Callback((success) => sendSuccess(success), (error) => sendError(error));

  // sendSuccess(T success) {
  //   _successResponse.add(success);
  // }

  //TODO: restore to T
  sendSuccess(dynamic success) {
    _successResponse.add(success);
  }

  sendError(TangemSdkBaseError? error) {
    _errorResponse.add(error);
  }

  bool hasCid() => !_cardId.isNullOrEmpty();

  scanCard() {
    final jsonRPCCallback = Callback((response) {
      if (response is! JSONRPCResponse) {
        sendSnackbarMessage("It's not a JSONRPCResponse");
        return;
      }
      if (response.result != null) {
        bsCard.add(ReadResponse.fromJson(response.result));
      } else {
        sendSnackbarMessage(response.error.toString());
      }
    }, (error) {
      // not used
      // sendError(error);
    });

    final commandData = PreflightReadModel(describeEnum(PreflightReadMode.FullCardRead));
    commandData.cardId = _cardId;
    commandData.initialMessage = _initialMessage;
    TangemSdk.runCommandAsJSONRPCRequest(jsonRPCCallback, commandData);
  }

  invokeAction() async {
    createCommandData((commandData) => _prepareCommandAndRun(commandData, callback), sendSnackbarMessage);
  }

  _prepareCommandAndRun(CommandDataModel commandData, Callback callback) async {
    commandData.cardId = _cardId;
    commandData.initialMessage = _initialMessage;

    if (commandData.isPrepared()) {
      _runCommand(commandData, callback);
    } else {
      commandData.prepare().then((value) {
        _runCommand(commandData, callback);
      }).onError((error, stackTrace) {
        sendSnackbarMessage(error);
      });
    }
  }

  _runCommand(CommandDataModel commandData, Callback callback) {
    if (!commandData.isPrepared()) {
      sendSnackbarMessage("Command is not prepared");
      return;
    }

    _commandDataIsReady.add(commandData);
    TangemSdk.runCommandAsJSONRPCRequest(callback, commandData);
  }

  void createCommandData(Function(CommandDataModel) onSuccess, Function(String) onError);
}
