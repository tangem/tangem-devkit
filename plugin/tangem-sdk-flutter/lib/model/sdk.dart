import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

import 'masks/signing_method_mask.dart';

part 'sdk.g.dart';

@JsonSerializable()
class PersonalizationCardConfig {
  bool releaseVersion;
  String issuerName;
  String? series;
  int startNumber;
  int count;
  String numberFormat;
  @JsonKey(name: "PIN")
  String pin;
  @JsonKey(name: "PIN2")
  String pin2;
  @JsonKey(name: "PIN3")
  String? pin3;
  String? hexCrExKey;
  @JsonKey(name: "CVC")
  String cvc;
  @JsonKey(name: "pauseBeforePIN2")
  int pauseBeforePin2;
  bool smartSecurityDelay;
  String curveID;
  @JsonKey(name: "SigningMethod")
  List<String> signingMethod;
  @JsonKey(name: "MaxSignatures")
  int? maxSignatures;
  @JsonKey(name: "allowSwapPIN")
  bool allowSetPIN1;
  @JsonKey(name: "allowSwapPIN2")
  bool allowSetPIN2;
  bool useActivation;
  @JsonKey(name: "useCVC")
  bool useCvc;
  @JsonKey(name: "useNDEF")
  bool useNDEF;
  bool? useDynamicNDEF;
  bool? useOneCommandAtTime;
  bool useBlock;
  bool allowSelectBlockchain;
  @JsonKey(name: "forbidPurgeWallet")
  bool prohibitPurgeWallet;
  @JsonKey(name: "protocolAllowUnencrypted")
  bool allowUnencrypted;
  @JsonKey(name: "protocolAllowStaticEncryption")
  bool allowFastEncryption;
  bool? protectIssuerDataAgainstReplay;
  @JsonKey(name: "forbidDefaultPIN")
  bool prohibitDefaultPIN1;
  bool? disablePrecomputedNDEF;
  bool skipSecurityDelayIfValidatedByIssuer;
  @JsonKey(name: "skipCheckPIN2andCVCIfValidatedByIssuer")
  bool skipCheckPIN2CVCIfValidatedByIssuer;
  bool skipSecurityDelayIfValidatedByLinkedTerminal;
  bool? restrictOverwriteIssuerDataEx;
  @JsonKey(includeIfNull: false)
  bool? disableIssuerData;
  @JsonKey(includeIfNull: false)
  bool? disableUserData;
  @JsonKey(includeIfNull: false)
  bool? disableFiles;
  int createWallet;
  CardConfigData cardData;
  @JsonKey(name: "NDEF")
  List<NdefRecordSdk> ndefRecords;
  int? walletsCount;

  PersonalizationCardConfig(
    this.releaseVersion,
    this.issuerName,
    this.series,
    this.startNumber,
    this.count,
    this.numberFormat,
    this.pin,
    this.pin2,
    this.pin3,
    this.hexCrExKey,
    this.cvc,
    this.pauseBeforePin2,
    this.smartSecurityDelay,
    this.curveID,
    this.signingMethod,
    this.maxSignatures,
    this.allowSetPIN1,
    this.allowSetPIN2,
    this.useActivation,
    this.useCvc,
    this.useNDEF,
    this.useDynamicNDEF,
    this.useOneCommandAtTime,
    this.useBlock,
    this.allowSelectBlockchain,
    this.prohibitPurgeWallet,
    this.allowUnencrypted,
    this.allowFastEncryption,
    this.protectIssuerDataAgainstReplay,
    this.prohibitDefaultPIN1,
    this.disablePrecomputedNDEF,
    this.skipSecurityDelayIfValidatedByIssuer,
    this.skipCheckPIN2CVCIfValidatedByIssuer,
    this.skipSecurityDelayIfValidatedByLinkedTerminal,
    this.restrictOverwriteIssuerDataEx,
    this.disableIssuerData,
    this.disableUserData,
    this.disableFiles,
    this.createWallet,
    this.cardData,
    this.ndefRecords,
    this.walletsCount,
  );

