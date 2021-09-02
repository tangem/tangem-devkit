import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';

import 'json_value_finder.dart';

class VariableService {
  static final _valueFinder = JsonValueFinder();

  static final _targetKey = "#";
  static final _parentTargetKey = "#parent";

  static final _actualResult = "actualResult";
  static final _error = "error";

  static void registerSetup(SourceMap source) {
    _valueFinder.setValue("setup", source);
  }

  static void registerStep(String name, SourceMap source) {
    _valueFinder.setValue(name, source);
  }

  static void registerActualResult(String name, dynamic result) {
    final stepMap = _valueFinder.getValue("{$name}");
    if (stepMap == null) {
      //  Step is not registered
      return;
    }

    stepMap[_actualResult] = result;
  }

  static void registerError(String name, dynamic result) {
    final stepMap = _valueFinder.getValue("{$name}");
    if (stepMap == null) {
      //  Step is not registered
      return;
    }

    stepMap[_error] = result;
  }

  static dynamic getValue(String name, dynamic pointer) {
    if (!_valueFinder.canBeInterpret(pointer)) return pointer;

    if (_containsTarget(pointer)) {
      final targetPointer = _extractPointer(pointer);
      if (targetPointer == null) return null;

      final targetName = targetPointer == _parentTargetKey ? name : _extractTargetName(targetPointer);
      final valuePointer = pointer.replaceAll("$targetPointer.", "");
      final target = _valueFinder.getValue("{$targetName}");
      return target == null ? null : _valueFinder.getValueFrom(valuePointer, target);
    } else {
      return _valueFinder.getValueFrom(pointer, _valueFinder.getValue("{$name}"));
    }
  }

  static String _extractTargetName(String stepPointer) => stepPointer.replaceAll(_targetKey, "");

  static String? _extractPointer(String pointer) => _getPrefix(_valueFinder.removeBrackets(pointer));

  static String? _getPrefix(String value) {
    final suffixIdx = value.indexOf(".");
    return suffixIdx < 0 ? null : value.substring(0, suffixIdx);
  }

  static bool _containsTarget(String? pointer) {
    return pointer == null ? false : pointer.indexOf(_targetKey) == 1;
  }

  static void reset() {
    _valueFinder.reset();
  }
}
