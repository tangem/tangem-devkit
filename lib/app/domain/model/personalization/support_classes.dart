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
  bool allowSwapPIN;
  bool allowSwapPIN2;
  PersonalizationCardData cardData;
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
  List<NdefRecordSdk> ndef;
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