  factory PersonalizationCardConfig.fromJson(Map<String, dynamic> json) => _$PersonalizationCardConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationCardConfigToJson(this);
}

@JsonSerializable()
class CardConfigData {
  String? date;
  String batch;
  String blockchain;
  @JsonKey(name: 'product_note', includeIfNull: false)
  bool? productNote;
  @JsonKey(name: 'product_tag', includeIfNull: false)
  bool? productTag;
  @JsonKey(name: 'product_id_card', includeIfNull: false)
  bool? productIdCard;
  @JsonKey(name: 'product_id_issuer', includeIfNull: false)
  bool? productIdIssuer;
  @JsonKey(name: 'product_authentication', includeIfNull: false)
  bool? productAuthentication;
  @JsonKey(name: 'product_twin_card', includeIfNull: false)
  bool? productTwin;
  @JsonKey(name: 'token_symbol', includeIfNull: false)
  String? tokenSymbol;
  @JsonKey(name: 'token_contract_address', includeIfNull: false)
  String? tokenContractAddress;
  @JsonKey(name: 'token_decimal', includeIfNull: false)
  int? tokenDecimal;

  CardConfigData(
    this.date,
    this.batch,
    this.blockchain,
    this.productNote,
    this.productTag,
    this.productIdCard,
    this.productIdIssuer,
    this.productAuthentication,
    this.productTwin,
    this.tokenSymbol,
    this.tokenContractAddress,
    this.tokenDecimal,
  );

  factory CardConfigData.fromJson(Map<String, dynamic> json) => _$CardConfigDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardConfigDataToJson(this);
}

@JsonSerializable()
class PersonalizationIssuer {
  final String name;
  final String id;
  final KeyPairHex dataKeyPair;
  final KeyPairHex transactionKeyPair;

  PersonalizationIssuer(this.name, this.id, this.dataKeyPair, this.transactionKeyPair);

  factory PersonalizationIssuer.fromJson(Map<String, dynamic> json) => _$PersonalizationIssuerFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationIssuerToJson(this);
}

@JsonSerializable()
class PersonalizationAcquirer {
  final String name;
  final String id;
  final KeyPairHex keyPair;

  PersonalizationAcquirer(this.name, this.id, this.keyPair);

  factory PersonalizationAcquirer.fromJson(Map<String, dynamic> json) => _$PersonalizationAcquirerFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationAcquirerToJson(this);
}

@JsonSerializable()
class PersonalizationManufacturer {
  final String name;
  final KeyPairHex keyPair;

  PersonalizationManufacturer(this.name, this.keyPair);

  factory PersonalizationManufacturer.fromJson(Map<String, dynamic> json) =>
      _$PersonalizationManufacturerFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizationManufacturerToJson(this);
}

@JsonSerializable()
class CardSettings {
  final int securityDelay;
  final int maxWalletsCount;
  final bool isSettingAccessCodeAllowed;
  final bool isSettingPasscodeAllowed;
  final bool isRemovingAccessCodeAllowed;
  final bool isLinkedTerminalEnabled;
  final List<String> supportedEncryptionModes;
  final bool isPermanentWallet;
  final bool isOverwritingIssuerExtraDataRestricted;
  final List<String>? defaultSigningMethods;
  final String? defaultCurve;
  final bool isIssuerDataProtectedAgainstReplay;
  final bool isSelectBlockchainAllowed;

  CardSettings(
    this.securityDelay,
    this.maxWalletsCount,
    this.isSettingAccessCodeAllowed,
    this.isSettingPasscodeAllowed,
    this.isRemovingAccessCodeAllowed,
    this.isLinkedTerminalEnabled,
    this.supportedEncryptionModes,
    this.isPermanentWallet,
    this.isOverwritingIssuerExtraDataRestricted,
    this.defaultSigningMethods,
    this.defaultCurve,
    this.isIssuerDataProtectedAgainstReplay,
    this.isSelectBlockchainAllowed,
  );

