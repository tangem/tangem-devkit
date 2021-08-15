import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/model/sdk.dart';

part 'card_response.g.dart';

abstract class TangemSdkResponse {
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class SuccessResponse extends TangemSdkResponse {
  final String cardId;

  SuccessResponse(this.cardId);

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => _$SuccessResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);
}

@JsonSerializable()
class ReadResponse extends TangemSdkResponse {
  final String cardId;
  final String batchId;
  final String cardPublicKey;
  final FirmwareVersion firmwareVersion;
  final CardManufacturer manufacturer;
  final CardIssuer issuer;
  final CardSettings settings;
  final LinkedTerminalStatus linkedTerminalStatus;
  final bool? isPasscodeSet;
  final List<String> supportedCurves;
  final List<CardWallet> wallets;

  // internal val attestation: Attestation = Attestation.empty,
  // internal var health: Int? = null,
  // internal var remainingSignatures: Int? = null,

  ReadResponse(
    this.cardId,
    this.batchId,
    this.cardPublicKey,
    this.firmwareVersion,
    this.manufacturer,
    this.issuer,
    this.settings,
    this.linkedTerminalStatus,
    this.isPasscodeSet,
    this.supportedCurves,
    this.wallets,
  );

  factory ReadResponse.fromJson(Map<String, dynamic> json) => _$ReadResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadResponseToJson(this);
}

@JsonSerializable()
class SignResponse extends TangemSdkResponse {
  final String cardId;
  final List<String> signatures;
  final int? totalSignedHashes;

  SignResponse(this.cardId, this.signatures, this.totalSignedHashes);

  factory SignResponse.fromJson(Map<String, dynamic> json) => _$SignResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignResponseToJson(this);
}

@JsonSerializable()
class SignHashResponse extends TangemSdkResponse {
  final String cardId;
  final String signature;
  final int? totalSignedHashes;

  SignHashResponse(this.cardId, this.signature, this.totalSignedHashes);

  factory SignHashResponse.fromJson(Map<String, dynamic> json) => _$SignHashResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignHashResponseToJson(this);
}

@JsonSerializable()
class DepersonalizeResponse extends TangemSdkResponse {
  bool success;

  DepersonalizeResponse(this.success);

  factory DepersonalizeResponse.fromJson(Map<String, dynamic> json) => _$DepersonalizeResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DepersonalizeResponseToJson(this);
}

@JsonSerializable()
class CreateWalletResponse extends TangemSdkResponse {
  final String cardId;
  final CardWallet wallet;

  CreateWalletResponse(this.cardId, this.wallet);

  factory CreateWalletResponse.fromJson(Map<String, dynamic> json) => _$CreateWalletResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateWalletResponseToJson(this);
}

@JsonSerializable()
class PurgeWalletResponse extends TangemSdkResponse {
  final String cardId;
  final String status;

  PurgeWalletResponse(this.cardId, this.status);

  factory PurgeWalletResponse.fromJson(Map<String, dynamic> json) => _$PurgeWalletResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurgeWalletResponseToJson(this);
}

@JsonSerializable()
class ReadWalletsListResponse extends TangemSdkResponse {
  final String cardId;
  final List<CardWallet> wallets;

  ReadWalletsListResponse(this.cardId, this.wallets);

  factory ReadWalletsListResponse.fromJson(Map<String, dynamic> json) => _$ReadWalletsListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadWalletsListResponseToJson(this);
}

@JsonSerializable()
class ReadWalletResponse extends TangemSdkResponse {
  final String cardId;
  final List<CardWallet> wallet;

  ReadWalletResponse(this.cardId, this.wallet);

  factory ReadWalletResponse.fromJson(Map<String, dynamic> json) => _$ReadWalletResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadWalletResponseToJson(this);
}

@JsonSerializable()
class ReadIssuerDataResponse extends TangemSdkResponse {
  final String cardId;
  final String issuerData;
  final String issuerDataSignature;
  final int? issuerDataCounter;

  ReadIssuerDataResponse(this.cardId, this.issuerData, this.issuerDataSignature, this.issuerDataCounter);

  factory ReadIssuerDataResponse.fromJson(Map<String, dynamic> json) => _$ReadIssuerDataResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadIssuerDataResponseToJson(this);
}

@JsonSerializable()
class ReadIssuerExtraDataResponse extends TangemSdkResponse {
  final String cardId;
  final int? size;
  final String issuerData;
  final String? issuerDataSignature;
  final int? issuerDataCounter;

  ReadIssuerExtraDataResponse(
    this.cardId,
    this.size,
    this.issuerData,
    this.issuerDataSignature,
    this.issuerDataCounter,
  );

  factory ReadIssuerExtraDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ReadIssuerExtraDataResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadIssuerExtraDataResponseToJson(this);
}

@JsonSerializable()
class ReadUserDataResponse extends TangemSdkResponse {
  final String cardId;
  final String userData;
  final int userCounter;
  final String userProtectedData;
  final int userProtectedCounter;

  ReadUserDataResponse(
    this.cardId,
    this.userData,
    this.userProtectedData,
    this.userCounter,
    this.userProtectedCounter,
  );

  factory ReadUserDataResponse.fromJson(Map<String, dynamic> json) => _$ReadUserDataResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadUserDataResponseToJson(this);
}

@JsonSerializable()
class WriteFileResponse extends TangemSdkResponse {
  final String cardId;
  final int? fileIndices;

  WriteFileResponse(this.cardId, this.fileIndices);

  factory WriteFileResponse.fromJson(Map<String, dynamic> json) => _$WriteFileResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WriteFileResponseToJson(this);
}

@JsonSerializable()
class WriteFilesResponse extends TangemSdkResponse {
  final String cardId;
  final List<int> fileIndices;

  WriteFilesResponse(this.cardId, this.fileIndices);

  factory WriteFilesResponse.fromJson(Map<String, dynamic> json) => _$WriteFilesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WriteFilesResponseToJson(this);
}

@JsonSerializable()
class ReadFileResponse extends TangemSdkResponse {
  final String cardId;
  final int? size;
  final String fileData;
  final int fileIndex;
  final FileSettings fileSettings;
  final String? fileDataSignature;
  final int? fileDataCounter;

  ReadFileResponse(
    this.cardId,
    this.size,
    this.fileData,
    this.fileIndex,
    this.fileSettings,
    this.fileDataSignature,
    this.fileDataCounter,
  );

  factory ReadFileResponse.fromJson(Map<String, dynamic> json) => _$ReadFileResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadFileResponseToJson(this);
}

@JsonSerializable()
class ReadFilesResponse extends TangemSdkResponse {
  final List<FileHex> files;

  ReadFilesResponse(this.files);

  factory ReadFilesResponse.fromJson(Map<String, dynamic> json) => _$ReadFilesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadFilesResponseToJson(this);
}

@JsonSerializable()
class ReadFileChecksumResponse extends TangemSdkResponse {
  final String cardId;
  final String checksum;
  final int? fileIndex;

  ReadFileChecksumResponse(this.cardId, this.checksum, this.fileIndex);

  factory ReadFileChecksumResponse.fromJson(Map<String, dynamic> json) => _$ReadFileChecksumResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadFileChecksumResponseToJson(this);
}
