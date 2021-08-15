// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponse _$SuccessResponseFromJson(Map<String, dynamic> json) {
  return SuccessResponse(
    json['cardId'] as String,
  );
}

Map<String, dynamic> _$SuccessResponseToJson(SuccessResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
    };

ReadResponse _$ReadResponseFromJson(Map<String, dynamic> json) {
  return ReadResponse(
    json['cardId'] as String,
    json['batchId'] as String,
    json['cardPublicKey'] as String,
    FirmwareVersion.fromJson(json['firmwareVersion'] as Map<String, dynamic>),
    CardManufacturer.fromJson(json['manufacturer'] as Map<String, dynamic>),
    CardIssuer.fromJson(json['issuer'] as Map<String, dynamic>),
    CardSettings.fromJson(json['settings'] as Map<String, dynamic>),
    _$enumDecode(_$LinkedTerminalStatusEnumMap, json['linkedTerminalStatus']),
    json['isPasscodeSet'] as bool?,
    (json['supportedCurves'] as List<dynamic>).map((e) => e as String).toList(),
    (json['wallets'] as List<dynamic>)
        .map((e) => CardWallet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReadResponseToJson(ReadResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'batchId': instance.batchId,
      'cardPublicKey': instance.cardPublicKey,
      'firmwareVersion': instance.firmwareVersion,
      'manufacturer': instance.manufacturer,
      'issuer': instance.issuer,
      'settings': instance.settings,
      'linkedTerminalStatus':
          _$LinkedTerminalStatusEnumMap[instance.linkedTerminalStatus],
      'isPasscodeSet': instance.isPasscodeSet,
      'supportedCurves': instance.supportedCurves,
      'wallets': instance.wallets,
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

const _$LinkedTerminalStatusEnumMap = {
  LinkedTerminalStatus.Current: 'Current',
  LinkedTerminalStatus.Other: 'Other',
  LinkedTerminalStatus.None: 'None',
};

SignResponse _$SignResponseFromJson(Map<String, dynamic> json) {
  return SignResponse(
    json['cardId'] as String,
    (json['signatures'] as List<dynamic>).map((e) => e as String).toList(),
    json['totalSignedHashes'] as int?,
  );
}

Map<String, dynamic> _$SignResponseToJson(SignResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'signatures': instance.signatures,
      'totalSignedHashes': instance.totalSignedHashes,
    };

SignHashResponse _$SignHashResponseFromJson(Map<String, dynamic> json) {
  return SignHashResponse(
    json['cardId'] as String,
    json['signature'] as String,
    json['totalSignedHashes'] as int?,
  );
}

Map<String, dynamic> _$SignHashResponseToJson(SignHashResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'signature': instance.signature,
      'totalSignedHashes': instance.totalSignedHashes,
    };

DepersonalizeResponse _$DepersonalizeResponseFromJson(
    Map<String, dynamic> json) {
  return DepersonalizeResponse(
    json['success'] as bool,
  );
}

Map<String, dynamic> _$DepersonalizeResponseToJson(
        DepersonalizeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

CreateWalletResponse _$CreateWalletResponseFromJson(Map<String, dynamic> json) {
  return CreateWalletResponse(
    json['cardId'] as String,
    CardWallet.fromJson(json['wallet'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWalletResponseToJson(
        CreateWalletResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'wallet': instance.wallet,
    };

PurgeWalletResponse _$PurgeWalletResponseFromJson(Map<String, dynamic> json) {
  return PurgeWalletResponse(
    json['cardId'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$PurgeWalletResponseToJson(
        PurgeWalletResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'status': instance.status,
    };

ReadWalletsListResponse _$ReadWalletsListResponseFromJson(
    Map<String, dynamic> json) {
  return ReadWalletsListResponse(
    json['cardId'] as String,
    (json['wallets'] as List<dynamic>)
        .map((e) => CardWallet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReadWalletsListResponseToJson(
        ReadWalletsListResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'wallets': instance.wallets,
    };

ReadWalletResponse _$ReadWalletResponseFromJson(Map<String, dynamic> json) {
  return ReadWalletResponse(
    json['cardId'] as String,
    (json['wallet'] as List<dynamic>)
        .map((e) => CardWallet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReadWalletResponseToJson(ReadWalletResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'wallet': instance.wallet,
    };

ReadIssuerDataResponse _$ReadIssuerDataResponseFromJson(
    Map<String, dynamic> json) {
  return ReadIssuerDataResponse(
    json['cardId'] as String,
    json['issuerData'] as String,
    json['issuerDataSignature'] as String,
    json['issuerDataCounter'] as int?,
  );
}

Map<String, dynamic> _$ReadIssuerDataResponseToJson(
        ReadIssuerDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'issuerData': instance.issuerData,
      'issuerDataSignature': instance.issuerDataSignature,
      'issuerDataCounter': instance.issuerDataCounter,
    };

ReadIssuerExtraDataResponse _$ReadIssuerExtraDataResponseFromJson(
    Map<String, dynamic> json) {
  return ReadIssuerExtraDataResponse(
    json['cardId'] as String,
    json['size'] as int?,
    json['issuerData'] as String,
    json['issuerDataSignature'] as String?,
    json['issuerDataCounter'] as int?,
  );
}

Map<String, dynamic> _$ReadIssuerExtraDataResponseToJson(
        ReadIssuerExtraDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'size': instance.size,
      'issuerData': instance.issuerData,
      'issuerDataSignature': instance.issuerDataSignature,
      'issuerDataCounter': instance.issuerDataCounter,
    };

ReadUserDataResponse _$ReadUserDataResponseFromJson(Map<String, dynamic> json) {
  return ReadUserDataResponse(
    json['cardId'] as String,
    json['userData'] as String,
    json['userProtectedData'] as String,
    json['userCounter'] as int,
    json['userProtectedCounter'] as int,
  );
}

Map<String, dynamic> _$ReadUserDataResponseToJson(
        ReadUserDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'userData': instance.userData,
      'userCounter': instance.userCounter,
      'userProtectedData': instance.userProtectedData,
      'userProtectedCounter': instance.userProtectedCounter,
    };

WriteFileResponse _$WriteFileResponseFromJson(Map<String, dynamic> json) {
  return WriteFileResponse(
    json['cardId'] as String,
    json['fileIndices'] as int?,
  );
}

Map<String, dynamic> _$WriteFileResponseToJson(WriteFileResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'fileIndices': instance.fileIndices,
    };

WriteFilesResponse _$WriteFilesResponseFromJson(Map<String, dynamic> json) {
  return WriteFilesResponse(
    json['cardId'] as String,
    (json['fileIndices'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$WriteFilesResponseToJson(WriteFilesResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'fileIndices': instance.fileIndices,
    };

ReadFileResponse _$ReadFileResponseFromJson(Map<String, dynamic> json) {
  return ReadFileResponse(
    json['cardId'] as String,
    json['size'] as int?,
    json['fileData'] as String,
    json['fileIndex'] as int,
    _$enumDecode(_$FileSettingsEnumMap, json['fileSettings']),
    json['fileDataSignature'] as String?,
    json['fileDataCounter'] as int?,
  );
}

Map<String, dynamic> _$ReadFileResponseToJson(ReadFileResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'size': instance.size,
      'fileData': instance.fileData,
      'fileIndex': instance.fileIndex,
      'fileSettings': _$FileSettingsEnumMap[instance.fileSettings],
      'fileDataSignature': instance.fileDataSignature,
      'fileDataCounter': instance.fileDataCounter,
    };

const _$FileSettingsEnumMap = {
  FileSettings.Public: 'Public',
  FileSettings.Private: 'Private',
};

ReadFilesResponse _$ReadFilesResponseFromJson(Map<String, dynamic> json) {
  return ReadFilesResponse(
    (json['files'] as List<dynamic>)
        .map((e) => FileHex.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReadFilesResponseToJson(ReadFilesResponse instance) =>
    <String, dynamic>{
      'files': instance.files,
    };

ReadFileChecksumResponse _$ReadFileChecksumResponseFromJson(
    Map<String, dynamic> json) {
  return ReadFileChecksumResponse(
    json['cardId'] as String,
    json['checksum'] as String,
    json['fileIndex'] as int?,
  );
}

Map<String, dynamic> _$ReadFileChecksumResponseToJson(
        ReadFileChecksumResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'checksum': instance.checksum,
      'fileIndex': instance.fileIndex,
    };
