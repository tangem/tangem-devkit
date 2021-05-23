// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResponse _$CardResponseFromJson(Map<String, dynamic> json) {
  return CardResponse(
    CardDataResponse.fromJson(json['cardData'] as Map<String, dynamic>),
    json['cardId'] as String,
    json['cardPublicKey'] as String,
    json['curve'] as String,
    FirmwareVersion.fromJson(json['firmwareVersion'] as Map<String, dynamic>),
    json['health'] as int,
    json['isActivated'] as bool,
    json['issuerPublicKey'] as String,
    json['manufacturerName'] as String,
    json['maxSignatures'] as int,
    json['pauseBeforePin2'] as int,
    (json['settingsMask'] as List<dynamic>).map((e) => e as String).toList(),
    (json['signingMethods'] as List<dynamic>).map((e) => e as String).toList(),
    json['status'] as String,
    json['terminalIsLinked'] as bool,
    json['walletPublicKey'] as String,
    json['walletRemainingSignatures'] as int,
    json['walletSignedHashes'] as int,
  );
}

Map<String, dynamic> _$CardResponseToJson(CardResponse instance) =>
    <String, dynamic>{
      'cardData': instance.cardData,
      'cardId': instance.cardId,
      'cardPublicKey': instance.cardPublicKey,
      'curve': instance.curve,
      'firmwareVersion': instance.firmwareVersion,
      'health': instance.health,
      'isActivated': instance.isActivated,
      'issuerPublicKey': instance.issuerPublicKey,
      'manufacturerName': instance.manufacturerName,
      'maxSignatures': instance.maxSignatures,
      'pauseBeforePin2': instance.pauseBeforePin2,
      'settingsMask': instance.settingsMask,
      'signingMethods': instance.signingMethods,
      'status': instance.status,
      'terminalIsLinked': instance.terminalIsLinked,
      'walletPublicKey': instance.walletPublicKey,
      'walletRemainingSignatures': instance.walletRemainingSignatures,
      'walletSignedHashes': instance.walletSignedHashes,
    };

FirmwareVersion _$FirmwareVersionFromJson(Map<String, dynamic> json) {
  return FirmwareVersion(
    json['major'] as int,
    json['minor'] as int,
    json['hotFix'] as int,
    json['type'] as String,
  );
}

Map<String, dynamic> _$FirmwareVersionToJson(FirmwareVersion instance) =>
    <String, dynamic>{
      'hotFix': instance.hotFix,
      'major': instance.major,
      'minor': instance.minor,
      'type': instance.type,
      'version': instance.version,
    };

CardDataResponse _$CardDataResponseFromJson(Map<String, dynamic> json) {
  return CardDataResponse(
    json['batchId'] as String,
    json['blockchainName'] as String,
    json['issuerName'] as String,
    json['manufacturerSignature'] as String,
    json['manufactureDateTime'] as String,
    (json['productMask'] as List<dynamic>).map((e) => e as String).toList(),
    tokenContractAddress: json['tokenContractAddress'] as String?,
    tokenSymbol: json['tokenSymbol'] as String?,
    tokenDecimal: json['tokenDecimal'] as int?,
  );
}

Map<String, dynamic> _$CardDataResponseToJson(CardDataResponse instance) {
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
