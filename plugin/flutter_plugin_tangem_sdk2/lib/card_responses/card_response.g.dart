// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    cardData: CardData.fromJson(json['cardData'] as Map<String, dynamic>),
    cardId: json['cardId'] as String,
    cardPublicKey: json['cardPublicKey'] as String,
    curve: json['curve'] as String,
    firmwareVersion: json['firmwareVersion'] as String,
    health: json['health'] as int,
    isActivated: json['isActivated'] as bool,
    issuerPublicKey: json['issuerPublicKey'] as String,
    manufacturerName: json['manufacturerName'] as String,
    maxSignatures: json['maxSignatures'] as int,
    pauseBeforePin2: json['pauseBeforePin2'] as int,
    settingsMask:
        (json['settingsMask'] as List).map((e) => e as String).toList(),
    signingMethods:
        (json['signingMethods'] as List).map((e) => e as String).toList(),
    status: json['status'] as String,
    terminalIsLinked: json['terminalIsLinked'] as bool,
    walletPublicKey: json['walletPublicKey'] as String,
    walletRemainingSignatures: json['walletRemainingSignatures'] as int,
    walletSignedHashes: json['walletSignedHashes'] as int,
  );
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
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

CardData _$CardDataFromJson(Map<String, dynamic> json) {
  return CardData(
    batchId: json['batchId'] as String,
    blockchainName: json['blockchainName'] as String,
    issuerName: json['issuerName'] as String,
    manufactureDateTime: json['manufactureDateTime'] as String,
    manufacturerSignature: json['manufacturerSignature'] as String,
    productMask:
        (json['productMask'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'batchId': instance.batchId,
      'blockchainName': instance.blockchainName,
      'issuerName': instance.issuerName,
      'manufactureDateTime': instance.manufactureDateTime,
      'manufacturerSignature': instance.manufacturerSignature,
      'productMask': instance.productMask,
    };
