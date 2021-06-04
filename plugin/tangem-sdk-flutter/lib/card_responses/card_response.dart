import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/model/sdk.dart';

part 'card_response.g.dart';

abstract class TangemSdkResponse {
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class CardResponse extends TangemSdkResponse {
  final String cardId;
  final String manufacturerName;
  final String? status;
  final FirmwareVersion firmwareVersion;
  final String? cardPublicKey;
  final String? defaultCurve;
  final List<String>? settingsMask;
  final String? issuerPublicKey;
  final List<String>? signingMethods;
  final int? pauseBeforePin2;
  final int? walletsCount;
  final int? walletIndex;
  final int? health;
  final bool isActivated;
  final String? activationSeed;
  final String? paymentFlowVersion;
  final int? userCounter;
  final int? userProtectedCounter;
  final bool terminalIsLinked;
  final CardData? cardData;
  final bool? isPin1Default;
  final bool? isPin2Default;
  final List<CardWallet> wallets;

  CardResponse(
    this.cardId,
    this.manufacturerName,
    this.status,
    this.firmwareVersion,
    this.cardPublicKey,
    this.defaultCurve,
    this.settingsMask,
    this.issuerPublicKey,
    this.signingMethods,
    this.pauseBeforePin2,
    this.walletsCount,
    this.walletIndex,
    this.health,
    this.isActivated,
    this.activationSeed,
    this.paymentFlowVersion,
    this.userCounter,
    this.userProtectedCounter,
    this.terminalIsLinked,
    this.cardData,
    this.isPin1Default,
    this.isPin2Default, [
    List<CardWallet>? wallets,
  ]) : this.wallets = wallets ?? [];

  factory CardResponse.fromJson(Map<String, dynamic> json) => _$CardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CardResponseToJson(this);
}

@JsonSerializable()
class SignResponse extends TangemSdkResponse {
  final List<String> signedHashes;

  SignResponse(this.signedHashes);

  factory SignResponse.fromJson(Map<String, dynamic> json) => _$SignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignResponseToJson(this);
}

@JsonSerializable()
class DepersonalizeResponse extends TangemSdkResponse {
  bool success;

  DepersonalizeResponse(this.success);

  factory DepersonalizeResponse.fromJson(Map<String, dynamic> json) => _$DepersonalizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepersonalizeResponseToJson(this);
}

@JsonSerializable()
class CreateWalletResponse extends TangemSdkResponse {
  final String cardId;
  final String status;
  final String walletPublicKey;

  CreateWalletResponse(this.cardId, this.status, this.walletPublicKey);

  factory CreateWalletResponse.fromJson(Map<String, dynamic> json) => _$CreateWalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWalletResponseToJson(this);
}

@JsonSerializable()
class PurgeWalletResponse extends TangemSdkResponse {
  final String cardId;
  final String status;

  PurgeWalletResponse(this.cardId, this.status);

  factory PurgeWalletResponse.fromJson(Map<String, dynamic> json) => _$PurgeWalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PurgeWalletResponseToJson(this);
}

@JsonSerializable()
class ReadIssuerDataResponse extends TangemSdkResponse {
  final String cardId;
  final String issuerData;
  final String issuerDataSignature;
  final int issuerDataCounter;

  ReadIssuerDataResponse(this.cardId, this.issuerData, this.issuerDataSignature, this.issuerDataCounter);

  factory ReadIssuerDataResponse.fromJson(Map<String, dynamic> json) => _$ReadIssuerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadIssuerDataResponseToJson(this);
}

@JsonSerializable()
class WriteIssuerDataResponse extends TangemSdkResponse {
  final String cardId;

  WriteIssuerDataResponse(this.cardId);

  factory WriteIssuerDataResponse.fromJson(Map<String, dynamic> json) => _$WriteIssuerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WriteIssuerDataResponseToJson(this);
}

@JsonSerializable()
class ReadIssuerExDataResponse extends TangemSdkResponse {
  final String cardId;
  final int size;
  final String issuerData;
  final String issuerDataSignature;
  final int issuerDataCounter;

  ReadIssuerExDataResponse(this.cardId, this.size, this.issuerData, this.issuerDataSignature, this.issuerDataCounter);

  factory ReadIssuerExDataResponse.fromJson(Map<String, dynamic> json) => _$ReadIssuerExDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadIssuerExDataResponseToJson(this);
}

@JsonSerializable()
class WriteIssuerExDataResponse extends TangemSdkResponse {
  final String cardId;

  WriteIssuerExDataResponse(this.cardId);

  factory WriteIssuerExDataResponse.fromJson(Map<String, dynamic> json) => _$WriteIssuerExDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WriteIssuerExDataResponseToJson(this);
}

@JsonSerializable()
class ReadUserDataResponse extends TangemSdkResponse {
  final String cardId;
  final String userData;
  final int userCounter;
  final String userProtectedData;
  final int userProtectedCounter;

  ReadUserDataResponse(this.cardId, this.userData, this.userProtectedData, this.userCounter, this.userProtectedCounter);

  factory ReadUserDataResponse.fromJson(Map<String, dynamic> json) => _$ReadUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadUserDataResponseToJson(this);
}

@JsonSerializable()
class WriteUserDataResponse extends TangemSdkResponse {
  final String cardId;

  WriteUserDataResponse(this.cardId);

  factory WriteUserDataResponse.fromJson(Map<String, dynamic> json) => _$WriteUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WriteUserDataResponseToJson(this);
}

@JsonSerializable()
class SetPinResponse extends TangemSdkResponse {
  final String cardId;
  final String status;

  SetPinResponse(this.cardId, this.status);

  factory SetPinResponse.fromJson(Map<String, dynamic> json) => _$SetPinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetPinResponseToJson(this);
}

@JsonSerializable()
class WriteFilesResponse extends TangemSdkResponse {
  final String cardId;
  final List<int> fileIndices;

  WriteFilesResponse(this.cardId, this.fileIndices);

  factory WriteFilesResponse.fromJson(Map<String, dynamic> json) => _$WriteFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WriteFilesResponseToJson(this);
}

@JsonSerializable()
class ReadFilesResponse extends TangemSdkResponse {
  final List<FileHex> files;

  ReadFilesResponse(this.files);

  factory ReadFilesResponse.fromJson(Map<String, dynamic> json) => _$ReadFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadFilesResponseToJson(this);
}

@JsonSerializable()
class DeleteFilesResponse extends TangemSdkResponse {
  final String cardId;

  DeleteFilesResponse(this.cardId);

  factory DeleteFilesResponse.fromJson(Map<String, dynamic> json) => _$DeleteFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFilesResponseToJson(this);
}

@JsonSerializable()
class ChangeFilesSettingsResponse extends TangemSdkResponse {
  final String cardId;

  ChangeFilesSettingsResponse(this.cardId);

  factory ChangeFilesSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeFilesSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeFilesSettingsResponseToJson(this);
}
