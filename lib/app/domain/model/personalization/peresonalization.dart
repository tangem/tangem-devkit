import 'dart:convert';
import 'dart:core';

import 'json.dart';

class PersonalizationConfig {
  String cVC;
  int maxSignatures;
  String pIN;
  String pIN2;
  String pIN3;
  int signingMethod;
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
  List<Ndef> ndef;
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
      {this.cVC,
      this.maxSignatures,
      this.pIN,
      this.pIN2,
      this.pIN3,
      this.signingMethod,
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

  PersonalizationConfig.fromJson(Map<String, dynamic> json) {
    cVC = json['CVC'];
    maxSignatures = json['MaxSignatures'];
    pIN = json['PIN'];
    pIN2 = json['PIN2'];
    pIN3 = json['PIN3'];
    signingMethod = json['SigningMethod'];
    allowSelectBlockchain = json['allowSelectBlockchain'];
    allowSwapPIN = json['allowSwapPIN'];
    allowSwapPIN2 = json['allowSwapPIN2'];
    cardData = json['cardData'] != null ? CardData.fromJson(json['cardData']) : null;
    checkPIN3onCard = json['checkPIN3onCard'];
    count = json['count'];
    createWallet = json['createWallet'];
    curveID = json['curveID'];
    disablePrecomputedNDEF = json['disablePrecomputedNDEF'];
    forbidDefaultPIN = json['forbidDefaultPIN'];
    forbidPurgeWallet = json['forbidPurgeWallet'];
    hexCrExKey = json['hexCrExKey'];
    isReusable = json['isReusable'];
    issuerName = json['issuerName'];
    if (json['ndef'] != null) {
      ndef = List<Ndef>();
      json['ndef'].forEach((v) {
        ndef.add(Ndef.fromJson(v));
      });
    }
    numberFormat = json['numberFormat'];
    pauseBeforePIN2 = json['pauseBeforePIN2'];
    protectIssuerDataAgainstReplay = json['protectIssuerDataAgainstReplay'];
    protocolAllowStaticEncryption = json['protocolAllowStaticEncryption'];
    protocolAllowUnencrypted = json['protocolAllowUnencrypted'];
    releaseVersion = json['releaseVersion'];
    requireTerminalCertSignature = json['requireTerminalCertSignature'];
    requireTerminalTxSignature = json['requireTerminalTxSignature'];
    restrictOverwriteIssuerDataEx = json['restrictOverwriteIssuerDataEx'];
    series = json['series'];
    skipCheckPIN2andCVCIfValidatedByIssuer = json['skipCheckPIN2andCVCIfValidatedByIssuer'];
    skipSecurityDelayIfValidatedByIssuer = json['skipSecurityDelayIfValidatedByIssuer'];
    skipSecurityDelayIfValidatedByLinkedTerminal = json['skipSecurityDelayIfValidatedByLinkedTerminal'];
    smartSecurityDelay = json['smartSecurityDelay'];
    startNumber = json['startNumber'];
    useActivation = json['useActivation'];
    useBlock = json['useBlock'];
    useCVC = json['useCVC'];
    useDynamicNDEF = json['useDynamicNDEF'];
    useNDEF = json['useNDEF'];
    useOneCommandAtTime = json['useOneCommandAtTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CVC'] = this.cVC;
    data['MaxSignatures'] = this.maxSignatures;
    data['PIN'] = this.pIN;
    data['PIN2'] = this.pIN2;
    data['PIN3'] = this.pIN3;
    data['SigningMethod'] = this.signingMethod;
    data['allowSelectBlockchain'] = this.allowSelectBlockchain;
    data['allowSwapPIN'] = this.allowSwapPIN;
    data['allowSwapPIN2'] = this.allowSwapPIN2;
    if (this.cardData != null) {
      data['cardData'] = this.cardData.toJson();
    }
    data['checkPIN3onCard'] = this.checkPIN3onCard;
    data['count'] = this.count;
    data['createWallet'] = this.createWallet;
    data['curveID'] = this.curveID;
    data['disablePrecomputedNDEF'] = this.disablePrecomputedNDEF;
    data['forbidDefaultPIN'] = this.forbidDefaultPIN;
    data['forbidPurgeWallet'] = this.forbidPurgeWallet;
    data['hexCrExKey'] = this.hexCrExKey;
    data['isReusable'] = this.isReusable;
    data['issuerName'] = this.issuerName;
    if (this.ndef != null) {
      data['ndef'] = this.ndef.map((v) => v.toJson()).toList();
    }
    data['numberFormat'] = this.numberFormat;
    data['pauseBeforePIN2'] = this.pauseBeforePIN2;
    data['protectIssuerDataAgainstReplay'] = this.protectIssuerDataAgainstReplay;
    data['protocolAllowStaticEncryption'] = this.protocolAllowStaticEncryption;
    data['protocolAllowUnencrypted'] = this.protocolAllowUnencrypted;
    data['releaseVersion'] = this.releaseVersion;
    data['requireTerminalCertSignature'] = this.requireTerminalCertSignature;
    data['requireTerminalTxSignature'] = this.requireTerminalTxSignature;
    data['restrictOverwriteIssuerDataEx'] = this.restrictOverwriteIssuerDataEx;
    data['series'] = this.series;
    data['skipCheckPIN2andCVCIfValidatedByIssuer'] = this.skipCheckPIN2andCVCIfValidatedByIssuer;
    data['skipSecurityDelayIfValidatedByIssuer'] = this.skipSecurityDelayIfValidatedByIssuer;
    data['skipSecurityDelayIfValidatedByLinkedTerminal'] = this.skipSecurityDelayIfValidatedByLinkedTerminal;
    data['smartSecurityDelay'] = this.smartSecurityDelay;
    data['startNumber'] = this.startNumber;
    data['useActivation'] = this.useActivation;
    data['useBlock'] = this.useBlock;
    data['useCVC'] = this.useCVC;
    data['useDynamicNDEF'] = this.useDynamicNDEF;
    data['useNDEF'] = this.useNDEF;
    data['useOneCommandAtTime'] = this.useOneCommandAtTime;
    return data;
  }

  static PersonalizationConfig getDefault(){
    final map = json.decode(DefaultPersonalizationJson.jsonString);
    return PersonalizationConfig.fromJson(map);
  }
}

class CardData {
  String batch;
  String blockchain;
  String date;
  String tokenSymbol;
  String tokenContractAddress;
  int tokenDeciaml;
  bool productIdCard;
  bool productIdIssuer;
  bool productNote;
  bool productTag;

  CardData({this.batch, this.blockchain, this.date, this.productIdCard, this.productIdIssuer, this.productNote, this.productTag});

  CardData.fromJson(Map<String, dynamic> json) {
    batch = json['batch'];
    blockchain = json['blockchain'];
    date = json['date'];
    tokenSymbol = json['token_symbol'];
    tokenContractAddress = json['token_contract_address'];
    tokenDeciaml = json['token_decimal'];
    productIdCard = json['product_id_card'];
    productIdIssuer = json['product_id_issuer'];
    productNote = json['product_note'];
    productTag = json['product_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['batch'] = this.batch;
    data['blockchain'] = this.blockchain;
    data['date'] = this.date;
    data['token_symbol'] = tokenSymbol;
    data['token_contract_address'] = tokenContractAddress;
    data['token_decimal'] = tokenDeciaml;
    data['product_id_card'] = this.productIdCard;
    data['product_id_issuer'] = this.productIdIssuer;
    data['product_note'] = this.productNote;
    data['product_tag'] = this.productTag;
    return data;
  }
}

class Ndef {
  String type;
  String value;

  Ndef({this.type, this.value});

  Ndef.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
