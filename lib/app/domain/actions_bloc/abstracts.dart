import 'dart:async';

import 'package:devkit/app/domain/model/command_data_models.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:devkit/main.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

abstract class ActionBloc<T> extends BaseBloc {
  final bsCid = BehaviorSubject<String>();

  String? _cid;
  Message? _initialMessage;

  final PublishSubject<CommandDataModel> _commandDataIsReady = PublishSubject<CommandDataModel>();
  final PublishSubject<T> _successResponse = PublishSubject<T>();
  final PublishSubject<TangemSdkPluginError?> _errorResponse = PublishSubject<TangemSdkPluginError?>();

  ActionBloc() {
    addSubscription(bsCid.stream.listen((event) => _cid = event));
  }

  Stream<CommandDataModel> get commandDataStream => _commandDataIsReady.stream;

  Stream<T> get successResponseStream => _successResponse.stream;

  Stream<TangemSdkPluginError?> get errorResponseStream => _errorResponse.stream;

  Callback get callback => Callback((success) => sendSuccess(success), (error) => sendError(error));

  sendSuccess(T success) {
    _successResponse.add(success);
  }

  sendError(TangemSdkPluginError? error) {
    _errorResponse.add(error);
  }

  bool hasCid() => !_cid.isNullOrEmpty();

  scanCard() {
    final callback = Callback((result) {
      bsCid.add(parseCidFromSuccessScan(result));
    }, (error) {
      sendError(error);
    });
    _prepareCommandAndRun(ScanModel(), callback);
  }

  invokeAction() async {
    createCommandData((commandData) {
      if (commandData.type == TangemSdk.cCreateWallet) {
        _prepareCommandAndRun(
            commandData,
            Callback((result) {
              if (result is CreateWalletResponse) {
                gWalletPublicKey = result.walletPublicKey;
              }
              callback.onSuccess(result);
            }, callback.onError));
      } else {
        _prepareCommandAndRun(commandData, callback);
      }
    }, sendSnackbarMessage);
  }

  _prepareCommandAndRun(CommandDataModel commandData, Callback callback) async {
    commandData.cardId = _cid;
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
    TangemSdk.runCommand(callback, commandData);
  }

  void createCommandData(Function(CommandDataModel) onSuccess, Function(String) onError);
}

String parseCidFromSuccessScan(CardResponse card) {
  return card.cardId;
}
