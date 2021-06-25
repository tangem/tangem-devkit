import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';

import 'JsonValueFinder.dart';

class VariableService {
  static final _valueFinder = JsonValueFinder();

  static final _stepKey = "#";
  static final _parentStepKey = "#parent";

  static final _actualResult = "actualResult";
  static final _error = "error";

  static void registerStep(String name, SourceMap source) {
    _valueFinder.setValue(name, source);
  }

  static void registerActualResult(String name, dynamic result) {
    final stepMap = _valueFinder.getValue(name);
    if (stepMap == null) {
      //  Step is not registered
      return;
    }

    stepMap[_actualResult] = result;
  }

  static void registerError(String name, dynamic result) {
    final stepMap = _valueFinder.getValue(name);
    if (stepMap == null) {
      //  Step is not registered
      return;
    }

    stepMap[_error] = result;
  }

  static dynamic getStepValue(String name, dynamic pointer) {
    if (!_valueFinder.canBeInterpret(pointer)) return null;

    if (_containsPointer(pointer)) {
      final stepPointer = _extractPointer(pointer);
      if (stepPointer == null) return null;

      final stepName = stepPointer == _parentStepKey ? name : _extractStepName(stepPointer);
      final pathValue = _valueFinder.removeBrackets(pointer).replaceAll("$stepPointer.", "");
      final step = _valueFinder.getValue(stepName);
      return step == null ? null : _valueFinder.getValueFrom(pathValue, _valueFinder.getValue("{$step}"));
    } else {
      return _valueFinder.getValueFrom(pointer, _valueFinder.getValue("{$name}"));
    }
  }

  static String _extractStepName(String stepPointer) => stepPointer.replaceAll(_stepKey, "");

  static String? _extractPointer(String pointer) => _getPrefix(_valueFinder.removeBrackets(pointer));

  static String? _getPrefix(String value) {
    final suffixIdx = value.indexOf(".");
    return suffixIdx < 0 ? null : value.substring(0, suffixIdx);
  }

  static bool _containsPointer(String? pointer) {
    return pointer == null ? false : pointer.indexOf(_stepKey) == 1;
  }

  static void reset() {
    _valueFinder.reset();
  }
}
