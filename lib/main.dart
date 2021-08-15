import 'package:flutter/material.dart';

import 'commons/utils/app_attributes.dart';
import 'launchers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final launcher = App.isDebug ? DebugLauncher() : ReleaseLauncher();
  await launcher.launch();
}

//TODO: создать модуль DevKit2 в котором построение UI и общение с tangemSdk будет осуществляться
//TODO: только через JSON
