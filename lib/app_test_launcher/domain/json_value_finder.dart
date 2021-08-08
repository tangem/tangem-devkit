import 'package:tangem_sdk/extensions/exp_extensions.dart';

class JsonValueFinder {
  final _variablePattern = RegExp("\\{[^\\{\\}]*\\}");
  final _bracketLeft = "{";
  final _bracketRight = "}";

  final _variables = <String, Map<String, dynamic>>{};

  final String pathDelimiter;

  JsonValueFinder([this.pathDelimiter = "."]);

  void reset() {
    _variables.clear();
  }

  void setValue(String name, dynamic value) {
    _variables[name] = value;
  }

  dynamic removeValue(String name) {
    return _variables.remove(name);
  }

  dynamic getValue(dynamic pointer) {
    return canBeInterpret(pointer) ? getValueFrom(pointer, _variables) : pointer;
  }

  dynamic getValueFrom(String pointer, dynamic from) {
    if (from == null) return null;

    return _getValueByPattern(removeBrackets(pointer).split(pathDelimiter), 0, from);
  }

  dynamic _getValueByPattern(List<String>? pathList, int position, dynamic result) {
    if (result == null) return null;
    if (pathList == null || position >= pathList.length) return result;

    final key = pathList[position];
    if (result is Map) {
      return _getValueByPattern(pathList, ++position, result[key]);
    }

    if (result is List) {
      if (!key.isNumber()) return null;

      final index = int.parse(key.toString());
      if (index >= result.length) {
        return null;
      } else {
        return _getValueByPattern(pathList, ++position, result[index]);
      }
    } else {
      return result;
    }
  }

  bool canBeInterpret(dynamic pointer) {
    if (pointer == null) {
      return false;
    } else if (pointer is! String) {
      return false;
    } else if (!containsVariable(pointer)) {
      return false;
    } else
      return true;
  }

  bool containsVariable(String? pointer) {
    if (pointer == null || !pointer.contains(_bracketLeft)) return false;

    return _variablePattern.hasMatch(pointer);
  }

  String removeBrackets(String text) {
    if (text.startsWith(_bracketLeft) && text.endsWith(_bracketRight)) {
      return text.substring(1, text.length - 1);
    } else {
      return text;
    }
  }
}
