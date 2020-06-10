// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    code: json['code'] as int,
    localizedDescription: json['localizedDescription'] as String,
  );
}

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'localizedDescription': instance.localizedDescription,
    };

SignResponse _$SignResponseFromJson(Map<String, dynamic> json) {
  return SignResponse(
    cardId: json['cardId'] as String,
    signature: json['signature'] as String,
    walletRemainingSignatures: json['walletRemainingSignatures'] as int,
    walletSignedHashes: json['walletSignedHashes'] as int,
  );
}

Map<String, dynamic> _$SignResponseToJson(SignResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'signature': instance.signature,
      'walletRemainingSignatures': instance.walletRemainingSignatures,
      'walletSignedHashes': instance.walletSignedHashes,
    };

DepersonalizeResponse _$DepersonalizeResponseFromJson(
    Map<String, dynamic> json) {
  return DepersonalizeResponse(
    success: json['success'] as bool,
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