  factory CardSettings.fromJson(Map<String, dynamic> json) => _$CardSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$CardSettingsToJson(this);
}

@JsonSerializable()
class CardIssuer {
  final String name;
  final String publicKey;

  CardIssuer(this.name, this.publicKey);

  factory CardIssuer.fromJson(Map<String, dynamic> json) => _$CardIssuerFromJson(json);

  Map<String, dynamic> toJson() => _$CardIssuerToJson(this);
}

@JsonSerializable()
class CardManufacturer {
  final String name;
  final String manufactureDate;
  final String? signature;

  CardManufacturer(this.name, this.manufactureDate, this.signature);

  factory CardManufacturer.fromJson(Map<String, dynamic> json) => _$CardManufacturerFromJson(json);

  Map<String, dynamic> toJson() => _$CardManufacturerToJson(this);
}

@JsonSerializable()
class CardWallet {
  final String publicKey;
  final String curve;
  final CardWalletSettings settings;
  final int? totalSignedHashes;
  final int? remainingSignatures;
  final int index;

  CardWallet(
    this.publicKey,
    this.curve,
    this.settings,
    this.totalSignedHashes,
    this.remainingSignatures,
    this.index,
  );

  factory CardWallet.fromJson(Map<String, dynamic> json) => _$CardWalletFromJson(json);

  Map<String, dynamic> toJson() => _$CardWalletToJson(this);
}

@JsonSerializable()
class CardWalletSettings {
  final bool isPermanent;

  CardWalletSettings(this.isPermanent);

  factory CardWalletSettings.fromJson(Map<String, dynamic> json) => _$CardWalletSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$CardWalletSettingsToJson(this);
}

@JsonSerializable()
class Message {
  final String? body;
  final String? header;

  Message(this.body, this.header);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class FirmwareVersion {
  @JsonKey(ignore: true)
  late final int major;
  @JsonKey(ignore: true)
  late final int minor;
  @JsonKey(ignore: true)
  late final int hotFix;
  @JsonKey(ignore: true)
  late final FirmwareType? type;
  late final String stringValue;

  FirmwareVersion(this.stringValue) {
    final code = "\u0000";
    final versionCleaned =
        stringValue.endsWith(code) ? stringValue.substring(0, stringValue.length - code.length) : stringValue;

    final cardType = versionCleaned.replaceAll(RegExp("[\\d.]"), "").trim();
    final result = versionCleaned.replaceAll(cardType, "").trim();
    final separated = result.split(".");

    this.major = int.parse(separated.removeFirstOrNull() ?? "0");
    this.minor = int.parse(separated.removeFirstOrNull() ?? "0");
    this.hotFix = int.parse(separated.removeFirstOrNull() ?? "0");
    this.type = _getFirmwareType(cardType);
  }

  FirmwareVersion.separated(this.major, this.minor, [int? hotFix, FirmwareType? type])
      : this.hotFix = hotFix ?? 0,
        this.type = type,
        this.stringValue = StringBuffer("$major.$minor").apply((it) {
          if (hotFix != 0) it.write("$hotFix");
          if (type != null) it.write(type.type);
        }).toString();

  FirmwareType? _getFirmwareType(String? type) {
    return FirmwareType.values.firstWhereOrNull((e) => e.type == type);
  }

  factory FirmwareVersion.fromJson(Map<String, dynamic> json) => _$FirmwareVersionFromJson(json);

  Map<String, dynamic> toJson() => _$FirmwareVersionToJson(this);
}

extension OnFirmwareType on FirmwareType {
  static const types = {
    FirmwareType.Sdk: "d SDK",
    FirmwareType.Release: "r",
    FirmwareType.Sprecial: null,
  };

  String? get type => types[this];
}

@JsonSerializable()
class KeyPairHex {
  final String publicKey;
  final String privateKey;

  KeyPairHex(this.publicKey, this.privateKey);

  factory KeyPairHex.fromJson(Map<String, dynamic> json) => _$KeyPairHexFromJson(json);

