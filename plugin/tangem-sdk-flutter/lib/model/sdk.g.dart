// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardConfigSdk _$CardConfigSdkFromJson(Map<String, dynamic> json) {
  return CardConfigSdk(
    (json['pin'] as List<dynamic>).map((e) => e as int).toList(),
    (json['pin2'] as List<dynamic>).map((e) => e as int).toList(),
    (json['pin3'] as List<dynamic>).map((e) => e as int).toList(),
    json['hexCrExKey'] as String,
    json['cvc'] as String,
    json['pauseBeforePin2'] as int,
    json['smartSecurityDelay'] as bool,
    json['curveID'] as String,
    SigningMethodMaskSdk.fromJson(
        json['signingMethods'] as Map<String, dynamic>),
    json['maxSignatures'] as int,
    json['isReusable'] as bool,
    json['allowSetPIN1'] as bool,
    json['allowSetPIN2'] as bool,
    json['useActivation'] as bool,
    json['useCvc'] as bool,
    json['useNDEF'] as bool,
    json['useDynamicNDEF'] as bool,
    json['useOneCommandAtTime'] as bool,
    json['useBlock'] as bool,
    json['allowSelectBlockchain'] as bool,
    json['prohibitPurgeWallet'] as bool,
    json['allowUnencrypted'] as bool,
    json['allowFastEncryption'] as bool,
    json['protectIssuerDataAgainstReplay'] as bool,
    json['prohibitDefaultPIN1'] as bool,
    json['disablePrecomputedNDEF'] as bool,
    json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    json['skipCheckPIN2CVCIfValidatedByIssuer'] as bool,
    json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    json['restrictOverwriteIssuerExtraData'] as bool,
    json['requireTerminalTxSignature'] as bool,
    json['requireTerminalCertSignature'] as bool,
    json['checkPIN3OnCard'] as bool,
    json['createWallet'] as bool,
    json['walletsCount'] as int,
    CardDataSdk.fromJson(json['cardData'] as Map<String, dynamic>),
    (json['ndefRecords'] as List<dynamic>)
        .map((e) => NdefRecordSdk.fromJson(e as Map<String, dynamic>))
        .toList(),
    issuerName: json['issuerName'] as String?,
    acquirerName: json['acquirerName'] as String?,
    series: json['series'] as String?,
    startNumber: json['startNumber'] as int,
    count: json['count'] as int,
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
      'restrictOverwriteIssuerExtraData':
          instance.restrictOverwriteIssuerExtraData,
      'requireTerminalTxSignature': instance.requireTerminalTxSignature,
      'requireTerminalCertSignature': instance.requireTerminalCertSignature,
      'checkPIN3OnCard': instance.checkPIN3OnCard,
      'createWallet': instance.createWallet,
      'walletsCount': instance.walletsCount,
      'cardData': instance.cardData,
      'ndefRecords': instance.ndefRecords,
    };

Issuer _$IssuerFromJson(Map<String, dynamic> json) {
  return Issuer(
    json['name'] as String,
    json['id'] as String,
    KeyPairHex.fromJson(json['dataKeyPair'] as Map<String, dynamic>),
    KeyPairHex.fromJson(json['transactionKeyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IssuerToJson(Issuer instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'dataKeyPair': instance.dataKeyPair,
      'transactionKeyPair': instance.transactionKeyPair,
    };

Acquirer _$AcquirerFromJson(Map<String, dynamic> json) {
  return Acquirer(
    json['name'] as String,
    json['id'] as String,
    KeyPairHex.fromJson(json['keyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AcquirerToJson(Acquirer instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'keyPair': instance.keyPair,
    };

Manufacturer _$ManufacturerFromJson(Map<String, dynamic> json) {
  return Manufacturer(
    json['name'] as String,
    KeyPairHex.fromJson(json['keyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ManufacturerToJson(Manufacturer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'keyPair': instance.keyPair,
    };

KeyPairHex _$KeyPairHexFromJson(Map<String, dynamic> json) {
  return KeyPairHex(
    json['publicKey'] as String,
    json['privateKey'] as String,
  );
}

Map<String, dynamic> _$KeyPairHexToJson(KeyPairHex instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
    };

CardDataSdk _$CardDataSdkFromJson(Map<String, dynamic> json) {
  return CardDataSdk(
    json['issuerName'] as String,
    json['batchId'] as String,
    json['blockchainName'] as String,
    json['manufactureDateTime'] as String,
    ProductMaskSdk.fromJson(json['productMask'] as Map<String, dynamic>),
    manufacturerSignature: (json['manufacturerSignature'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
    tokenSymbol: json['tokenSymbol'] as String?,
    tokenContractAddress: json['tokenContractAddress'] as String?,
    tokenDecimal: json['tokenDecimal'] as int?,
  );
}

Map<String, dynamic> _$CardDataSdkToJson(CardDataSdk instance) {
  final val = <String, dynamic>{
    'issuerName': instance.issuerName,
    'batchId': instance.batchId,
    'blockchainName': instance.blockchainName,
    'manufactureDateTime': instance.manufactureDateTime,
    'productMask': instance.productMask,
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
    json['type'] as String,
    json['value'] as String,
  );
}

Map<String, dynamic> _$NdefRecordSdkToJson(NdefRecordSdk instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

DataProtectedByPasscodeHex _$DataProtectedByPasscodeHexFromJson(
    Map<String, dynamic> json) {
  return DataProtectedByPasscodeHex(
    json['data'] as String,
  );
}

Map<String, dynamic> _$DataProtectedByPasscodeHexToJson(
        DataProtectedByPasscodeHex instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataProtectedBySignatureHex _$DataProtectedBySignatureHexFromJson(
    Map<String, dynamic> json) {
  return DataProtectedBySignatureHex(
    json['data'] as String,
    json['counter'] as int,
    FileDataSignatureHex.fromJson(json['signature'] as Map<String, dynamic>),
    json['issuerPublicKey'] as String?,
  );
}

Map<String, dynamic> _$DataProtectedBySignatureHexToJson(
        DataProtectedBySignatureHex instance) =>
    <String, dynamic>{
      'data': instance.data,
      'counter': instance.counter,
      'signature': instance.signature,
      'issuerPublicKey': instance.issuerPublicKey,
    };

FileDataSignatureHex _$FileDataSignatureHexFromJson(Map<String, dynamic> json) {
  return FileDataSignatureHex(
    json['startingSignature'] as String,
    json['finalizingSignature'] as String,
  );
}

Map<String, dynamic> _$FileDataSignatureHexToJson(
        FileDataSignatureHex instance) =>
    <String, dynamic>{
      'startingSignature': instance.startingSignature,
      'finalizingSignature': instance.finalizingSignature,
    };
