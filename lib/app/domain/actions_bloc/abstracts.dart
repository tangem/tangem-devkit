import 'dart:async';

import 'package:devkit/app/domain/actions_bloc/scan_card/scan_bloc.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

abstract class ActionBloc<T> extends Disposable {
  final bsCid = BehaviorSubject<String>();

  List<StreamSubscription> subscriptions = [];

  PublishSubject _successResponse = PublishSubject<T>();
  PublishSubject _errorResponse = PublishSubject<ErrorResponse>();
  PublishSubject _snackbarMessage = PublishSubject<dynamic>();

  Stream<T> get successResponseStream => _successResponse.stream;

  Stream<ErrorResponse> get errorResponseStream => _errorResponse.stream;

  Stream<dynamic> get snackbarMessageStream => _snackbarMessage.stream;

  Callback get callback => Callback((success) => sendSuccess(success), (error) => sendError(error));

  sendSuccess(T success) {
    _successResponse.add(success);
  }

  sendError(ErrorResponse error) {
    _errorResponse.add(error);
  }

  sendSnackbarMessage(dynamic message) {
    _snackbarMessage.add(message);
  }

  scanCard() {
    final callback = Callback((result) {
      bsCid.add(parseCidFromSuccessScan(result));
    }, (error) {
      sendError(error);
    });
    TangemSdk.scanCard(callback, {});
  }

  invokeAction();

  @override
  dispose() {
    subscriptions.forEach((element) => element.cancel());
  }
}
