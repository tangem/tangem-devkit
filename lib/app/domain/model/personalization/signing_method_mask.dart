import 'dart:collection';

class SigningMethodMaskBuilder {
  HashSet<int> _signingMethods = HashSet();

  addMethod(int signingMethod) {
    _signingMethods.add(signingMethod);
  }

  removeMethod(int signingMethod) {
    _signingMethods.remove(signingMethod);
  }

  int build() {
    int value;
    if (_signingMethods.isEmpty) {
      value = 0;
    } else if (_signingMethods.length == 1) {
      value = _signingMethods.first;
    } else {
      value = _signingMethods.fold(0x80, (acc, singingMethod) => acc + (0x01 << singingMethod));
    }
    return value;
  }

  static bool maskContainsMethod(int mask, int method) {
    if (mask & 0x80 == 0) {
      return method == mask;
    } else {
      return mask & (0x01 << method) != 0;
    }
  }
}