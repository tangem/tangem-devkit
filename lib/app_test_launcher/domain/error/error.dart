import 'package:tangem_sdk/model/json_rpc.dart';
import 'package:tangem_sdk/plugin_error.dart';

abstract class TestFrameworkError {
  String get errorMessage;
}

class TangemSdkPluginWrappedError extends TestFrameworkError {
  final TangemSdkPluginError error;

  TangemSdkPluginWrappedError(this.error);

  @override
  String get errorMessage => "TangemSdkPluginError: ${error.toString()}";
}

extension OnJSONRPCError on JSONRPCError {
  bool isInterruptTest() {
    switch (code) {
      case -32000:
        return data != null && data!.contains("code: 50002");
      case 1000:
        return true;
      case 50002:
        return true;
      case 50003:
        return true;
    }
    return false;
  }
}
