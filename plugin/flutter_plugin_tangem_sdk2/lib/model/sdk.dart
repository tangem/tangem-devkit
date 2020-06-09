import 'package:json_annotation/json_annotation.dart';

part 'sdk.g.dart';

@JsonSerializable()
class CardConfigSdk {
  final String issuerName;
  final String acquirerName;
  final String series;
  final int startNumber;
  final int count;
  final String pin;
  final String pin2;
  final String pin3;
  final String hexCrExKey;
  final String cvc;
  final int pauseBeforePin2;
  final bool smartSecurityDelay;
  final String curveID;
  final SigningMethodMaskSdk signingMethods;
  final int maxSignatures;
  final bool isReusable;
  final bool allowSwapPin;
  final bool allowSwapPin2;
  final bool useActivation;
  final bool useCvc;
  final bool useNdef;
  final bool useDynamicNdef;
  final bool useOneCommandAtTime;
  final bool useBlock;
  final bool allowSelectBlockchain;
  final bool forbidPurgeWallet;
  final bool protocolAllowUnencrypted;
  final bool protocolAllowStaticEncryption;
  final bool protectIssuerDataAgainstReplay;
  final bool forbidDefaultPin;
  final bool disablePrecomputedNdef;
  final bool skipSecurityDelayIfValidatedByIssuer;
  final bool skipCheckPIN2andCVCIfValidatedByIssuer;
  final bool skipSecurityDelayIfValidatedByLinkedTerminal;
  final bool restrictOverwriteIssuerDataEx;
  final bool requireTerminalTxSignature;
  final bool requireTerminalCertSignature;
  final bool checkPin3onCard;
  final bool createWallet;
  final CardDataSdk cardData;
  final List<NdefRecordSdk> ndefRecords;

  CardConfigSdk({
    this.issuerName,
    this.acquirerName,
    this.series,
    this.startNumber,
    this.count,
    this.pin,
    this.pin2,
    this.pin3,
    this.hexCrExKey,
    this.cvc,
    this.pauseBeforePin2,
    this.smartSecurityDelay,
    this.curveID,
    this.signingMethods,
    this.maxSignatures,
    this.isReusable,
    this.allowSwapPin,
    this.allowSwapPin2,
    this.useActivation,
    this.useCvc,
    this.useNdef,
    this.useDynamicNdef,
    this.useOneCommandAtTime,
    this.useBlock,
    this.allowSelectBlockchain,
    this.forbidPurgeWallet,
    this.protocolAllowUnencrypted,
    this.protocolAllowStaticEncryption,
    this.protectIssuerDataAgainstReplay,
    this.forbidDefaultPin,
    this.disablePrecomputedNdef,
    this.skipSecurityDelayIfValidatedByIssuer,
    this.skipCheckPIN2andCVCIfValidatedByIssuer,
    this.skipSecurityDelayIfValidatedByLinkedTerminal,
    this.restrictOverwriteIssuerDataEx,
    this.requireTerminalTxSignature,
    this.requireTerminalCertSignature,
    this.checkPin3onCard,
    this.createWallet,
    this.cardData,
    this.ndefRecords,
  });

  factory CardConfigSdk.fromJson(Map<String, dynamic> json) => _$CardConfigSdkFromJson(json);

  Map<String, dynamic> toJson() => _$CardConfigSdkToJson(this);
}

@JsonSerializable()
class CardDataSdk {
  final String issuerName;
  final String batchId;
  final String blockchainName;
  @JsonKey(includeIfNull: false)
  final String tokenSymbol;
  @JsonKey(includeIfNull: false)
  final String tokenContractAddress;
  @JsonKey(includeIfNull: false)
  final int tokenDecimal;
  @JsonKey(includeIfNull: false)
  final List<int> manufacturerSignature;
  final String manufactureDateTime;
  final ProductMaskSdk productMask;

  CardDataSdk({
    this.productMask,
    this.issuerName,
    this.manufacturerSignature,
    this.batchId,
    this.blockchainName,
    this.manufactureDateTime,
    this.tokenSymbol,
    this.tokenContractAddress,
    this.tokenDecimal,
  });

  factory CardDataSdk.fromJson(Map<String, dynamic> json) => _$CardDataSdkFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataSdkToJson(this);
}

@JsonSerializable()
class SigningMethodMaskSdk {
  final int rawValue;

  SigningMethodMaskSdk(this.rawValue);

  factory SigningMethodMaskSdk.fromJson(Map<String, dynamic> json) => _$SigningMethodMaskSdkFromJson(json);

  Map<String, dynamic> toJson() => _$SigningMethodMaskSdkToJson(this);
}


@JsonSerializable()
class ProductMaskSdk {
  final int rawValue;

  ProductMaskSdk(this.rawValue);

  factory ProductMaskSdk.fromJson(Map<String, dynamic> json) => _$ProductMaskSdkFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMaskSdkToJson(this);
}

@JsonSerializable()
class NdefRecordSdk {
  final String type;
  final String value;

  NdefRecordSdk({this.type, this.value});

  factory NdefRecordSdk.fromJson(Map<String, dynamic> json) => _$NdefRecordSdkFromJson(json);

  Map<String, dynamic> toJson() => _$NdefRecordSdkToJson(this);
}