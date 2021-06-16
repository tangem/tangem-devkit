// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardConfigSdk _$CardConfigSdkFromJson(Map<String, dynamic> json) {
  return CardConfigSdk(
    json['pin'] as String,
    json['pin2'] as String,
    json['pin3'] as String,
    json['hexCrExKey'] as String,
    json['cvc'] as String,
    json['pauseBeforePin2'] as int,
    json['smartSecurityDelay'] as bool,
    json['curveID'] as String,
    (json['signingMethods'] as List<dynamic>).map((e) => e as String).toList(),
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
    CardData.fromJson(json['cardData'] as Map<String, dynamic>),
    (json['ndefRecords'] as List<dynamic>).map((e) => NdefRecordSdk.fromJson(e as Map<String, dynamic>)).toList(),
    issuerName: json['issuerName'] as String?,
    acquirerName: json['acquirerName'] as String?,
    series: json['series'] as String?,
    startNumber: json['startNumber'] as int,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$CardConfigSdkToJson(CardConfigSdk instance) => <String, dynamic>{
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
      'skipSecurityDelayIfValidatedByIssuer': instance.skipSecurityDelayIfValidatedByIssuer,
      'skipCheckPIN2CVCIfValidatedByIssuer': instance.skipCheckPIN2CVCIfValidatedByIssuer,
      'skipSecurityDelayIfValidatedByLinkedTerminal': instance.skipSecurityDelayIfValidatedByLinkedTerminal,
      'restrictOverwriteIssuerExtraData': instance.restrictOverwriteIssuerExtraData,
      'requireTerminalTxSignature': instance.requireTerminalTxSignature,
      'requireTerminalCertSignature': instance.requireTerminalCertSignature,
      'checkPIN3OnCard': instance.checkPIN3OnCard,
      'createWallet': instance.createWallet,
      'walletsCount': instance.walletsCount,
      'cardData': instance.cardData.toJson(),
      'ndefRecords': instance.ndefRecords.map((e) => e.toJson()).toList(),
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
      'dataKeyPair': instance.dataKeyPair.toJson(),
      'transactionKeyPair': instance.transactionKeyPair.toJson(),
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
      'keyPair': instance.keyPair.toJson(),
    };

Manufacturer _$ManufacturerFromJson(Map<String, dynamic> json) {
  return Manufacturer(
    json['name'] as String,
    KeyPairHex.fromJson(json['keyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ManufacturerToJson(Manufacturer instance) => <String, dynamic>{
      'name': instance.name,
      'keyPair': instance.keyPair.toJson(),
    };

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['body'] as String?,
    json['header'] as String?,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'body': instance.body,
      'header': instance.header,
    };

CardWallet _$CardWalletFromJson(Map<String, dynamic> json) {
  return CardWallet(
    json['index'] as int,
    json['status'] as String,
    json['curve'] as String?,
    (json['settingsMask'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['publicKey'] as String?,
    json['signedHashes'] as int?,
    json['remainingSignatures'] as int?,
  );
}

Map<String, dynamic> _$CardWalletToJson(CardWallet instance) => <String, dynamic>{
      'index': instance.index,
      'status': instance.status,
      'curve': instance.curve,
      'settingsMask': instance.settingsMask,
      'publicKey': instance.publicKey,
      'signedHashes': instance.signedHashes,
      'remainingSignatures': instance.remainingSignatures,
    };

FirmwareVersion _$FirmwareVersionFromJson(Map<String, dynamic> json) {
  return FirmwareVersion(
    json['version'] as String,
  );
}

Map<String, dynamic> _$FirmwareVersionToJson(FirmwareVersion instance) => <String, dynamic>{
      'version': instance.version,
    };

CardData _$CardDataFromJson(Map<String, dynamic> json) {
  return CardData(
    json['batchId'] as String?,
    json['blockchainName'] as String?,
    json['issuerName'] as String?,
    json['manufacturerSignature'] as String?,
    json['manufactureDateTime'] as String?,
    (json['productMask'] as List<dynamic>?)?.map((e) => e as String).toList(),
    tokenContractAddress: json['tokenContractAddress'] as String?,
    tokenSymbol: json['tokenSymbol'] as String?,
    tokenDecimal: json['tokenDecimal'] as int?,
  );
}

Map<String, dynamic> _$CardDataToJson(CardData instance) {
  final val = <String, dynamic>{
    'batchId': instance.batchId,
    'blockchainName': instance.blockchainName,
    'issuerName': instance.issuerName,
    'manufacturerSignature': instance.manufacturerSignature,
    'manufactureDateTime': instance.manufactureDateTime,
    'productMask': instance.productMask,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tokenContractAddress', instance.tokenContractAddress);
  writeNotNull('tokenSymbol', instance.tokenSymbol);
  writeNotNull('tokenDecimal', instance.tokenDecimal);
  return val;
}

KeyPairHex _$KeyPairHexFromJson(Map<String, dynamic> json) {
  return KeyPairHex(
    json['publicKey'] as String,
    json['privateKey'] as String,
  );
}

Map<String, dynamic> _$KeyPairHexToJson(KeyPairHex instance) => <String, dynamic>{
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
    };

NdefRecordSdk _$NdefRecordSdkFromJson(Map<String, dynamic> json) {
  return NdefRecordSdk(
    json['type'] as String,
    json['value'] as String,
  );
}

Map<String, dynamic> _$NdefRecordSdkToJson(NdefRecordSdk instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

DataProtectedByPasscodeHex _$DataProtectedByPasscodeHexFromJson(Map<String, dynamic> json) {
  return DataProtectedByPasscodeHex(
    json['data'] as String,
  );
}

Map<String, dynamic> _$DataProtectedByPasscodeHexToJson(DataProtectedByPasscodeHex instance) => <String, dynamic>{
      'data': instance.data,
    };

DataProtectedBySignatureHex _$DataProtectedBySignatureHexFromJson(Map<String, dynamic> json) {
  return DataProtectedBySignatureHex(
    json['data'] as String,
    json['counter'] as int,
    FileDataSignatureHex.fromJson(json['signature'] as Map<String, dynamic>),
    json['issuerPublicKey'] as String?,
  );
}

Map<String, dynamic> _$DataProtectedBySignatureHexToJson(DataProtectedBySignatureHex instance) => <String, dynamic>{
      'data': instance.data,
      'counter': instance.counter,
      'signature': instance.signature.toJson(),
      'issuerPublicKey': instance.issuerPublicKey,
    };

FileDataSignatureHex _$FileDataSignatureHexFromJson(Map<String, dynamic> json) {
  return FileDataSignatureHex(
    json['startingSignature'] as String,
    json['finalizingSignature'] as String,
  );
}

Map<String, dynamic> _$FileDataSignatureHexToJson(FileDataSignatureHex instance) => <String, dynamic>{
      'startingSignature': instance.startingSignature,
      'finalizingSignature': instance.finalizingSignature,
    };

FileHex _$FileHexFromJson(Map<String, dynamic> json) {
  return FileHex(
    json['fileIndex'] as int,
    json['fileData'] as String,
    _$enumDecodeNullable(_$FileSettingsEnumMap, json['fileSettings']),
  );
}

Map<String, dynamic> _$FileHexToJson(FileHex instance) => <String, dynamic>{
      'fileIndex': instance.fileIndex,
      'fileData': instance.fileData,
      'fileSettings': _$FileSettingsEnumMap[instance.fileSettings],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$FileSettingsEnumMap = {
  FileSettings.Public: 'Public',
  FileSettings.Private: 'Private',
};

ChangeFileSettings _$ChangeFileSettingsFromJson(Map<String, dynamic> json) {
  return ChangeFileSettings(
    json['fileIndex'] as int,
    _$enumDecode(_$FileSettingsEnumMap, json['settings']),
  );
}

Map<String, dynamic> _$ChangeFileSettingsToJson(ChangeFileSettings instance) => <String, dynamic>{
      'fileIndex': instance.fileIndex,
      'settings': _$FileSettingsEnumMap[instance.settings],
    };

FileHashDataHex _$FileHashDataHexFromJson(Map<String, dynamic> json) {
  return FileHashDataHex(
    json['startingHash'] as String,
    json['finalizingHash'] as String,
    json['startingSignature'] as String?,
    json['finalizingSignature'] as String?,
  );
}

Map<String, dynamic> _$FileHashDataHexToJson(FileHashDataHex instance) => <String, dynamic>{
      'startingHash': instance.startingHash,
      'finalizingHash': instance.finalizingHash,
      'startingSignature': instance.startingSignature,
      'finalizingSignature': instance.finalizingSignature,
    };

WalletConfig _$WalletConfigFromJson(Map<String, dynamic> json) {
  return WalletConfig(
    json['isReusable'] as bool?,
    json['prohibitPurgeWallet'] as bool?,
    json['curveId'] as String?,
    _$enumDecodeNullable(_$SigningMethodEnumMap, json['signingMethods']),
  );
}

Map<String, dynamic> _$WalletConfigToJson(WalletConfig instance) => <String, dynamic>{
      'isReusable': instance.isReusable,
      'prohibitPurgeWallet': instance.prohibitPurgeWallet,
      'curveId': instance.curveId,
      'signingMethods': _$SigningMethodEnumMap[instance.signingMethods],
    };

const _$SigningMethodEnumMap = {
  SigningMethod.SignHash: 'SignHash',
  SigningMethod.SignRaw: 'SignRaw',
  SigningMethod.SignHashSignedByIssuer: 'SignHashSignedByIssuer',
  SigningMethod.SignRawSignedByIssuer: 'SignRawSignedByIssuer',
  SigningMethod.SignHashSignedByIssuerAndUpdateIssuerData: 'SignHashSignedByIssuerAndUpdateIssuerData',
  SigningMethod.SignRawSignedByIssuerAndUpdateIssuerData: 'SignRawSignedByIssuerAndUpdateIssuerData',
  SigningMethod.SignPos: 'SignPos',
};
