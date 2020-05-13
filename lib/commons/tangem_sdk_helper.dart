import 'package:devkit/commons/utils/logger.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

Callback logCallback(dynamic from) {
  return Callback(
    (success) => logD(from, success),
    (error) => logD(from, error),
  );
}
