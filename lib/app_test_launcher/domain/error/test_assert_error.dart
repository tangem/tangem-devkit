import 'error.dart';

abstract class TestAssertError implements TestFrameworkError {}

class EqualsError extends TestAssertError {
  final dynamic firstValue;
  final dynamic secondValue;

  EqualsError(this.firstValue, this.secondValue);

  @override
  String get errorMessage => "Fields doesn't match. f1: $firstValue, f2: $secondValue";
}
