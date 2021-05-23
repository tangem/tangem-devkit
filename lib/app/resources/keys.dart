import 'package:flutter/cupertino.dart';

class ItemId {
  static LocalKey from(String? name) => ValueKey<String?>(name);
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
  static final walletsCount = "walletsCount";
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
  static final twinCard = "twinCard";
  static final allowUnencrypted = "allowUnencrypted";
  static final allowFastEncryption = "allowFastEncryption";
  static final pin1 = "pin1";
  static final pin2 = "pin2";
  static final pin3 = "pin3";
  static final cvc = "cvc";
  static final isReusable = "isReusable";
  static final useActivation = "useActivation";
  static final prohibitPurgeWallet = "prohibitPurgeWallet";
  static final allowSelectBlockchain = "allowSelectBlockchain";
  static final useBlock = "useBlock";
  static final useOneCommandAtTime = "useOneCommandAtTime";
  static final useCvc = "useCvc";
  static final allowSetPIN1 = "allowSetPIN1";
  static final allowSetPIN2 = "allowSetPIN2";
  static final prohibitDefaultPIN1 = "prohibitDefaultPIN1";
  static final smartSecurityDelay = "smartSecurityDelay";
  static final protectIssuerDataAgainstReplay = "protectIssuerDataAgainstReplay";
  static final skipSecurityDelayIfValidatedByIssuer = "skipSecurityDelayIfValidatedByIssuer";
  static final skipCheckPIN2CVCIfValidatedByIssuer = "skipCheckPIN2CVCIfValidatedByIssuer";
  static final skipSecurityDelayIfValidatedByLinkedTerminal = "skipSecurityDelayIfValidatedByLinkedTerminal";
  static final restrictOverwriteIssuerExtraData = "restrictOverwriteIssuerExtraData";
  static final useNDEF = "useNDEF";
  static final useDynamicNDEF = "useDynamicNDEF";
  static final disablePrecomputedNDEF = "disablePrecomputedNDEF";
  static final aar = "aar";
  static final customAar = "customAar";
  static final uri = "uri";
  static final pinLessFloorLimit = "pinLessFloorLimit";
  static final hexCrExKey = "hexCrExKey";
  static final requireTerminalCertSignature = "requireTerminalCertSignature";
  static final requireTerminalTxSignature = "requireTerminalTxSignature";
  static final checkPIN3OnCard = "checkPIN3OnCard";
  static final itsToken = "itsToken";
  static final tokenSymbol = "tokenSymbol";
  static final tokenContractAddress = "tokenContractAddress";
  static final tokenDecimal = "tokenDecimal";

  //response screen
  static final responseJson = "responseJson";

  //personalization save\restore config dialog
  static final personalizationConfigInput = "personalizationConfigInput";
  static final personalizationConfigItems = "personalizationConfigItems";
  //personalization import config dialog
  static final personalizationImportInput = "personalizationImportInput";

  //write issuer data
  static final issuerData = "issuerData";
  static final issuerDataCounter = "issuerDataCounter";

  //write user data
  static final userData = "userData";
  static final userCounter = "userCounter";
  static final userProtectedData = "userProtectedData";
  static final userProtectedCounter = "userProtectedCounter";

  //set pin code
  static final pinCode = "pinCode";

  //files
  static final takePhoto = "takePhoto";
  static final protectionType = "protectionType";
  static final readPrivateFiles = "readPrivateFiles";
  static final indices = "indices";
  static final fileSettings = "fileSettings";

  //hidden
  static final navigateToTestScreen = "navigateToTestScreen";
  static final navigateToJsonTestAssembler = "navigateToJsonTestAssembler";
  static final commandJson = "commandJson";
  static final responseSuccessJson = "responseSuccessJson";
  static final responseErrorJson = "responseErrorJson";
}
