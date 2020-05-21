import 'package:convert/convert.dart';

extension ToHexConverter on String {
  String toHexString() => hex.encode(this.codeUnits);
}

extension ToStringConverter on List<int> {
  String toHexString(){
    return hex.encode(this);
  }
}