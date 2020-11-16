import 'dart:async';

import 'package:devkit/app/domain/actions_bloc/scan_card/scan_bloc.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

abstract class ActionBloc<T> extends Disposable {
  final bsCid = BehaviorSubject<String>();

  String _cid;
  Message _initialMessage;

  ActionBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  List<StreamSubscription> subscriptions = [];

  PublishSubject _successResponse = PublishSubject<T>();
  PublishSubject _errorResponse = PublishSubject<TangemSdkBaseError>();
  PublishSubject _snackbarMessage = PublishSubject<dynamic>();

  Stream<T> get successResponseStream => _successResponse.stream;

  Stream<TangemSdkBaseError> get errorResponseStream => _errorResponse.stream;

  Stream<dynamic> get snackbarMessageStream => _snackbarMessage.stream;

  Callback get callback => Callback((success) => sendSuccess(success), (error) => sendError(error));

  sendSuccess(T success) {
    _successResponse.add(success);
  }

  sendError(TangemSdkBaseError error) {
    _errorResponse.add(error);
  }

  sendSnackbarMessage(dynamic message) {
    _snackbarMessage.add(message);
  }

  bool hasCid() => _cid != null && _cid.isNotEmpty;

  scanCard() {
    final callback = Callback((result) {
      bsCid.add(parseCidFromSuccessScan(result));
    }, (error) {
      sendError(error);
    });
    TangemSdk.runCommand(callback, ScanModel());
  }

  invokeAction() {
    final commandData = createCommandData();
    if (commandData == null) return;

    commandData.cardId = _cid;
    commandData.initialMessage = _initialMessage;
    TangemSdk.runCommand(callback, commandData);
  }

  CommandSignatureData createCommandData();

  @override
  dispose() {
    subscriptions.forEach((element) => element.cancel());
  }
}