  Map<String, dynamic> toJson() => _$KeyPairHexToJson(this);
}

@JsonSerializable()
class NdefRecordSdk {
  final String type;
  final String value;

  NdefRecordSdk(this.type, this.value);

  factory NdefRecordSdk.fromJson(Map<String, dynamic> json) => _$NdefRecordSdkFromJson(json);

  Map<String, dynamic> toJson() => _$NdefRecordSdkToJson(this);
}

abstract class FileDataHex {
  final String data;

  FileDataHex(this.data);
}

@JsonSerializable()
class DataProtectedByPasscodeHex extends FileDataHex {
  DataProtectedByPasscodeHex(String data) : super(data);

  factory DataProtectedByPasscodeHex.fromJson(Map<String, dynamic> json) => _$DataProtectedByPasscodeHexFromJson(json);

  Map<String, dynamic> toJson() => _$DataProtectedByPasscodeHexToJson(this);
}

@JsonSerializable()
class DataProtectedBySignatureHex extends FileDataHex {
  final int counter;
  final FileDataSignatureHex signature;
  final String? issuerPublicKey;

  DataProtectedBySignatureHex(String data, this.counter, this.signature, [this.issuerPublicKey]) : super(data);

  factory DataProtectedBySignatureHex.fromJson(Map<String, dynamic> json) =>
      _$DataProtectedBySignatureHexFromJson(json);

  Map<String, dynamic> toJson() => _$DataProtectedBySignatureHexToJson(this);
}

@JsonSerializable()
class FileDataSignatureHex {
  final String startingSignature;
  final String finalizingSignature;

  FileDataSignatureHex(this.startingSignature, this.finalizingSignature);

  factory FileDataSignatureHex.fromJson(Map<String, dynamic> json) => _$FileDataSignatureHexFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataSignatureHexToJson(this);
}

@JsonSerializable()
class FileHex {
  final int fileIndex;
  final String fileData;
  final FileSettings? fileSettings;

  FileHex(this.fileIndex, this.fileData, [this.fileSettings]);

  factory FileHex.fromJson(Map<String, dynamic> json) => _$FileHexFromJson(json);

  Map<String, dynamic> toJson() => _$FileHexToJson(this);
}

@JsonSerializable()
class ChangeFileSettings {
  final int fileIndex;
  final FileSettings settings;

  ChangeFileSettings(this.fileIndex, this.settings);

  factory ChangeFileSettings.fromJson(Map<String, dynamic> json) => _$ChangeFileSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeFileSettingsToJson(this);
}

extension FileSettingsCode on FileSettings {
  static const codes = {
    FileSettings.Public: 0x0001,
    FileSettings.Private: 0x0000,
  };

  int get code => codes[this]!;
}

@JsonSerializable()
class FileHashDataHex {
  final String startingHash;
  final String finalizingHash;
  final String? startingSignature;
  final String? finalizingSignature;

  FileHashDataHex(this.startingHash, this.finalizingHash, [this.startingSignature, this.finalizingSignature]);

  factory FileHashDataHex.fromJson(Map<String, dynamic> json) => _$FileHashDataHexFromJson(json);

  Map<String, dynamic> toJson() => _$FileHashDataHexToJson(this);
}

@JsonSerializable()
class WalletConfig {
  final bool? isReusable;
  final bool? prohibitPurgeWallet;
  final String? curveId;
  final SigningMethod? signingMethods;

  WalletConfig([this.isReusable, this.prohibitPurgeWallet, this.curveId, this.signingMethods]);

  factory WalletConfig.fromJson(Map<String, dynamic> json) => _$WalletConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WalletConfigToJson(this);
}

enum FirmwareType {
  Sdk,
  Release,
  Sprecial,
}

enum FileSettings { Public, Private }

enum PinType { ACCESS_CODE, PASSCODE, PIN3 }

enum LinkedTerminalStatus {
  Current,
  Other,
  None,
}

enum EncryptionMode {
  None,
  Fast,
  Strong,
}

enum PreflightReadMode {
  None,
  ReadCardOnly,
  ReadWallet,
  FullCardRead,
}
