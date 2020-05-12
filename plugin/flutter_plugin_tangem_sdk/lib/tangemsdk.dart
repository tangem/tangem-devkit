import 'dart:async';

import 'package:flutter/services.dart';

class TangemSdk {
  static const MethodChannel _channel = const MethodChannel('tangemSdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future scanCard(Callback callback) async {
    final result = await _channel.invokeMethod('scanCard');
    callback.onError(result);
    callback.onSuccess(result);
  }
}

typedef Success = Function(dynamic error);
typedef Error = Function(dynamic response);

class Callback {
  final Success onSuccess;
  final Error onError;

  Callback(this.onSuccess, this.onError);
}
