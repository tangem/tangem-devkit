import 'package:flutter/cupertino.dart';

class ItemId {
  static LocalKey from(String name) => ValueKey<String>(name);
}

class ItemName {
  static final cid = "cid";

  //sign screen
  static final dataForHashing = "dataForHashing";

  //personalization screen
  static final series = "series";
  static final number = "number";
  static final batchId = "batchId";
  static final blockchain = "blockchain";
  static final customBlockchain = "customBlockchain";
  static final curve = "curve";
  static final maxSignatures = "maxSignatures";
  static final createWallet = "createWallet";
  static final pauseBeforePin2 = "pauseBeforePin2";

  static final txHashes = "txHashes";
  static final rawTx = "rawTx";
  static final validatedTxHashes = "validatedTxHashes";
  static final validatedRawTx = "validatedRawTx";
  static final validatedTxHashesWithIssuerData = "validatedTxHashesWithIssuerData";
  static final validatedRawTxWithIssuerData = "validatedRawTxWithIssuerData";
  static final externalHash = "externalHash";
  static final note = "note";
  static final tag = "tag";
  static final idCard = "idCard";
  static final idIssuer = "idIssuer";

  //response screen
  static final responseJson = "responseJson";
}
