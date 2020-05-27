import 'package:flutter/cupertino.dart';

LocalKey stringKey(String id) => ValueKey<String>(id);

class FieldKey {
  static final cid = stringKey("cid");
  static final dataForHashing = stringKey("dataForHashing");
  static final responseJson = stringKey("responseJson");

  static LocalKey from(String name) => stringKey(name);
}

class KeyName {
  static final responseJson = "responseJson";
}