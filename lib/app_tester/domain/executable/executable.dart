import 'dart:core';

import '../common/typedefs.dart';

abstract class Executable {
  String getMethod();

  run(OnComplete callback);
}
