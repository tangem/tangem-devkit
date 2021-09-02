import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/error/error.dart';

typedef SourceMap = Map<String, dynamic>;
typedef OnComplete = void Function(TestResult result);
typedef OnTestSequenceComplete = void Function(TestFrameworkError? error);
typedef OnStepSequenceComplete = void Function(TestResult result);
