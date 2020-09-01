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
    allowSetPIN1: json['allowSetPIN1'] as bool,
    allowSetPIN2: json['allowSetPIN2'] as bool,
    cardData: json['cardData'] == null
        ? null
        : PersonalizationCardData.fromJson(
            json['cardData'] as Map<String, dynamic>),
    checkPIN3OnCard: json['checkPIN3OnCard'] as bool,
    count: json['count'] as int,
    createWallet: json['createWallet'] as int,
    curveID: json['curveID'] as String,
    disablePrecomputedNDEF: json['disablePrecomputedNDEF'] as bool,
    prohibitDefaultPIN1: json['prohibitDefaultPIN1'] as bool,
    prohibitPurgeWallet: json['prohibitPurgeWallet'] as bool,
    hexCrExKey: json['hexCrExKey'] as String,
    isReusable: json['isReusable'] as bool,
    issuerName: json['issuerName'] as String,
    ndef: (json['ndef'] as List)
        ?.map((e) => e == null
            ? null
            : NdefRecordSdk.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    numberFormat: json['numberFormat'] as String,
    pauseBeforePIN2: json['pauseBeforePIN2'] as int,
    protectIssuerDataAgainstReplay:
        json['protectIssuerDataAgainstReplay'] as bool,
    allowFastEncryption:
        json['allowFastEncryption'] as bool,
    allowUnencrypted: json['allowUnencrypted'] as bool,
    releaseVersion: json['releaseVersion'] as bool,
    requireTerminalCertSignature: json['requireTerminalCertSignature'] as bool,
    requireTerminalTxSignature: json['requireTerminalTxSignature'] as bool,
    restrictOverwriteIssuerExtraData:
        json['restrictOverwriteIssuerExtraData'] as bool,
    series: json['series'] as String,
    skipCheckPIN2CVCIfValidatedByIssuer:
        json['skipCheckPIN2CVCIfValidatedByIssuer'] as bool,
    skipSecurityDelayIfValidatedByIssuer:
        json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    skipSecurityDelayIfValidatedByLinkedTerminal:
        json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    smartSecurityDelay: json['smartSecurityDelay'] as bool,
    startNumber: json['startNumber'] as int,
    useActivation: json['useActivation'] as bool,
    useBlock: json['useBlock'] as bool,
    useCvc: json['useCvc'] as bool,
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
      'allowSetPIN1': instance.allowSetPIN1,
      'allowSetPIN2': instance.allowSetPIN2,
      'cardData': instance.cardData,
      'checkPIN3OnCard': instance.checkPIN3OnCard,
      'count': instance.count,
      'createWallet': instance.createWallet,
      'curveID': instance.curveID,
      'disablePrecomputedNDEF': instance.disablePrecomputedNDEF,
      'prohibitDefaultPIN1': instance.prohibitDefaultPIN1,
      'prohibitPurgeWallet': instance.prohibitPurgeWallet,
      'hexCrExKey': instance.hexCrExKey,
      'isReusable': instance.isReusable,
      'issuerName': instance.issuerName,
      'ndef': instance.ndef,
      'numberFormat': instance.numberFormat,
      'pauseBeforePIN2': instance.pauseBeforePIN2,
      'protectIssuerDataAgainstReplay': instance.protectIssuerDataAgainstReplay,
      'allowFastEncryption': instance.allowFastEncryption,
      'allowUnencrypted': instance.allowUnencrypted,
      'releaseVersion': instance.releaseVersion,
      'requireTerminalCertSignature': instance.requireTerminalCertSignature,
      'requireTerminalTxSignature': instance.requireTerminalTxSignature,
      'restrictOverwriteIssuerExtraData': instance.restrictOverwriteIssuerExtraData,
      'series': instance.series,
      'skipCheckPIN2CVCIfValidatedByIssuer':
          instance.skipCheckPIN2CVCIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByIssuer':
          instance.skipSecurityDelayIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByLinkedTerminal':
          instance.skipSecurityDelayIfValidatedByLinkedTerminal,
      'smartSecurityDelay': instance.smartSecurityDelay,
      'startNumber': instance.startNumber,
      'useActivation': instance.useActivation,
      'useBlock': instance.useBlock,
      'useCvc': instance.useCvc,
      'useDynamicNDEF': instance.useDynamicNDEF,
      'useNDEF': instance.useNDEF,
      'useOneCommandAtTime': instance.useOneCommandAtTime,
    };

PersonalizationCardData _$PersonalizationCardDataFromJson(
    Map<String, dynamic> json) {
  return PersonalizationCardData(
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

Map<String, dynamic> _$PersonalizationCardDataToJson(
    PersonalizationCardData instance) {
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
