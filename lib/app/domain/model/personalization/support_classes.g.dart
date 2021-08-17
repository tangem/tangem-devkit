// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizationConfig _$PersonalizationConfigFromJson(Map<String, dynamic> json) {
  return PersonalizationConfig(
    json['CVC'] as String,
    json['MaxSignatures'] as int,
    json['PIN'] as String,
    json['PIN2'] as String,
    json['PIN3'] as String,
    json['SigningMethod'] as int,
    json['allowSelectBlockchain'] as bool,
    json['allowSetPIN1'] as bool,
    json['allowSetPIN2'] as bool,
    PersonalizationCardData.fromJson(json['cardData'] as Map<String, dynamic>),
    json['checkPIN3OnCard'] as bool,
    json['count'] as int,
    json['createWallet'] as int,
    json['walletsCount'] as int,
    json['curveID'] as String,
    json['disablePrecomputedNDEF'] as bool,
    json['prohibitDefaultPIN1'] as bool,
    json['prohibitPurgeWallet'] as bool,
    json['hexCrExKey'] as String,
    json['isReusable'] as bool,
    json['issuerName'] as String,
    (json['ndef'] as List<dynamic>).map((e) => NdefRecordSdk.fromJson(e as Map<String, dynamic>)).toList(),
    json['numberFormat'] as String,
    json['pauseBeforePIN2'] as int,
    json['protectIssuerDataAgainstReplay'] as bool,
    json['allowFastEncryption'] as bool,
    json['allowUnencrypted'] as bool,
    json['releaseVersion'] as bool,
    json['requireTerminalCertSignature'] as bool,
    json['requireTerminalTxSignature'] as bool,
    json['restrictOverwriteIssuerExtraData'] as bool,
    json['series'] as String,
    json['skipCheckPIN2CVCIfValidatedByIssuer'] as bool,
    json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    json['smartSecurityDelay'] as bool,
    json['startNumber'] as int,
    json['useActivation'] as bool,
    json['useBlock'] as bool,
    json['useCvc'] as bool,
    json['useDynamicNDEF'] as bool,
    json['useNDEF'] as bool,
    json['useOneCommandAtTime'] as bool,
  );
}

Map<String, dynamic> _$PersonalizationConfigToJson(PersonalizationConfig instance) => <String, dynamic>{
      'CVC': instance.CVC,
      'MaxSignatures': instance.MaxSignatures,
      'PIN': instance.PIN,
      'PIN2': instance.PIN2,
      'PIN3': instance.PIN3,
      'SigningMethod': instance.SigningMethod,
      'allowSelectBlockchain': instance.allowSelectBlockchain,
      'allowSetPIN1': instance.allowSetPIN1,
      'allowSetPIN2': instance.allowSetPIN2,
      'cardData': instance.cardData.toJson(),
      'checkPIN3OnCard': instance.checkPIN3OnCard,
      'count': instance.count,
      'createWallet': instance.createWallet,
      'walletsCount': instance.walletsCount,
      'curveID': instance.curveID,
      'disablePrecomputedNDEF': instance.disablePrecomputedNDEF,
      'prohibitDefaultPIN1': instance.prohibitDefaultPIN1,
      'prohibitPurgeWallet': instance.prohibitPurgeWallet,
      'hexCrExKey': instance.hexCrExKey,
      'isReusable': instance.isReusable,
      'issuerName': instance.issuerName,
      'ndef': instance.ndef.map((e) => e.toJson()).toList(),
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
      'skipCheckPIN2CVCIfValidatedByIssuer': instance.skipCheckPIN2CVCIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByIssuer': instance.skipSecurityDelayIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByLinkedTerminal': instance.skipSecurityDelayIfValidatedByLinkedTerminal,
      'smartSecurityDelay': instance.smartSecurityDelay,
      'startNumber': instance.startNumber,
      'useActivation': instance.useActivation,
      'useBlock': instance.useBlock,
      'useCvc': instance.useCvc,
      'useDynamicNDEF': instance.useDynamicNDEF,
      'useNDEF': instance.useNDEF,
      'useOneCommandAtTime': instance.useOneCommandAtTime,
    };

PersonalizationCardData _$PersonalizationCardDataFromJson(Map<String, dynamic> json) {
  return PersonalizationCardData(
    json['batch'] as String,
    json['blockchain'] as String,
    json['product_id_card'] as bool,
    json['product_id_issuer'] as bool,
    json['product_note'] as bool,
    json['product_tag'] as bool,
    json['product_twin_card'] as bool,
    tokenSymbol: json['token_symbol'] as String?,
    tokenContractAddress: json['token_contract_address'] as String?,
    tokenDecimal: json['token_decimal'] as int?,
    date: json['date'] as String?,
  );
}

Map<String, dynamic> _$PersonalizationCardDataToJson(PersonalizationCardData instance) {
  final val = <String, dynamic>{
    'batch': instance.batch,
    'blockchain': instance.blockchain,
    'date': instance.date,
    'product_id_card': instance.productIdCard,
    'product_id_issuer': instance.productIdIssuer,
    'product_note': instance.productNote,
    'product_tag': instance.productTag,
    'product_twin_card': instance.productTwinCard,
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
