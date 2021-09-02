import 'package:devkit/app_test_launcher/domain/error/error.dart';

class TestResult {}

class Success implements TestResult {
  final String? name;

  Success([this.name]);
}

class StepSuccess extends Success {
  StepSuccess(String name) : super(name);
}

class AssertSuccess extends Success {
  AssertSuccess(String name) : super(name);
}

class Failure implements TestResult {
  final TestFrameworkError error;

  Failure(this.error);
}

class StepFailure extends Failure {
  final String stepName;
  final String? assertName;

  StepFailure(this.stepName, TestFrameworkError error, [this.assertName]) : super(error);

  factory StepFailure.fromAssert(String stepName, AssertFailure failure) {
    return StepFailure(stepName, failure.error, failure.assertName);
  }
}

class AssertFailure extends Failure {
  final String assertName;

  AssertFailure(this.assertName, TestFrameworkError error) : super(error);
}
