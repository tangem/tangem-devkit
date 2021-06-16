import 'package:devkit/app_tester/domain/common/test_error.dart';
import 'package:sealed_class/sealed_class.dart';

@Sealed([
  ExecutableNotInitialized,
  ExecutableNotFoundError,
  MissingJsonAdapterError,
  FetchVariableError,
  UnexpectedResponseError,
  ExpectedResultError,
])
abstract class ExecutableError implements TestFrameworkError {}

class ExecutableNotInitialized implements ExecutableError {
  final String name;

  ExecutableNotInitialized(this.name);

  @override
  String get errorMessage => "Executable $name is not initialized";
}

class ExecutableNotFoundError implements ExecutableError {
  final String name;

  ExecutableNotFoundError(this.name);

  @override
  String get errorMessage => "Executable is not found for the name: $name";
}

class MissingJsonAdapterError implements ExecutableError {
  final String name;

  MissingJsonAdapterError(this.name);

  @override
  String get errorMessage => "Missing json runnable adapter for the $name";
}

class FetchVariableError implements ExecutableError {
  final dynamic paramName;
  final String path;
  final AssertionError exception;

  FetchVariableError(this.paramName, this.path, this.exception);

  @override
  String get errorMessage =>
      "Fetching variable failed. Name: $paramName, path: $path, ex: ${exception.message?.toString()}";
}

class UnexpectedResponseError implements ExecutableError {
  final Object response;

  UnexpectedResponseError(this.response);

  @override
  String get errorMessage => "Waiting for JsonResponse, but current is ${response.runtimeType.toString()}";
}

class ExpectedResultError implements ExecutableError {
  final List<String> errorMessages;

  ExpectedResultError(this.errorMessages);

  @override
  String get errorMessage => errorMessages.join("\n");
}
