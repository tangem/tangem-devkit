
import 'package:devkit/app_test_launcher/domain/error/error.dart';

class TestResult {}

class Success implements TestResult {
  final String? name;

  Success([this.name]);
}

class Failure implements TestResult {
  final TestFrameworkError error;

  Failure(this.error);
}
