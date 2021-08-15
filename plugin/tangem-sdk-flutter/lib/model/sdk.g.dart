// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalizationCardConfig _$PersonalizationCardConfigFromJson(Map<String, dynamic> json) {
  return PersonalizationCardConfig(
    json['releaseVersion'] as bool,
    json['issuerName'] as String,
    json['series'] as String?,
    json['startNumber'] as int,
    json['count'] as int,
    json['numberFormat'] as String,
    json['PIN'] as String,
    json['PIN2'] as String,
    json['PIN3'] as String?,
    json['hexCrExKey'] as String?,
    json['CVC'] as String,
    json['pauseBeforePIN2'] as int,
    json['smartSecurityDelay'] as bool,
    json['curveID'] as String,
    _deserializeSigningMethod(json['SigningMethod']),
    json['MaxSignatures'] as int?,
    json['allowSwapPIN'] as bool,
    json['allowSwapPIN2'] as bool,
    json['useActivation'] as bool,
    json['useCVC'] as bool,
    json['useNDEF'] as bool,
    json['useDynamicNDEF'] as bool?,
    json['useOneCommandAtTime'] as bool?,
    json['useBlock'] as bool,
    json['allowSelectBlockchain'] as bool,
    json['forbidPurgeWallet'] as bool,
    json['protocolAllowUnencrypted'] as bool,
    json['protocolAllowStaticEncryption'] as bool,
    json['protectIssuerDataAgainstReplay'] as bool?,
    json['forbidDefaultPIN'] as bool,
    json['disablePrecomputedNDEF'] as bool?,
    json['skipSecurityDelayIfValidatedByIssuer'] as bool,
    json['skipCheckPIN2andCVCIfValidatedByIssuer'] as bool,
    json['skipSecurityDelayIfValidatedByLinkedTerminal'] as bool,
    json['restrictOverwriteIssuerDataEx'] as bool?,
    json['disableIssuerData'] as bool?,
    json['disableUserData'] as bool?,
    json['disableFiles'] as bool?,
    json['createWallet'] as int,
    CardConfigData.fromJson(json['cardData'] as Map<String, dynamic>),
    (json['NDEF'] as List<dynamic>).map((e) => NdefRecordSdk.fromJson(e as Map<String, dynamic>)).toList(),
    json['walletsCount'] as int?,
  );
}

