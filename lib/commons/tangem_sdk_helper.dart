import 'package:devkit/commons/utils/logger.dart';
import 'package:tangemsdk/tangemsdk.dart';

Callback logCallback(dynamic from) {
  return Callback(
    (success) => logD(from, success),
    (error) => logD(from, error),
  );
}
