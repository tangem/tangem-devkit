import 'package:convert/convert.dart';

extension StringToHex on String {
  String toHexString() => hex.encode(this.codeUnits);
}

// List<int> = byteArray
extension ByteArrayToHex on List<int> {
  String toHexString() => hex.encode(this);
}