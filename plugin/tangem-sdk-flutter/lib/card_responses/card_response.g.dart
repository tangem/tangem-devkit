// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResponse _$CardResponseFromJson(Map<String, dynamic> json) {
  return CardResponse(
    json['cardId'] as String,
    json['manufacturerName'] as String,
    json['status'] as String?,
    FirmwareVersion.fromJson(json['firmwareVersion'] as String),
    json['cardPublicKey'] as String?,
    json['defaultCurve'] as String?,
    (json['settingsMask'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['issuerPublicKey'] as String?,
    (json['signingMethods'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    json['pauseBeforePin2'] as int?,
    json['walletsCount'] as int?,
    json['walletIndex'] as int?,
    json['health'] as int?,
    json['isActivated'] as bool,
    json['activationSeed'] as String?,
    json['paymentFlowVersion'] as String?,
    json['userCounter'] as int?,
    json['userProtectedCounter'] as int?,
    json['terminalIsLinked'] as bool,
    json['cardData'] == null
        ? null
        : CardData.fromJson(json['cardData'] as Map<String, dynamic>),
    json['isPin1Default'] as bool?,
    json['isPin2Default'] as bool?,
    (json['wallets'] as List<dynamic>?)
        ?.map((e) => CardWallet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CardResponseToJson(CardResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'manufacturerName': instance.manufacturerName,
      'status': instance.status,
      'firmwareVersion': instance.firmwareVersion,
      'cardPublicKey': instance.cardPublicKey,
      'defaultCurve': instance.defaultCurve,
      'settingsMask': instance.settingsMask,
      'issuerPublicKey': instance.issuerPublicKey,
      'signingMethods': instance.signingMethods,
      'pauseBeforePin2': instance.pauseBeforePin2,
      'walletsCount': instance.walletsCount,
      'walletIndex': instance.walletIndex,
      'health': instance.health,
      'isActivated': instance.isActivated,
      'activationSeed': instance.activationSeed,
      'paymentFlowVersion': instance.paymentFlowVersion,
      'userCounter': instance.userCounter,
      'userProtectedCounter': instance.userProtectedCounter,
      'terminalIsLinked': instance.terminalIsLinked,
      'cardData': instance.cardData,
      'isPin1Default': instance.isPin1Default,
      'isPin2Default': instance.isPin2Default,
      'wallets': instance.wallets,
    };

SignResponse _$SignResponseFromJson(Map<String, dynamic> json) {
  return SignResponse(
    (json['signedHashes'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$SignResponseToJson(SignResponse instance) =>
    <String, dynamic>{
      'signedHashes': instance.signedHashes,
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
    json['status'] as String,
    json['walletPublicKey'] as String,
  );
}

Map<String, dynamic> _$CreateWalletResponseToJson(
        CreateWalletResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'status': instance.status,
      'walletPublicKey': instance.walletPublicKey,
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

ReadIssuerDataResponse _$ReadIssuerDataResponseFromJson(
    Map<String, dynamic> json) {
  return ReadIssuerDataResponse(
    json['cardId'] as String,
    json['issuerData'] as String,
    json['issuerDataSignature'] as String,
    json['issuerDataCounter'] as int,
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

WriteIssuerDataResponse _$WriteIssuerDataResponseFromJson(
    Map<String, dynamic> json) {
  return WriteIssuerDataResponse(
    json['cardId'] as String,
  );
}

Map<String, dynamic> _$WriteIssuerDataResponseToJson(
        WriteIssuerDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
    };

ReadIssuerExDataResponse _$ReadIssuerExDataResponseFromJson(
    Map<String, dynamic> json) {
  return ReadIssuerExDataResponse(
    json['cardId'] as String,
    json['size'] as int,
    json['issuerData'] as String,
    json['issuerDataSignature'] as String,
    json['issuerDataCounter'] as int,
  );
}

Map<String, dynamic> _$ReadIssuerExDataResponseToJson(
        ReadIssuerExDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'size': instance.size,
      'issuerData': instance.issuerData,
      'issuerDataSignature': instance.issuerDataSignature,
      'issuerDataCounter': instance.issuerDataCounter,
    };

WriteIssuerExDataResponse _$WriteIssuerExDataResponseFromJson(
    Map<String, dynamic> json) {
  return WriteIssuerExDataResponse(
    json['cardId'] as String,
  );
}

Map<String, dynamic> _$WriteIssuerExDataResponseToJson(
        WriteIssuerExDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
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

WriteUserDataResponse _$WriteUserDataResponseFromJson(
    Map<String, dynamic> json) {
  return WriteUserDataResponse(
    json['cardId'] as String,
  );
}

Map<String, dynamic> _$WriteUserDataResponseToJson(
        WriteUserDataResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
    };

SetPinResponse _$SetPinResponseFromJson(Map<String, dynamic> json) {
  return SetPinResponse(
    json['cardId'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$SetPinResponseToJson(SetPinResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'status': instance.status,
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

DeleteFilesResponse _$DeleteFilesResponseFromJson(Map<String, dynamic> json) {
  return DeleteFilesResponse(
    json['cardId'] as String,
  );
}

Map<String, dynamic> _$DeleteFilesResponseToJson(
        DeleteFilesResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
    };

ChangeFilesSettingsResponse _$ChangeFilesSettingsResponseFromJson(
    Map<String, dynamic> json) {
  return ChangeFilesSettingsResponse(
    json['cardId'] as String,
  );
}

Map<String, dynamic> _$ChangeFilesSettingsResponseToJson(
        ChangeFilesSettingsResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
    };
