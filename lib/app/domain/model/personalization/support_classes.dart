import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'json.dart';

part 'support_classes.g.dart';

@JsonSerializable()
class PersonalizationConfig {
  String CVC;
  int MaxSignatures;
  String PIN;
  String PIN2;
  String PIN3;
  int SigningMethod;
  bool allowSelectBlockchain;
  bool allowSwapPIN;
  bool allowSwapPIN2;
  CardData cardData;
  bool checkPIN3onCard;
  int count;
  int createWallet;
  String curveID;
  bool disablePrecomputedNDEF;
  bool forbidDefaultPIN;
  bool forbidPurgeWallet;
  String hexCrExKey;
  bool isReusable;
  String issuerName;
  List<NdefRecord> ndef;
  String numberFormat;
  int pauseBeforePIN2;
  bool protectIssuerDataAgainstReplay;
  bool protocolAllowStaticEncryption;
  bool protocolAllowUnencrypted;
  bool releaseVersion;
  bool requireTerminalCertSignature;
  bool requireTerminalTxSignature;
  bool restrictOverwriteIssuerDataEx;
  String series;
  bool skipCheckPIN2andCVCIfValidatedByIssuer;
  bool skipSecurityDelayIfValidatedByIssuer;
  bool skipSecurityDelayIfValidatedByLinkedTerminal;
  bool smartSecurityDelay;
  int startNumber;
  bool useActivation;
  bool useBlock;
  bool useCVC;
  bool useDynamicNDEF;
  bool useNDEF;
  bool useOneCommandAtTime;

  PersonalizationConfig(
      {this.CVC,
      this.MaxSignatures,
      this.PIN,
      this.PIN2,
      this.PIN3,
      this.SigningMethod,
      this.allowSelectBlockchain,
      this.allowSwapPIN,
      this.allowSwapPIN2,
      this.cardData,
      this.checkPIN3onCard,
      this.count,
      this.createWallet,
      this.curveID,
      this.disablePrecomputedNDEF,
      this.forbidDefaultPIN,
      this.forbidPurgeWallet,
      this.hexCrExKey,
      this.isReusable,
      this.issuerName,
      this.ndef,
      this.numberFormat,
      this.pauseBeforePIN2,
      this.protectIssuerDataAgainstReplay,
      this.protocolAllowStaticEncryption,
      this.protocolAllowUnencrypted,
      this.releaseVersion,
      this.requireTerminalCertSignature,
      this.requireTerminalTxSignature,
      this.restrictOverwriteIssuerDataEx,
      this.series,
      this.skipCheckPIN2andCVCIfValidatedByIssuer,
      this.skipSecurityDelayIfValidatedByIssuer,
      this.skipSecurityDelayIfValidatedByLinkedTerminal,
      this.smartSecurityDelay,
      this.startNumber,
      this.useActivation,
      this.useBlock,
      this.useCVC,
      this.useDynamicNDEF,
      this.useNDEF,
      this.useOneCommandAtTime});

  static PersonalizationConfig getDefault() {
    final map = json.decode(DefaultPersonalizationJson.jsonString);
    return PersonalizationConfig.fromJson(map);
  }

  factory PersonalizationConfig.fromJson(Map<String, dynamic> json) => _$PersonalizationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationConfigToJson(this);
}

@JsonSerializable()
class CardData {
  String batch;
  String blockchain;
  String date;
  @JsonKey(name: 'product_id_card')
  bool productIdCard;
  @JsonKey(name: 'product_id_issuer')
  bool productIdIssuer;
  @JsonKey(name: 'product_note')
  bool productNote;
  @JsonKey(name: 'product_tag')
  bool productTag;
  @JsonKey(name: 'token_symbol', includeIfNull: false)
  String tokenSymbol;
  @JsonKey(name: 'token_contract_address', includeIfNull: false)
  String tokenContractAddress;
  @JsonKey(name: 'token_decimal', includeIfNull: false)
  int tokenDecimal;

  CardData({
    this.tokenSymbol,
    this.tokenContractAddress,
    this.tokenDecimal,
    this.batch,
    this.blockchain,
    this.date,
    this.productIdCard,
    this.productIdIssuer,
    this.productNote,
    this.productTag,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
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
  final ProductMask productMask;

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
class CardConfig {
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
  final SigningMethodMask signingMethods;
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
  final List<NdefRecord> ndefRecords;

  CardConfig({
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

  factory CardConfig.fromJson(Map<String, dynamic> json) => _$CardConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CardConfigToJson(this);
}

@JsonSerializable()
class NdefRecord {
  final String type;
  final String value;

  NdefRecord({this.type, this.value});

  factory NdefRecord.fromJson(Map<String, dynamic> json) => _$NdefRecordFromJson(json);

  Map<String, dynamic> toJson() => _$NdefRecordToJson(this);
}

@JsonSerializable()
class ProductMask {
  final int rawValue;

  ProductMask(this.rawValue);

  factory ProductMask.fromJson(Map<String, dynamic> json) => _$ProductMaskFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMaskToJson(this);
}

@JsonSerializable()
class SigningMethodMask {
  final int rawValue;

  SigningMethodMask(this.rawValue);

  factory SigningMethodMask.fromJson(Map<String, dynamic> json) => _$SigningMethodMaskFromJson(json);

  Map<String, dynamic> toJson() => _$SigningMethodMaskToJson(this);
}
