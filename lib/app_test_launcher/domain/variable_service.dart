import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';
import 'package:tangem_sdk/model/json_rpc.dart';

class VariableService {
  static final _variablePattern = RegExp("\\{[^\\{\\}]*\\}");

  static final _bracketLeft = "{";
  static final _bracketRight = "}";
  static final _stepPointer = "#";
  static final _parent = "#parent";
  static final _result = "result";

  static final _stepValues = <String, SourceMap>{};

  static void reset() {
    _stepValues.clear();
  }

  static void registerResult(String name, JSONRPCResponse response) {
    final stepMap = _stepValues[name];
    if (stepMap == null) {
      //  Step is not registered
      return;
    }

    stepMap[_result] = response.result;
  }

  static void registerStep(String name, SourceMap source) {
    _stepValues[name] = source;
  }

  static dynamic getValue(String name, dynamic pointer) {
    if (pointer == null) {
      return null;
    } else if (pointer is! String) {
      return pointer;
    } else if (!_containsVariable(pointer)) {
      return pointer;
    } else if (_containsStepPointer(pointer)) {
      final stepPointer = _extractStepPointer(pointer);
      if (stepPointer == null) return null;

      final stepName = stepPointer == _parent ? name : _extractStepName(stepPointer);
      final pathValue = _removeBrackets(pointer).replaceAll("$stepPointer.", "");
      final step = _stepValues[stepName];
      return step == null ? null : _getValueByPointer(pathValue, step);
    } else {
      return _getValueByPointer(pointer, _stepValues[name]);
    }
  }

  static dynamic _getValueByPointer(String pointer, dynamic target) {
    if (target == null) return null;

    return _getValueByPattern(_removeBrackets(pointer).split("\\."), 0, target);
  }

  static dynamic _getValueByPattern(List<String>? pointer, int position, dynamic result) {
    if (result == null) return null;
    if (pointer == null || position >= pointer.length) return result;

    final key = pointer[position];
    if (result is Map) {
      return _getValueByPattern(pointer, position + 1, result[key]);
    }

    if (result is List) {
      if (key.isNumber()) {
        final index = int.parse(key.toString());
        if (index >= result.length) {
          return null;
        } else {
          _getValueByPattern(pointer, ++position, result[index]);
        }
      } else {
        final listOfResults = <dynamic>[];
        result.forEach((element) {
          _getValueByPattern(pointer, position, element)?.let((it) {
            listOfResults.add(it);
          });
        });

        return listOfResults.isEmpty ? null : listOfResults;
      }
    } else {
      return result;
    }
  }

  static bool _containsVariable(String? pointer) {
    if (pointer == null || !pointer.contains(_bracketLeft)) return false;

    return _variablePattern.hasMatch(pointer);
  }

  static bool _containsStepPointer(String? pointer) {
    return pointer == null ? false : pointer.indexOf(_stepPointer) == 1;
  }

  static String _extractStepName(String stepPointer) => stepPointer.replaceAll(stepPointer, "");

  static String? _extractStepPointer(String pointer) => _getPrefix(_removeBrackets(pointer));

  static String? _getPrefix(String value) {
    final suffixIdx = value.indexOf(".");
    return suffixIdx < 0 ? null : value.substring(0, suffixIdx);
  }

  static String _removeBrackets(String text) {
    if (text.startsWith(_bracketLeft) && text.endsWith(_bracketRight)) {
      return text.substring(1, text.length - 1);
    } else {
      return text;
    }
  }
}
