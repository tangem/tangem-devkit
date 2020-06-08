// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizationConfig _$PersonalizationConfigFromJson(
    Map<String, dynamic> json) {
  return PersonalizationConfig(
    CVC: json['CVC'] as String,
    MaxSignatures: json['MaxSignatures'] as int,
    PIN: json['PIN'] as String,
    PIN2: json['PIN2'] as String,
    PIN3: json['PIN3'] as String,
    SigningMethod: json['SigningMethod'] as int,
    allowSelectBlockchain: json['allowSelectBlockchain'] as bool,
    allowSwapPIN: json['allowSwapPIN'] as bool,
    allowSwapPIN2: json['allowSwapPIN2'] as bool,
    cardData: json['cardData'] == null
        ? null
        : CardData.fromJson(json['cardData'] as Map<String, dynamic>),
    checkPIN3onCard: json['checkPIN3onCard'] as bool,
    count: json['count'] as int,
    createWallet: json['createWallet'] as int,
    curveID: json['curveID'] as String,
    disablePrecomputedNDEF: json['disablePrecomputedNDEF'] as bool,
    forbidDefaultPIN: json['forbidDefaultPIN'] as bool,
    forbidPurgeWallet: json['forbidPurgeWallet'] as bool,
    hexCrExKey: json['hexCrExKey'] as String,
    isReusable: json['isReusable'] as bool,
    issuerName: json['issuerName'] as String,
    ndef: (json['ndef'] as List)
        ?.map((e) =>
            e == null ? null : NdefRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    numberFormat: json['numberFormat'] as String,
    pauseBeforePIN2: json['pauseBeforePIN2'] as int,
    protectIssuerDataAgainstReplay:
        json['protectIssuerDataAgainstReplay'] as bool,
    protocolAllowStaticEncryption:
        json['protocolAllowStaticEncryption'] as bool,
    protocolAllowUnencrypted: json['protocolAllowUnencrypted'] as bool,
    releaseVersion: json['releaseVersion'] as bool,
    requireTerminalCertSignature: json['requireTerminalCertSignature'] as bool,
    requireTerminalTxSignature: json['requireTerminalTxSignature'] as bool,
    restrictOverwriteIssuerDataEx:
        json['restrictOverwriteIssuerDataEx'] as bool,
    series: json['series'] as String,
    skipCheckPIN2andCVCIfValidatedByIssuer:
        json['skipCheckPIN2andCVCIfValidatedByIssuer'] as bool,
    skipSecurityDelayIfValidatedByIssuer:
        json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    skipSecurityDelayIfValidatedByLinkedTerminal:
        json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    smartSecurityDelay: json['smartSecurityDelay'] as bool,
    startNumber: json['startNumber'] as int,
    useActivation: json['useActivation'] as bool,
    useBlock: json['useBlock'] as bool,
    useCVC: json['useCVC'] as bool,
    useDynamicNDEF: json['useDynamicNDEF'] as bool,
    useNDEF: json['useNDEF'] as bool,
    useOneCommandAtTime: json['useOneCommandAtTime'] as bool,
  );
}

Map<String, dynamic> _$PersonalizationConfigToJson(
        PersonalizationConfig instance) =>
    <String, dynamic>{
      'CVC': instance.CVC,
      'MaxSignatures': instance.MaxSignatures,
      'PIN': instance.PIN,
      'PIN2': instance.PIN2,
      'PIN3': instance.PIN3,
      'SigningMethod': instance.SigningMethod,
      'allowSelectBlockchain': instance.allowSelectBlockchain,
      'allowSwapPIN': instance.allowSwapPIN,
      'allowSwapPIN2': instance.allowSwapPIN2,
      'cardData': instance.cardData,
      'checkPIN3onCard': instance.checkPIN3onCard,
      'count': instance.count,
      'createWallet': instance.createWallet,
      'curveID': instance.curveID,
      'disablePrecomputedNDEF': instance.disablePrecomputedNDEF,
      'forbidDefaultPIN': instance.forbidDefaultPIN,
      'forbidPurgeWallet': instance.forbidPurgeWallet,
      'hexCrExKey': instance.hexCrExKey,
      'isReusable': instance.isReusable,
      'issuerName': instance.issuerName,
      'ndef': instance.ndef,
      'numberFormat': instance.numberFormat,
      'pauseBeforePIN2': instance.pauseBeforePIN2,
      'protectIssuerDataAgainstReplay': instance.protectIssuerDataAgainstReplay,
      'protocolAllowStaticEncryption': instance.protocolAllowStaticEncryption,
      'protocolAllowUnencrypted': instance.protocolAllowUnencrypted,
      'releaseVersion': instance.releaseVersion,
      'requireTerminalCertSignature': instance.requireTerminalCertSignature,
      'requireTerminalTxSignature': instance.requireTerminalTxSignature,
      'restrictOverwriteIssuerDataEx': instance.restrictOverwriteIssuerDataEx,
      'series': instance.series,
      'skipCheckPIN2andCVCIfValidatedByIssuer':
          instance.skipCheckPIN2andCVCIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByIssuer':
          instance.skipSecurityDelayIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByLinkedTerminal':
          instance.skipSecurityDelayIfValidatedByLinkedTerminal,
      'smartSecurityDelay': instance.smartSecurityDelay,
      'startNumber': instance.startNumber,
      'useActivation': instance.useActivation,
      'useBlock': instance.useBlock,
      'useCVC': instance.useCVC,
      'useDynamicNDEF': instance.useDynamicNDEF,
      'useNDEF': instance.useNDEF,
      'useOneCommandAtTime': instance.useOneCommandAtTime,
    };

CardData _$CardDataFromJson(Map<String, dynamic> json) {
  return CardData(
    tokenSymbol: json['token_symbol'] as String,
    tokenContractAddress: json['token_contract_address'] as String,
    tokenDecimal: json['token_decimal'] as int,
    batch: json['batch'] as String,
    blockchain: json['blockchain'] as String,
    date: json['date'] as String,
    productIdCard: json['product_id_card'] as bool,
    productIdIssuer: json['product_id_issuer'] as bool,
    productNote: json['product_note'] as bool,
    productTag: json['product_tag'] as bool,
  );
}

Map<String, dynamic> _$CardDataToJson(CardData instance) {
  final val = <String, dynamic>{
    'batch': instance.batch,
    'blockchain': instance.blockchain,
    'date': instance.date,
    'product_id_card': instance.productIdCard,
    'product_id_issuer': instance.productIdIssuer,
    'product_note': instance.productNote,
    'product_tag': instance.productTag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token_symbol', instance.tokenSymbol);
  writeNotNull('token_contract_address', instance.tokenContractAddress);
  writeNotNull('token_decimal', instance.tokenDecimal);
  return val;
}

CardDataSdk _$CardDataSdkFromJson(Map<String, dynamic> json) {
  return CardDataSdk(
    productMask: json['productMask'] == null
        ? null
        : ProductMask.fromJson(json['productMask'] as Map<String, dynamic>),
    issuerName: json['issuerName'] as String,
    manufacturerSignature:
        (json['manufacturerSignature'] as List)?.map((e) => e as int)?.toList(),
    batchId: json['batchId'] as String,
    blockchainName: json['blockchainName'] as String,
    manufactureDateTime: json['manufactureDateTime'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenContractAddress: json['tokenContractAddress'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
  );
}

Map<String, dynamic> _$CardDataSdkToJson(CardDataSdk instance) {
  final val = <String, dynamic>{
    'issuerName': instance.issuerName,
    'batchId': instance.batchId,
    'blockchainName': instance.blockchainName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tokenSymbol', instance.tokenSymbol);
  writeNotNull('tokenContractAddress', instance.tokenContractAddress);
  writeNotNull('tokenDecimal', instance.tokenDecimal);
  writeNotNull('manufacturerSignature', instance.manufacturerSignature);
  val['manufactureDateTime'] = instance.manufactureDateTime;
  val['productMask'] = instance.productMask;
  return val;
}

CardConfig _$CardConfigFromJson(Map<String, dynamic> json) {
  return CardConfig(
    issuerName: json['issuerName'] as String,
    acquirerName: json['acquirerName'] as String,
    series: json['series'] as String,
    startNumber: json['startNumber'] as int,
    count: json['count'] as int,
    pin: json['pin'] as String,
    pin2: json['pin2'] as String,
    pin3: json['pin3'] as String,
    hexCrExKey: json['hexCrExKey'] as String,
    cvc: json['cvc'] as String,
    pauseBeforePin2: json['pauseBeforePin2'] as int,
    smartSecurityDelay: json['smartSecurityDelay'] as bool,
    curveID: json['curveID'] as String,
    signingMethods: json['signingMethods'] == null
        ? null
        : SigningMethodMask.fromJson(
            json['signingMethods'] as Map<String, dynamic>),
    maxSignatures: json['maxSignatures'] as int,
    isReusable: json['isReusable'] as bool,
    allowSwapPin: json['allowSwapPin'] as bool,
    allowSwapPin2: json['allowSwapPin2'] as bool,
    useActivation: json['useActivation'] as bool,
    useCvc: json['useCvc'] as bool,
    useNdef: json['useNdef'] as bool,
    useDynamicNdef: json['useDynamicNdef'] as bool,
    useOneCommandAtTime: json['useOneCommandAtTime'] as bool,
    useBlock: json['useBlock'] as bool,
    allowSelectBlockchain: json['allowSelectBlockchain'] as bool,
    forbidPurgeWallet: json['forbidPurgeWallet'] as bool,
    protocolAllowUnencrypted: json['protocolAllowUnencrypted'] as bool,
    protocolAllowStaticEncryption:
        json['protocolAllowStaticEncryption'] as bool,
    protectIssuerDataAgainstReplay:
        json['protectIssuerDataAgainstReplay'] as bool,
    forbidDefaultPin: json['forbidDefaultPin'] as bool,
    disablePrecomputedNdef: json['disablePrecomputedNdef'] as bool,
    skipSecurityDelayIfValidatedByIssuer:
        json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    skipCheckPIN2andCVCIfValidatedByIssuer:
        json['skipCheckPIN2andCVCIfValidatedByIssuer'] as bool,
    skipSecurityDelayIfValidatedByLinkedTerminal:
        json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    restrictOverwriteIssuerDataEx:
        json['restrictOverwriteIssuerDataEx'] as bool,
    requireTerminalTxSignature: json['requireTerminalTxSignature'] as bool,
    requireTerminalCertSignature: json['requireTerminalCertSignature'] as bool,
    checkPin3onCard: json['checkPin3onCard'] as bool,
    createWallet: json['createWallet'] as bool,
    cardData: json['cardData'] == null
        ? null
        : CardDataSdk.fromJson(json['cardData'] as Map<String, dynamic>),
    ndefRecords: (json['ndefRecords'] as List)
        ?.map((e) =>
            e == null ? null : NdefRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CardConfigToJson(CardConfig instance) =>
    <String, dynamic>{
      'issuerName': instance.issuerName,
      'acquirerName': instance.acquirerName,
      'series': instance.series,
      'startNumber': instance.startNumber,
      'count': instance.count,
      'pin': instance.pin,
      'pin2': instance.pin2,
      'pin3': instance.pin3,
      'hexCrExKey': instance.hexCrExKey,
      'cvc': instance.cvc,
      'pauseBeforePin2': instance.pauseBeforePin2,
      'smartSecurityDelay': instance.smartSecurityDelay,
      'curveID': instance.curveID,
      'signingMethods': instance.signingMethods,
      'maxSignatures': instance.maxSignatures,
      'isReusable': instance.isReusable,
      'allowSwapPin': instance.allowSwapPin,
      'allowSwapPin2': instance.allowSwapPin2,
      'useActivation': instance.useActivation,
      'useCvc': instance.useCvc,
      'useNdef': instance.useNdef,
      'useDynamicNdef': instance.useDynamicNdef,
      'useOneCommandAtTime': instance.useOneCommandAtTime,
      'useBlock': instance.useBlock,
      'allowSelectBlockchain': instance.allowSelectBlockchain,
      'forbidPurgeWallet': instance.forbidPurgeWallet,
      'protocolAllowUnencrypted': instance.protocolAllowUnencrypted,
      'protocolAllowStaticEncryption': instance.protocolAllowStaticEncryption,
      'protectIssuerDataAgainstReplay': instance.protectIssuerDataAgainstReplay,
      'forbidDefaultPin': instance.forbidDefaultPin,
      'disablePrecomputedNdef': instance.disablePrecomputedNdef,
      'skipSecurityDelayIfValidatedByIssuer':
          instance.skipSecurityDelayIfValidatedByIssuer,
      'skipCheckPIN2andCVCIfValidatedByIssuer':
          instance.skipCheckPIN2andCVCIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByLinkedTerminal':
          instance.skipSecurityDelayIfValidatedByLinkedTerminal,
      'restrictOverwriteIssuerDataEx': instance.restrictOverwriteIssuerDataEx,
      'requireTerminalTxSignature': instance.requireTerminalTxSignature,
      'requireTerminalCertSignature': instance.requireTerminalCertSignature,
      'checkPin3onCard': instance.checkPin3onCard,
      'createWallet': instance.createWallet,
      'cardData': instance.cardData,
      'ndefRecords': instance.ndefRecords,
    };

NdefRecord _$NdefRecordFromJson(Map<String, dynamic> json) {
  return NdefRecord(
    type: json['type'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$NdefRecordToJson(NdefRecord instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

ProductMask _$ProductMaskFromJson(Map<String, dynamic> json) {
  return ProductMask(
    json['rawValue'] as int,
  );
}

Map<String, dynamic> _$ProductMaskToJson(ProductMask instance) =>
    <String, dynamic>{
      'rawValue': instance.rawValue,
    };

SigningMethodMask _$SigningMethodMaskFromJson(Map<String, dynamic> json) {
  return SigningMethodMask(
    json['rawValue'] as int,
  );
}

Map<String, dynamic> _$SigningMethodMaskToJson(SigningMethodMask instance) =>
    <String, dynamic>{
      'rawValue': instance.rawValue,
    };
