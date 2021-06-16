import 'package:devkit/app_tester/domain/common/test_error.dart';
import 'package:devkit/app_tester/domain/common/test_result.dart';
import 'package:devkit/app_tester/domain/executable/assert/assert.dart';
import 'package:tangem_sdk/model/json_rpc.dart';

typedef SourceMap = Map<String, dynamic>;
typedef OnComplete = void Function(TestResult result);
typedef OnTestSequenceComplete = void Function(TestFrameworkError? error);
typedef OnStepSequenceComplete = void Function(CardSession, TestResult);

//TODO: bridge to the TangemSdk.CardSession
abstract class CardSession {}

abstract class JSONRPCConverter {
  JSONRPCConvertible? convert(JSONRPCRequest request);
}

abstract class AssertsFactory {
  Assert? getAssert(String type);
}

abstract class JSONRPCConvertible<T> {
  // fun makeRunnable(params: Map<String, Any?>): CardSessionRunnable<R>
}
