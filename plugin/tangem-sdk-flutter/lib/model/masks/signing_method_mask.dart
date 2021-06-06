import 'dart:collection';

enum SigningMethod {
  SignHash,
  SignRaw,
  SignHashSignedByIssuer,
  SignRawSignedByIssuer,
  SignHashSignedByIssuerAndUpdateIssuerData,
  SignRawSignedByIssuerAndUpdateIssuerData,
  SignPos,
}

extension SigningMethodCodes on SigningMethod {
  static const codes = {
    SigningMethod.SignHash: 0,
    SigningMethod.SignRaw: 1,
    SigningMethod.SignHashSignedByIssuer: 2,
    SigningMethod.SignRawSignedByIssuer: 3,
    SigningMethod.SignHashSignedByIssuerAndUpdateIssuerData: 4,
    SigningMethod.SignRawSignedByIssuerAndUpdateIssuerData: 5,
    SigningMethod.SignPos: 6,
  };

  int get code => codes[this]!;
}

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

extension OnSigningMethod on int {
  bool contains(SigningMethod method) {
    if (this & 0x80 == 0) {
      return method.code == this;
    } else {
      return this & (0x01 << method.code) != 0;
    }
  }

  List<SigningMethod> toList() {
    final methodList = <SigningMethod>[];
    SigningMethod.values.forEach((method) {
      if (this.contains(method)) methodList.add(method);
    });
    return methodList;
  }
}
