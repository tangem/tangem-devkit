import 'error.dart';

abstract class TestStepError extends TestFrameworkError {}

class AssertNotRegisteredError extends TestStepError {
  final String name;

  AssertNotRegisteredError(this.name);

  @override
  String get errorMessage => "Executable is not found for the name: $name";
}
