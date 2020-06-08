import 'package:flutter/cupertino.dart';

class ItemId {
  static LocalKey from(String name) => ValueKey<String>(name);
  static LocalKey btnFrom(String name) => ValueKey<String>("$name.btn");
}

class ItemName {
  static final menu = "menu";
  static final menuDescription = "menuDescription";
  static final menuConfigs = "menuConfigs";
  static final menuImport = "menuImport";
  static final menuExport = "menuExport";

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
  static final allowUnencrypted = "allowUnencrypted";
  static final allowFastEncryption = "allowFastEncryption";
  static final pin1 = "pin1";
  static final pin2 = "pin2";
  static final pin3 = "pin3";
  static final cvc = "cvc";
  static final isReusable = "isReusable";
  static final useActivation = "useActivation";
  static final forbidPurgeWallet = "forbidPurgeWallet";
  static final allowSelectBlockchain = "allowSelectBlockchain";
  static final useBlock = "useBlock";
  static final useOneCommandAtTime = "useOneCommandAtTime";
  static final useCVC = "useCVC";
  static final allowSwapPIN1 = "allowSwapPIN";
  static final allowSwapPIN2 = "allowSwapPIN2";
  static final forbidDefaultPIN = "forbidDefaultPIN";
  static final smartSecurityDelay = "smartSecurityDelay";
  static final protectIssuerDataAgainstReplay = "protectIssuerDataAgainstReplay";
  static final skipSecurityDelayIfValidatedByIssuer = "skipSecurityDelayIfValidatedByIssuer";
  static final skipCheckPIN2andCVCIfValidatedByIssuer = "skipCheckPIN2andCVCIfValidatedByIssuer";
  static final skipSecurityDelayIfValidatedByLinkedTerminal = "skipSecurityDelayIfValidatedByLinkedTerminal";
  static final restrictOverwriteIssuerDataEx = "restrictOverwriteIssuerDataEx";
  static final useNdef = "useNdef";
  static final dynamicNdef = "dynamicNdef";
  static final disablePrecomputedNdef = "disablePrecomputedNdef";
  static final aar = "aar";
  static final customAar = "customAar";
  static final uri = "uri";
  static final pinLessFloorLimit = "pinLessFloorLimit";
  static final hexCrExKey = "hexCrExKey";
  static final requireTerminalCertSignature = "requireTerminalCertSignature";
  static final requireTerminalTxSignature = "requireTerminalTxSignature";
  static final checkPIN3onCard = "checkPIN3onCard";
  static final itsToken = "itsToken";
  static final tokenSymbol = "tokenSymbol";
  static final tokenContractAddress = "tokenContractAddress";
  static final tokenDecimal = "tokenDecimal";

  //response screen
  static final responseJson = "responseJson";

  //personalization save\restore config dialog
  static final personalizationConfigInput = "personalizationConfigInput";
  static final personalizationConfigTile = "personalizationConfigTile";
  //personalization import config dialog
  static final personalizationImportInput = "personalizationImportInput";

}
