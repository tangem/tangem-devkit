import 'dart:async';

import 'package:flutter/services.dart';

class TangemSdk {
  static const MethodChannel _channel =
      const MethodChannel('tangemSdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
