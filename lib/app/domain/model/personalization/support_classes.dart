import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/model/sdk.dart';

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
  bool allowSetPIN1;
  bool allowSetPIN2;
  PersonalizationCardData cardData;
  bool checkPIN3OnCard;
  int count;
  int createWallet;
  int walletsCount;
  String curveID;
  bool disablePrecomputedNDEF;
  bool prohibitDefaultPIN1;
  bool prohibitPurgeWallet;
  String hexCrExKey;
  bool isReusable;
  String issuerName;
  List<NdefRecordSdk> ndef;
  String numberFormat;
  int pauseBeforePIN2;
  bool protectIssuerDataAgainstReplay;
  bool allowFastEncryption;
  bool allowUnencrypted;
  bool releaseVersion;
  bool requireTerminalCertSignature;
  bool requireTerminalTxSignature;
  bool restrictOverwriteIssuerExtraData;
  String series;
  bool skipCheckPIN2CVCIfValidatedByIssuer;
  bool skipSecurityDelayIfValidatedByIssuer;
  bool skipSecurityDelayIfValidatedByLinkedTerminal;
  bool smartSecurityDelay;
  int startNumber;
  bool useActivation;
  bool useBlock;
  bool useCvc;
  bool useDynamicNDEF;
  bool useNDEF;
  bool useOneCommandAtTime;

  // "RequireTermTxSignature",
  // "RequireTermCertSignature",

  PersonalizationConfig(
      {this.CVC,
      this.MaxSignatures,
      this.PIN,
      this.PIN2,
      this.PIN3,
      this.SigningMethod,
      this.allowSelectBlockchain,
      this.allowSetPIN1,
      this.allowSetPIN2,
      this.cardData,
      this.checkPIN3OnCard,
      this.count,
      this.createWallet,
      this.walletsCount,
      this.curveID,
      this.disablePrecomputedNDEF,
      this.prohibitDefaultPIN1,
      this.prohibitPurgeWallet,
      this.hexCrExKey,
      this.isReusable,
      this.issuerName,
      this.ndef,
      this.numberFormat,
      this.pauseBeforePIN2,
      this.protectIssuerDataAgainstReplay,
      this.allowFastEncryption,
      this.allowUnencrypted,
      this.releaseVersion,
      this.requireTerminalCertSignature,
      this.requireTerminalTxSignature,
      this.restrictOverwriteIssuerExtraData,
      this.series,
      this.skipCheckPIN2CVCIfValidatedByIssuer,
      this.skipSecurityDelayIfValidatedByIssuer,
      this.skipSecurityDelayIfValidatedByLinkedTerminal,
      this.smartSecurityDelay,
      this.startNumber,
      this.useActivation,
      this.useBlock,
      this.useCvc,
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
class PersonalizationCardData {
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

  PersonalizationCardData({
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

  factory PersonalizationCardData.fromJson(Map<String, dynamic> json) => _$PersonalizationCardDataFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationCardDataToJson(this);
}