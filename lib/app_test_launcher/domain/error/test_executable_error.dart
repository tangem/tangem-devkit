import 'error.dart';

abstract class ExecutableError implements TestFrameworkError {}

class ExecutableNotFoundError implements ExecutableError {
  final String name;

  ExecutableNotFoundError(this.name);

  @override
  String get errorMessage => "Executable is not found for the name: $name";
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

class ExpectedResultError implements ExecutableError {
  final List<String> errorMessages;

  ExpectedResultError(this.errorMessages);

  @override
  String get errorMessage => errorMessages.join("\n");
}
