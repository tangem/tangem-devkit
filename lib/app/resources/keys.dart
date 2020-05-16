
import 'package:flutter/cupertino.dart';

LocalKey stringKey(String id) => ValueKey<String>(id);

class FieldKey {
  static final cid = stringKey("cid");
  static final dataForHashing = stringKey("dataForHashing");
}