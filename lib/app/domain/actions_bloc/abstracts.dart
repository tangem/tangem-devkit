import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

abstract class Disposable {
  dispose();
}

abstract class ActionBloc<T> extends Disposable {
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

  @override
  dispose() {
    subscriptions.forEach((element) => element.cancel());
  }

  invokeAction();
}
