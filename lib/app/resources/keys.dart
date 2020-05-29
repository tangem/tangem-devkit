import 'package:flutter/cupertino.dart';

class ItemId {
  static LocalKey from(String name) => ValueKey<String>(name);
}

class ItemName {
  static final cid = "cid";

  //sign screen
  static final dataForHashing = "dataForHashing";

  //personalization screen
  static final blockchain = "blockchain";
  static final customBlockchain = "customBlockchain";
  static final curve = "curve";
  static final createWallet = "createWallet";
  static final pauseBeforePin2 = "pauseBeforePin2";

  //response screen
  static final responseJson = "responseJson";
}
