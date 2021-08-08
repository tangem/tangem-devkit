import 'error.dart';

abstract class TestAssertError extends TestFrameworkError {}

class ExpectedAndActualResultError extends TestAssertError {
  final String? message;

  ExpectedAndActualResultError([this.message]);

  @override
  String get errorMessage => "Expected and actual results doesn't match. $message";
}

class EqualsError extends TestAssertError {
  final dynamic firstValue;
  final dynamic secondValue;

  EqualsError(this.firstValue, this.secondValue);

  @override
  String get errorMessage => "Fields doesn't match. f1: $firstValue, f2: $secondValue";
}

class IsNotEmptyError extends TestAssertError {
  final String fieldName;

  IsNotEmptyError(this.fieldName);
  @override
  String get errorMessage => "Field $fieldName is empty";
}
