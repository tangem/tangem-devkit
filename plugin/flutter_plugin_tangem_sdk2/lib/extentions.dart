extension HexStringToBytes on String {
  List<int> hexToBytes() {
    final length = this.length ~/ 2;
    final byteArray = List<int>(length);
    for (int i = 0; i < length; i++) {
      final subs = this.substring(2 * i, 2 * i + 2);
      byteArray[i] = int.parse(subs, radix: 16);
    }
    return byteArray;
  }
}