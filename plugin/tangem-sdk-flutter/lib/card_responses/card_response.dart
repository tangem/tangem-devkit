import 'package:json_annotation/json_annotation.dart';

part 'card_response.g.dart';

abstract class TangemSdkResponse {
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class CardResponse extends TangemSdkResponse {
  final CardDataResponse cardData;
  final String cardId;
  final String cardPublicKey;
  final String curve;
  final FirmwareVersion firmwareVersion;
  final int health;
  final bool isActivated;
  final String issuerPublicKey;
  final String manufacturerName;
  final int maxSignatures;
  final int pauseBeforePin2;
  final List<String> settingsMask;
  final List<String> signingMethods;
  final String status;
  final bool terminalIsLinked;
  final String walletPublicKey;
  final int walletRemainingSignatures;
  final int walletSignedHashes;

  CardResponse(
      this.cardData,
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
      this.walletSignedHashes);

  factory CardResponse.fromJson(Map<String, dynamic> json) => _$CardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CardResponseToJson(this);
}

@JsonSerializable()
class FirmwareVersion {
  final int major;
  final int minor;
  final int hotFix;
  final String type;
  final String version;

  FirmwareVersion(this.major, this.minor, [this.hotFix = 0, this.type = "d SDK"])
      : this.version = "$major.$minor.$hotFix";

  factory FirmwareVersion.fromJson(Map<String, dynamic> json) => _$FirmwareVersionFromJson(json);

  Map<String, dynamic> toJson() => _$FirmwareVersionToJson(this);
}

@JsonSerializable()
class CardDataResponse extends TangemSdkResponse {
  final String batchId;
  final String blockchainName;
  final String issuerName;
  final String manufacturerSignature;
  final String manufactureDateTime;
  final List<String> productMask;
  @JsonKey(includeIfNull: false)
  final String? tokenContractAddress;
  @JsonKey(includeIfNull: false)
  final String? tokenSymbol;
  @JsonKey(includeIfNull: false)
  final int? tokenDecimal;

  CardDataResponse(
    this.batchId,
    this.blockchainName,
    this.issuerName,
    this.manufacturerSignature,
    this.manufactureDateTime,
    this.productMask, {
    this.tokenContractAddress,
    this.tokenSymbol,
    this.tokenDecimal,
  });

  factory CardDataResponse.fromJson(Map<String, dynamic> json) => _$CardDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataResponseToJson(this);
}
