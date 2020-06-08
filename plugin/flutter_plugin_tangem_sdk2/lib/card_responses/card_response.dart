import 'package:json_annotation/json_annotation.dart';

part 'card_response.g.dart';

@JsonSerializable(nullable: false)
class CardResponse {
  CardData cardData;
  String cardId;
  String cardPublicKey;
  String curve;
  String firmwareVersion;
  int health;
  bool isActivated;
  String issuerPublicKey;
  String manufacturerName;
  int maxSignatures;
  int pauseBeforePin2;
  List<String> settingsMask;
  List<String> signingMethods;
  String status;
  bool terminalIsLinked;
  String walletPublicKey;
  int walletRemainingSignatures;
  int walletSignedHashes;

  CardResponse(
      {this.cardData,
      this.cardId,
      this.cardPublicKey,
      this.curve,
      this.firmwareVersion,
      this.health,
      this.isActivated,
      this.issuerPublicKey,
      this.manufacturerName,
      this.maxSignatures,
      this.pauseBeforePin2,
      this.settingsMask,
      this.signingMethods,
      this.status,
      this.terminalIsLinked,
      this.walletPublicKey,
      this.walletRemainingSignatures,
      this.walletSignedHashes});

  factory CardResponse.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable()
class CardData {
  String batchId;
  String blockchainName;
  String issuerName;
  String manufactureDateTime;
  String manufacturerSignature;
  List<String> productMask;

  CardData({this.batchId, this.blockchainName, this.issuerName, this.manufactureDateTime, this.manufacturerSignature, this.productMask});

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}
