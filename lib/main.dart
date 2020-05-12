import 'package:flutter/material.dart';

import 'commons/utils/app_attributes.dart';
import 'launchers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final launcher = App.isDebug ? DebugLauncher() : ReleaseLauncher();
  await launcher.launch();
}
