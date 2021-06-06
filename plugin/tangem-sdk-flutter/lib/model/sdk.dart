import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

part 'sdk.g.dart';

@JsonSerializable()
class CardConfigSdk {
  final String? issuerName;
  final String? acquirerName;
  final String? series;
  final int startNumber;
  final int count;
  final String pin;
  final String pin2;
  final String pin3;
  final String hexCrExKey;
  final String cvc;
  final int pauseBeforePin2;
  final bool smartSecurityDelay;
  final String curveID;
  final List<String> signingMethods;
  final int maxSignatures;
  final bool isReusable;
  final bool allowSetPIN1;
  final bool allowSetPIN2;
  final bool useActivation;
  final bool useCvc;
  final bool useNDEF;
  final bool useDynamicNDEF;
  final bool useOneCommandAtTime;
  final bool useBlock;
  final bool allowSelectBlockchain;
  final bool prohibitPurgeWallet;
  final bool allowUnencrypted;
  final bool allowFastEncryption;
  final bool protectIssuerDataAgainstReplay;
  final bool prohibitDefaultPIN1;
  final bool disablePrecomputedNDEF;
  final bool skipSecurityDelayIfValidatedByIssuer;
  final bool skipCheckPIN2CVCIfValidatedByIssuer;
  final bool skipSecurityDelayIfValidatedByLinkedTerminal;
  final bool restrictOverwriteIssuerExtraData;
  final bool requireTerminalTxSignature;
  final bool requireTerminalCertSignature;
  final bool checkPIN3OnCard;
  final bool createWallet;
  final int walletsCount;
  final CardData cardData;
  final List<NdefRecordSdk> ndefRecords;

  CardConfigSdk(
    this.pin,
    this.pin2,
    this.pin3,
    this.hexCrExKey,
    this.cvc,
    this.pauseBeforePin2,
    this.smartSecurityDelay,
    String curveID,
    this.signingMethods,
    this.maxSignatures,
    this.isReusable,
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
    this.restrictOverwriteIssuerExtraData,
    this.requireTerminalTxSignature,
    this.requireTerminalCertSignature,
    this.checkPIN3OnCard,
    this.createWallet,
    this.walletsCount,
    this.cardData,
    this.ndefRecords, {
    this.issuerName,
    this.acquirerName,
    this.series,
    this.startNumber = 0,
    this.count = 0,
  }) : this.curveID = curveID.capitalize();

  factory CardConfigSdk.fromJson(Map<String, dynamic> json) => _$CardConfigSdkFromJson(json);

  Map<String, dynamic> toJson() => _$CardConfigSdkToJson(this);
}

@JsonSerializable()
class Issuer {
  final String name;
  final String id;
  final KeyPairHex dataKeyPair;
  final KeyPairHex transactionKeyPair;

  Issuer(this.name, this.id, this.dataKeyPair, this.transactionKeyPair);

  factory Issuer.fromJson(Map<String, dynamic> json) => _$IssuerFromJson(json);

  Map<String, dynamic> toJson() => _$IssuerToJson(this);
}

@JsonSerializable()
class Acquirer {
  final String name;
  final String id;
  final KeyPairHex keyPair;

  Acquirer(this.name, this.id, this.keyPair);

  factory Acquirer.fromJson(Map<String, dynamic> json) => _$AcquirerFromJson(json);

  Map<String, dynamic> toJson() => _$AcquirerToJson(this);
}

@JsonSerializable()
class Manufacturer {
  final String name;
  final KeyPairHex keyPair;

  Manufacturer(this.name, this.keyPair);

  factory Manufacturer.fromJson(Map<String, dynamic> json) => _$ManufacturerFromJson(json);

  Map<String, dynamic> toJson() => _$ManufacturerToJson(this);
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
class CardWallet {
  final int index;
  final String status;
  final String? curve;
  final List<String>? settingsMask;
  final String? publicKey;
  final int? signedHashes;
  final int? remainingSignatures;

  CardWallet(
    this.index,
    this.status, [
    this.curve,
    this.settingsMask,
    this.publicKey,
    this.signedHashes,
    this.remainingSignatures,
  ]);

  factory CardWallet.fromJson(Map<String, dynamic> json) => _$CardWalletFromJson(json);

  Map<String, dynamic> toJson() => _$CardWalletToJson(this);
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
  late final String version;

  FirmwareVersion(this.version) {
    final code = "\u0000";
    final versionCleaned = version.endsWith(code) ? version.substring(0, version.length - code.length) : version;

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
        this.version = StringBuffer("$major.$minor").apply((it) {
          if (hotFix != 0) it.write("$hotFix");
          if (type != null) it.write(type.type);
        }).toString();

  FirmwareType? _getFirmwareType(String? type) {
    return FirmwareType.values.firstWhereOrNull((e) => e.type == type);
  }

  factory FirmwareVersion.fromJson(String version) => _$FirmwareVersionFromJson({"version": version});

  Map<String, dynamic> toJson() => _$FirmwareVersionToJson(this);
}

enum FirmwareType {
  Sdk,
  Release,
  Sprecial,
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
class CardData {
  final String? batchId;
  final String? blockchainName;
  final String? issuerName;
  final String? manufacturerSignature;
  final String? manufactureDateTime;
  final List<String>? productMask;
  @JsonKey(includeIfNull: false)
  final String? tokenContractAddress;
  @JsonKey(includeIfNull: false)
  final String? tokenSymbol;
  @JsonKey(includeIfNull: false)
  final int? tokenDecimal;

  CardData(
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

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
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

enum PinType { PIN1, PIN2, PIN3 }

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

enum FileSettings { Public, Private }

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
