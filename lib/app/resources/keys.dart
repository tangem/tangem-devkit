import 'package:flutter/cupertino.dart';

class ItemId {
  static LocalKey from(String name) => ValueKey<String>(name);
}

class ItemName {
  static final cid = "cid";
  static final dataForHashing = "dataForHashing";
  static final responseJson = "responseJson";
}
