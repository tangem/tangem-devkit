import 'dart:async';

import 'package:flutter/services.dart';

class Sdk {
  static const MethodChannel _channel = const MethodChannel('sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future scanCard(Callback callback) async {
    return _channel.invokeMethod('scanCard');
  }
}

typedef Success = Function();
typedef Error = Function();

class Callback {
  Success onSuccess;
  Error onError;
}