Map<String, dynamic> _$PersonalizationCardConfigToJson(PersonalizationCardConfig instance) {
  final val = <String, dynamic>{
    'releaseVersion': instance.releaseVersion,
    'issuerName': instance.issuerName,
    'series': instance.series,
    'startNumber': instance.startNumber,
    'count': instance.count,
    'numberFormat': instance.numberFormat,
    'PIN': instance.pin,
    'PIN2': instance.pin2,
    'PIN3': instance.pin3,
    'hexCrExKey': instance.hexCrExKey,
    'CVC': instance.cvc,
    'pauseBeforePIN2': instance.pauseBeforePin2,
    'smartSecurityDelay': instance.smartSecurityDelay,
    'curveID': instance.curveID,
    'SigningMethod': instance.signingMethod,
    'MaxSignatures': instance.maxSignatures,
    'allowSwapPIN': instance.allowSetPIN1,
    'allowSwapPIN2': instance.allowSetPIN2,
    'useActivation': instance.useActivation,
    'useCVC': instance.useCvc,
    'useNDEF': instance.useNDEF,
    'useDynamicNDEF': instance.useDynamicNDEF,
    'useOneCommandAtTime': instance.useOneCommandAtTime,
    'useBlock': instance.useBlock,
    'allowSelectBlockchain': instance.allowSelectBlockchain,
    'forbidPurgeWallet': instance.prohibitPurgeWallet,
    'protocolAllowUnencrypted': instance.allowUnencrypted,
    'protocolAllowStaticEncryption': instance.allowFastEncryption,
    'protectIssuerDataAgainstReplay': instance.protectIssuerDataAgainstReplay,
    'forbidDefaultPIN': instance.prohibitDefaultPIN1,
    'disablePrecomputedNDEF': instance.disablePrecomputedNDEF,
    'skipSecurityDelayIfValidatedByIssuer': instance.skipSecurityDelayIfValidatedByIssuer,
    'skipCheckPIN2andCVCIfValidatedByIssuer': instance.skipCheckPIN2CVCIfValidatedByIssuer,
    'skipSecurityDelayIfValidatedByLinkedTerminal': instance.skipSecurityDelayIfValidatedByLinkedTerminal,
    'restrictOverwriteIssuerDataEx': instance.restrictOverwriteIssuerDataEx,
    'cardData': instance.cardData.toJson(),
    'NDEF': instance.ndefRecords.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('disableIssuerData', instance.disableIssuerData);
  writeNotNull('disableUserData', instance.disableUserData);
  writeNotNull('disableFiles', instance.disableFiles);
  val['createWallet'] = instance.createWallet;
  val['walletsCount'] = instance.walletsCount;
  return val;
}

List<String> _deserializeSigningMethod(dynamic rawMethod) {
  if (rawMethod is int) {
    final methods = SigningMethod.values.mapNotNull((e) => rawMethod.contains(e) ? e : null);
    return methods.enumToStringList();
  } else if (rawMethod is List) {
    return rawMethod.map((e) => e.toString()).toList();
  } else {
    return [];
  }
}

CardConfigData _$CardConfigDataFromJson(Map<String, dynamic> json) {
  return CardConfigData(
    json['date'] as String?,
    json['batch'] as String,
    json['blockchain'] as String,
    json['product_note'] as bool?,
    json['product_tag'] as bool?,
    json['product_id_card'] as bool?,
    json['product_id_issuer'] as bool?,
    json['product_authentication'] as bool?,
    json['product_twin_card'] as bool?,
    json['token_symbol'] as String?,
    json['token_contract_address'] as String?,
    json['token_decimal'] as int?,
  );
}

Map<String, dynamic> _$CardConfigDataToJson(CardConfigData instance) {
  final val = <String, dynamic>{
    'date': instance.date,
    'batch': instance.batch,
    'blockchain': instance.blockchain,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('product_note', instance.productNote);
  writeNotNull('product_tag', instance.productTag);
  writeNotNull('product_id_card', instance.productIdCard);
  writeNotNull('product_id_issuer', instance.productIdIssuer);
  writeNotNull('product_authentication', instance.productAuthentication);
  writeNotNull('product_twin_card', instance.productTwin);
  writeNotNull('token_symbol', instance.tokenSymbol);
  writeNotNull('token_contract_address', instance.tokenContractAddress);
  writeNotNull('token_decimal', instance.tokenDecimal);
  return val;
}

PersonalizationIssuer _$PersonalizationIssuerFromJson(Map<String, dynamic> json) {
  return PersonalizationIssuer(
    json['name'] as String,
    json['id'] as String,
    KeyPairHex.fromJson(json['dataKeyPair'] as Map<String, dynamic>),
    KeyPairHex.fromJson(json['transactionKeyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PersonalizationIssuerToJson(PersonalizationIssuer instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'dataKeyPair': instance.dataKeyPair,
      'transactionKeyPair': instance.transactionKeyPair,
    };

PersonalizationAcquirer _$PersonalizationAcquirerFromJson(Map<String, dynamic> json) {
  return PersonalizationAcquirer(
    json['name'] as String,
    json['id'] as String,
    KeyPairHex.fromJson(json['keyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PersonalizationAcquirerToJson(PersonalizationAcquirer instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'keyPair': instance.keyPair,
    };

PersonalizationManufacturer _$PersonalizationManufacturerFromJson(Map<String, dynamic> json) {
  return PersonalizationManufacturer(
    json['name'] as String,
    KeyPairHex.fromJson(json['keyPair'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PersonalizationManufacturerToJson(PersonalizationManufacturer instance) => <String, dynamic>{
      'name': instance.name,
      'keyPair': instance.keyPair,
    };

CardSettings _$CardSettingsFromJson(Map<String, dynamic> json) {
  return CardSettings(
    json['securityDelay'] as int,
    json['maxWalletsCount'] as int,
    json['isSettingAccessCodeAllowed'] as bool,
    json['isSettingPasscodeAllowed'] as bool,
    json['isRemovingAccessCodeAllowed'] as bool,
    json['isLinkedTerminalEnabled'] as bool,
    (json['supportedEncryptionModes'] as List<dynamic>).map((e) => e as String).toList(),
    json['isPermanentWallet'] as bool,
    json['isOverwritingIssuerExtraDataRestricted'] as bool,
    (json['defaultSigningMethods'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['defaultCurve'] as String?,
    json['isIssuerDataProtectedAgainstReplay'] as bool,
    json['isSelectBlockchainAllowed'] as bool,
  );
}

Map<String, dynamic> _$CardSettingsToJson(CardSettings instance) => <String, dynamic>{
      'securityDelay': instance.securityDelay,
      'maxWalletsCount': instance.maxWalletsCount,
      'isSettingAccessCodeAllowed': instance.isSettingAccessCodeAllowed,
      'isSettingPasscodeAllowed': instance.isSettingPasscodeAllowed,
      'isRemovingAccessCodeAllowed': instance.isRemovingAccessCodeAllowed,
      'isLinkedTerminalEnabled': instance.isLinkedTerminalEnabled,
      'supportedEncryptionModes': instance.supportedEncryptionModes,
      'isPermanentWallet': instance.isPermanentWallet,
      'isOverwritingIssuerExtraDataRestricted': instance.isOverwritingIssuerExtraDataRestricted,
      'defaultSigningMethods': instance.defaultSigningMethods,
      'defaultCurve': instance.defaultCurve,
      'isIssuerDataProtectedAgainstReplay': instance.isIssuerDataProtectedAgainstReplay,
      'isSelectBlockchainAllowed': instance.isSelectBlockchainAllowed,
    };

CardIssuer _$CardIssuerFromJson(Map<String, dynamic> json) {
  return CardIssuer(
    json['name'] as String,
    json['publicKey'] as String,
  );
}

Map<String, dynamic> _$CardIssuerToJson(CardIssuer instance) => <String, dynamic>{
      'name': instance.name,
      'publicKey': instance.publicKey,
    };

CardManufacturer _$CardManufacturerFromJson(Map<String, dynamic> json) {
  return CardManufacturer(
    json['name'] as String,
    json['manufactureDate'] as String,
    json['signature'] as String?,
  );
}

Map<String, dynamic> _$CardManufacturerToJson(CardManufacturer instance) => <String, dynamic>{
      'name': instance.name,
      'manufactureDate': instance.manufactureDate,
      'signature': instance.signature,
    };

CardWallet _$CardWalletFromJson(Map<String, dynamic> json) {
  return CardWallet(
    json['publicKey'] as String,
    json['curve'] as String,
    CardWalletSettings.fromJson(json['settings'] as Map<String, dynamic>),
    json['totalSignedHashes'] as int?,
    json['remainingSignatures'] as int?,
    json['index'] as int,
  );
}

Map<String, dynamic> _$CardWalletToJson(CardWallet instance) => <String, dynamic>{
      'publicKey': instance.publicKey,
      'curve': instance.curve,
      'settings': instance.settings,
      'totalSignedHashes': instance.totalSignedHashes,
      'remainingSignatures': instance.remainingSignatures,
      'index': instance.index,
    };

CardWalletSettings _$CardWalletSettingsFromJson(Map<String, dynamic> json) {
  return CardWalletSettings(
    json['isPermanent'] as bool,
  );
}

Map<String, dynamic> _$CardWalletSettingsToJson(CardWalletSettings instance) => <String, dynamic>{
      'isPermanent': instance.isPermanent,
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

FirmwareVersion _$FirmwareVersionFromJson(Map<String, dynamic> json) {
  return FirmwareVersion(
    json['stringValue'] as String,
  );
}

Map<String, dynamic> _$FirmwareVersionToJson(FirmwareVersion instance) => <String, dynamic>{
      'stringValue': instance.stringValue,
    };

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
      'signature': instance.signature,
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
