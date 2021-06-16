import 'package:devkit/app_tester/domain/common/test_error.dart';
import 'package:sealed_class/sealed_class.dart';

// part 'test_result.g.dart';

// flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs
@Sealed([Success, Failure])
class TestResult {}

class Success implements TestResult {
  final String? name;

  Success([this.name]);
}

class Failure implements TestResult {
  final TestFrameworkError error;

  Failure(this.error);
}
