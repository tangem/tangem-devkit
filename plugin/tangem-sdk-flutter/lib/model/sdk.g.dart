// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardConfigSdk _$CardConfigSdkFromJson(Map<String, dynamic> json) {
  return CardConfigSdk(
    issuerName: json['issuerName'] as String,
    acquirerName: json['acquirerName'] as String,
    series: json['series'] as String,
    startNumber: json['startNumber'] as int,
    count: json['count'] as int,
    pin: json['pin'] as List<int>,
    pin2: json['pin2'] as List<int>,
    pin3: json['pin3'] as List<int>,
    hexCrExKey: json['hexCrExKey'] as String,
    cvc: json['cvc'] as String,
    pauseBeforePin2: json['pauseBeforePin2'] as int,
    smartSecurityDelay: json['smartSecurityDelay'] as bool,
    curveID: json['curveID'] as String,
    signingMethods: json['signingMethods'] == null
        ? null
        : SigningMethodMaskSdk.fromJson(
            json['signingMethods'] as Map<String, dynamic>),
    maxSignatures: json['maxSignatures'] as int,
    isReusable: json['isReusable'] as bool,
    allowSetPIN1: json['allowSetPIN1'] as bool,
    allowSetPIN2: json['allowSetPIN2'] as bool,
    useActivation: json['useActivation'] as bool,
    useCvc: json['useCvc'] as bool,
    useNDEF: json['useNDEF'] as bool,
    useDynamicNDEF: json['useDynamicNDEF'] as bool,
    useOneCommandAtTime: json['useOneCommandAtTime'] as bool,
    useBlock: json['useBlock'] as bool,
    allowSelectBlockchain: json['allowSelectBlockchain'] as bool,
    prohibitPurgeWallet: json['prohibitPurgeWallet'] as bool,
    allowUnencrypted: json['allowUnencrypted'] as bool,
    allowFastEncryption:
        json['allowFastEncryption'] as bool,
    protectIssuerDataAgainstReplay:
        json['protectIssuerDataAgainstReplay'] as bool,
    prohibitDefaultPIN1: json['prohibitDefaultPIN1'] as bool,
    disablePrecomputedNDEF: json['disablePrecomputedNDEF'] as bool,
    skipSecurityDelayIfValidatedByIssuer:
        json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    skipCheckPIN2CVCIfValidatedByIssuer:
        json['skipCheckPIN2CVCIfValidatedByIssuer'] as bool,
    skipSecurityDelayIfValidatedByLinkedTerminal:
        json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    restrictOverwriteIssuerExtraData:
        json['restrictOverwriteIssuerExtraData'] as bool,
    requireTerminalTxSignature: json['requireTerminalTxSignature'] as bool,
    requireTerminalCertSignature: json['requireTerminalCertSignature'] as bool,
    checkPIN3OnCard: json['checkPIN3OnCard'] as bool,
    createWallet: json['createWallet'] as bool,
    cardData: json['cardData'] == null
        ? null
        : CardDataSdk.fromJson(json['cardData'] as Map<String, dynamic>),
    ndefRecords: (json['ndefRecords'] as List)
        ?.map((e) => e == null
            ? null
            : NdefRecordSdk.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CardConfigSdkToJson(CardConfigSdk instance) =>
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
      'allowSetPIN1': instance.allowSetPIN1,
      'allowSetPIN2': instance.allowSetPIN2,
      'useActivation': instance.useActivation,
      'useCvc': instance.useCvc,
      'useNDEF': instance.useNDEF,
      'useDynamicNDEF': instance.useDynamicNDEF,
      'useOneCommandAtTime': instance.useOneCommandAtTime,
      'useBlock': instance.useBlock,
      'allowSelectBlockchain': instance.allowSelectBlockchain,
      'prohibitPurgeWallet': instance.prohibitPurgeWallet,
      'allowUnencrypted': instance.allowUnencrypted,
      'allowFastEncryption': instance.allowFastEncryption,
      'protectIssuerDataAgainstReplay': instance.protectIssuerDataAgainstReplay,
      'prohibitDefaultPIN1': instance.prohibitDefaultPIN1,
      'disablePrecomputedNDEF': instance.disablePrecomputedNDEF,
      'skipSecurityDelayIfValidatedByIssuer':
          instance.skipSecurityDelayIfValidatedByIssuer,
      'skipCheckPIN2CVCIfValidatedByIssuer':
          instance.skipCheckPIN2CVCIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByLinkedTerminal':
          instance.skipSecurityDelayIfValidatedByLinkedTerminal,
      'restrictOverwriteIssuerExtraData': instance.restrictOverwriteIssuerExtraData,
      'requireTerminalTxSignature': instance.requireTerminalTxSignature,
      'requireTerminalCertSignature': instance.requireTerminalCertSignature,
      'checkPIN3OnCard': instance.checkPIN3OnCard,
      'createWallet': instance.createWallet,
      'cardData': instance.cardData,
      'ndefRecords': instance.ndefRecords,
    };

CardDataSdk _$CardDataSdkFromJson(Map<String, dynamic> json) {
  return CardDataSdk(
    productMask: json['productMask'] == null
        ? null
        : ProductMaskSdk.fromJson(json['productMask'] as Map<String, dynamic>),
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

SigningMethodMaskSdk _$SigningMethodMaskSdkFromJson(Map<String, dynamic> json) {
  return SigningMethodMaskSdk(
    json['rawValue'] as int,
  );
}

Map<String, dynamic> _$SigningMethodMaskSdkToJson(
        SigningMethodMaskSdk instance) =>
    <String, dynamic>{
      'rawValue': instance.rawValue,
    };

ProductMaskSdk _$ProductMaskSdkFromJson(Map<String, dynamic> json) {
  return ProductMaskSdk(
    json['rawValue'] as int,
  );
}

Map<String, dynamic> _$ProductMaskSdkToJson(ProductMaskSdk instance) =>
    <String, dynamic>{
      'rawValue': instance.rawValue,
    };

NdefRecordSdk _$NdefRecordSdkFromJson(Map<String, dynamic> json) {
  return NdefRecordSdk(
    type: json['type'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$NdefRecordSdkToJson(NdefRecordSdk instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };
