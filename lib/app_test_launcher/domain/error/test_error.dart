import 'dart:core';

import 'error.dart';


abstract class TestError extends TestFrameworkError {}

class TestIsEmptyError implements TestError {
  @override
  String get errorMessage => "Test doesn't contains any data to proceed";
}

class SessionSdkInitError implements TestError {
  final dynamic error;

  SessionSdkInitError(this.error);

  @override
  String get errorMessage => "Session initialization failed. Code: ${error.code}, message: ${error.customMessage}";
}

