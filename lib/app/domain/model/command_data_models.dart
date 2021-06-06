import 'dart:async';

import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class ScanModel extends CommandDataModel {
  ScanModel() : super(TangemSdk.cScanCard);

  factory ScanModel.fromJson(Map<String, dynamic> json) => CommandDataModel.attachBaseData(ScanModel(), json);
}

class SignModel extends CommandDataModel {
  final List<String> dataForHashing;
  final String walletPublicKey;

  SignModel(this.dataForHashing, this.walletPublicKey) : super(TangemSdk.cSign);

  factory SignModel.fromJson(Map<String, dynamic> json) {
    final model = SignModel(
      (json["dataForHashing"] as List).toStringList(),
      json["walletPublicKey"],
    );
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.hashes: dataForHashing.map((e) => e.toHexString()).toList(),
      TangemSdk.walletPublicKey: walletPublicKey,
    }..addAll(getBaseData());
  }
}

class PersonalizationModel extends CommandDataModel {
  final PersonalizationConfig config;
  final Issuer issuer;

  PersonalizationModel(this.config, this.issuer) : super(TangemSdk.cPersonalize);

  factory PersonalizationModel.fromJson(Map<String, dynamic> json) {
    final model = PersonalizationModel(
      PersonalizationConfig.fromJson(json["config"]),
      Issuer.fromJson(json["issuer"]),
    );
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    final data = Utils.createPersonalizationCommandConfig(config, issuer);
    return getBaseData()..addAll(data);
  }
}

class DepersonalizeModel extends CommandDataModel {
  DepersonalizeModel() : super(TangemSdk.cDepersonalize);

  factory DepersonalizeModel.fromJson(Map<String, dynamic> json) =>
      CommandDataModel.attachBaseData(DepersonalizeModel(), json);
}

class CreateWalletModel extends CommandDataModel {
  CreateWalletModel() : super(TangemSdk.cCreateWallet);

  factory CreateWalletModel.fromJson(Map<String, dynamic> json) =>
      CommandDataModel.attachBaseData(CreateWalletModel(), json);
}

class PurgeWalletModel extends CommandDataModel {
  final int walletIndex;

  PurgeWalletModel(this.walletIndex) : super(TangemSdk.cPurgeWallet);

  factory PurgeWalletModel.fromJson(Map<String, dynamic> json) {
    final model = PurgeWalletModel(json["walletIndex"] as int);
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic> toJson(ConversionError onError) {
    return <String, dynamic>{TangemSdk.walletIndex: this.walletIndex}..addAll(getBaseData());
  }
}

class WriteIssuerDataModel extends CommandDataModel {
  final String issuerData;
  final String issuerPrivateKeyHex;
  final int issuerDataCounter;
  String? _finalizingSignature;

  WriteIssuerDataModel(
    String cardId,
    this.issuerData,
    this.issuerPrivateKeyHex,
    this.issuerDataCounter,
  ) : super(TangemSdk.cWriteIssuerData) {
    this.cardId = cardId;
  }

  factory WriteIssuerDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteIssuerDataModel(
      json[TangemSdk.cid],
      json[TangemSdk.issuerData],
      json[TangemSdk.privateKey],
      json[TangemSdk.issuerDataCounter],
    );
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Future prepare() async {
    final completer = Completer();
    final callback = Callback((success) {
      if (success is! FileHashDataHex) {
        completer.completeError(Exception("PrepareHashes success, but type of result isn't the FileHashData"));
        return completer.future;
      }
      _finalizingSignature = success.finalizingSignature;
      completer.complete();
    }, (error) => completer.completeError(error));

    TangemSdk.prepareHashes(callback, cardId!, issuerData.toHexString(), issuerDataCounter, issuerPrivateKeyHex);
    return completer.future;
  }

  @override
  bool isPrepared() => _finalizingSignature != null;

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    if (_finalizingSignature == null) {
      onError(notPrepared);
      return null;
    }
    return <String, dynamic>{
      TangemSdk.issuerData: issuerData.toHexString(),
      TangemSdk.issuerDataSignature: _finalizingSignature,
      TangemSdk.issuerDataCounter: issuerDataCounter,
    }..addAll(getBaseData());
  }
}

class ReadIssuerDataModel extends CommandDataModel {
  ReadIssuerDataModel() : super(TangemSdk.cReadIssuerData);

  factory ReadIssuerDataModel.fromJson(Map<String, dynamic> json) =>
      CommandDataModel.attachBaseData(ReadIssuerDataModel(), json);
}

class WriteIssuerExDataModel extends CommandDataModel {
  final String issuerExData;
  final String issuerPrivateKeyHex;
  final int issuerDataCounter;
  FileHashDataHex? _fileHashDataHex;

  WriteIssuerExDataModel(
    String cardId,
    this.issuerExData,
    this.issuerPrivateKeyHex,
    this.issuerDataCounter,
  ) : super(TangemSdk.cWriteIssuerExData) {
    this.cardId = cardId;
  }

  factory WriteIssuerExDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteIssuerExDataModel(
      json[TangemSdk.cid],
      json[TangemSdk.issuerData],
      json[TangemSdk.privateKey],
      json[TangemSdk.issuerDataCounter],
    );
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Future prepare() async {
    final completer = Completer();
    final callback = Callback((success) {
      if (success is! FileHashDataHex) {
        completer.completeError(Exception("PrepareHashes success, but type of result isn't the FileHashData"));
        return;
      }
      _fileHashDataHex = success;
      completer.complete();
    }, (error) => completer.completeError(error));
    TangemSdk.prepareHashes(callback, cardId!, issuerExData.toHexString(), issuerDataCounter, issuerPrivateKeyHex);

    return completer.future;
  }

  @override
  bool isPrepared() => _fileHashDataHex != null;

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    if (_fileHashDataHex == null) {
      onError(notPrepared);
      return null;
    }

    return {
      TangemSdk.issuerData: issuerExData.toHexString(),
      TangemSdk.startingSignature: _fileHashDataHex!.startingSignature,
      TangemSdk.finalizingSignature: _fileHashDataHex!.finalizingSignature,
      TangemSdk.issuerDataCounter: issuerDataCounter,
    }..addAll(getBaseData());
  }
}

class ReadIssuerExDataModel extends CommandDataModel {
  ReadIssuerExDataModel() : super(TangemSdk.cReadIssuerExData);

  factory ReadIssuerExDataModel.fromJson(Map<String, dynamic> json) =>
      CommandDataModel.attachBaseData(ReadIssuerExDataModel(), json);
}

class WriteUserDataModel extends CommandDataModel {
  final String userData;
  final int? userCounter;

  WriteUserDataModel(this.userData, [this.userCounter]) : super(TangemSdk.cWriteUserData);

  factory WriteUserDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteUserDataModel(json[TangemSdk.userData], json[TangemSdk.userCounter]);
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.userData: userData.toHexString(),
      TangemSdk.userCounter: userCounter,
    }..addAll(getBaseData());
  }
}

class ReadUserDataModel extends CommandDataModel {
  ReadUserDataModel() : super(TangemSdk.cReadUserData);

  factory ReadUserDataModel.fromJson(Map<String, dynamic> json) =>
      CommandDataModel.attachBaseData(ReadUserDataModel(), json);
}

class WriteUserProtectedDataModel extends CommandDataModel {
  final String userProtectedData;
  final int? userProtectedCounter;

  WriteUserProtectedDataModel(this.userProtectedData, [this.userProtectedCounter])
      : super(TangemSdk.cWriteUserProtectedData);

  factory WriteUserProtectedDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteUserProtectedDataModel(json[TangemSdk.userProtectedData], json[TangemSdk.userProtectedCounter]);
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.userProtectedData: userProtectedData.toHexString(),
      TangemSdk.userProtectedCounter: userProtectedCounter,
    }..addAll(getBaseData());
  }
}

class SetPin1Model extends CommandDataModel {
  final String? pinCode;

  SetPin1Model(this.pinCode) : super(TangemSdk.cSetPin1);

  factory SetPin1Model.fromJson(Map<String, dynamic> json) {
    final model = SetPin1Model(json[TangemSdk.pinCode]);
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.pinCode: pinCode,
    }..addAll(getBaseData());
  }
}

class SetPin2Model extends CommandDataModel {
  final String? pinCode;

  SetPin2Model(this.pinCode) : super(TangemSdk.cSetPin2);

  factory SetPin2Model.fromJson(Map<String, dynamic> json) {
    final model = SetPin2Model(json[TangemSdk.pinCode]);
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.pinCode: pinCode,
    }..addAll(getBaseData());
  }
}

class WriteFileData {
  final List<int> data;
  final int? counter;

  WriteFileData(this.data, [this.counter]);

  factory WriteFileData.fromJson(Map<String, dynamic> json) {
    final stringData = json[TangemSdk.fileData] as String;

    return WriteFileData(stringData.toBytes(), json[TangemSdk.counter]);
  }

  static int daysStartsFrom2020() {
    return DateTime.now().difference(DateTime(2020)).inDays;
  }
}

class FilesWriteModel extends CommandDataModel {
  final List<WriteFileData> filesData;
  final Issuer? issuer;
  List<Map<String, dynamic>>? _issuerFilesSignatureData;

  FilesWriteModel(this.filesData, [this.issuer]) : super(TangemSdk.cWriteFiles);

  factory FilesWriteModel.fromJson(Map<String, dynamic> json) {
    final dataToWrite = json[TangemSdk.files] as List;
    List<WriteFileData> filesData = dataToWrite.map((e) => WriteFileData.fromJson(e)).toList();
    final model = FilesWriteModel(
      filesData,
      json.containsKey("issuer") ? Issuer.fromJson(json["issuer"]) : null,
    );
    return CommandDataModel.attachBaseData(model, json);
  }

  bool _isProtectedByIssuer() => issuer != null;

  @override
  Future prepare() async {
    final mainCompleter = Completer();
    if (_isProtectedByIssuer() && cardId == null) {
      mainCompleter.completeError(Exception("Can't write files protected by issuer without cardId"));
      return mainCompleter.future;
    }

    if (_isProtectedByIssuer()) {
      if (filesData.hasNull((e) => e.counter)) {
        mainCompleter.completeError(Exception("All files data must contains the counter value"));
        return mainCompleter.future;
      }

      final issuerPk = issuer!.dataKeyPair.privateKey;
      final hashDataAssociation = <int, FileHashDataHex?>{};
      final List<Future> prepareHashesFutures = filesData.map((fileData) {
        final completer = Completer();
        final callback = Callback((success) {
          hashDataAssociation[fileData.counter!] = success;
          completer.complete();
        }, (error) {
          hashDataAssociation[fileData.counter!] = null;
          completer.completeError(error);
        });

        TangemSdk.prepareHashes(callback, cardId!, fileData.data.toHexString(), fileData.counter!, issuerPk);
        return completer.future;
      }).toList();

      await Future.wait(prepareHashesFutures);
      if (hashDataAssociation.hasNull()) {
        mainCompleter.completeError(Exception("Prepare hashes failed"));
        return mainCompleter.future;
      }

      _issuerFilesSignatureData = filesData.map((fileData) {
        final hashData = hashDataAssociation[fileData.counter]!;
        final signature = FileDataSignatureHex(hashData.startingSignature!, hashData.finalizingSignature!);
        final protectedFileData = DataProtectedBySignatureHex(
          fileData.data.toHexString(),
          fileData.counter!,
          signature,
          issuerPk,
        );
        return protectedFileData.toJson();
      }).toList();

      mainCompleter.complete();
    } else {
      mainCompleter.complete();
    }
    return mainCompleter.future;
  }

  @override
  bool isPrepared() => _isProtectedByIssuer() ? _issuerFilesSignatureData != null : true;

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    if (_isProtectedByIssuer()) {
      if (_issuerFilesSignatureData == null) {
        onError(notPrepared);
        return null;
      } else {
        return {TangemSdk.files: _issuerFilesSignatureData}..addAll(getBaseData());
      }
    } else {
      final filesDataHex = this.filesData.map((e) {
        return DataProtectedByPasscodeHex(e.data.toHexString()).toJson();
      }).toList();
      return {TangemSdk.files: filesDataHex}..addAll(getBaseData());
    }
  }
}

class FilesReadModel extends CommandDataModel {
  final bool readPrivateFiles;
  final List<int>? indices;

  FilesReadModel(this.readPrivateFiles, [this.indices]) : super(TangemSdk.cReadFiles);

  factory FilesReadModel.fromJson(Map<String, dynamic> json) {
    List<int> indices = (json[TangemSdk.indices] as List).toIntList();
    final model = FilesReadModel(json[TangemSdk.readPrivateFiles], indices);
    return CommandDataModel.attachBaseData(model, json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.readPrivateFiles: readPrivateFiles,
      TangemSdk.indices: indices,
    }..addAll(getBaseData());
  }
}

class FilesDeleteModel extends CommandDataModel {
  final List<int>? indices;

  FilesDeleteModel([this.indices]) : super(TangemSdk.cDeleteFiles);

  factory FilesDeleteModel.fromJson(Map<String, dynamic> json) {
    List<int>? indices = (json[TangemSdk.indices] as List?)?.toIntList();
    return CommandDataModel.attachBaseData(FilesDeleteModel(indices), json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    return {
      TangemSdk.indices: indices,
    }..addAll(getBaseData());
  }
}

class FilesChangeSettingsModel extends CommandDataModel {
  final List<ChangeFileSettings> changes;

  FilesChangeSettingsModel(this.changes) : super(TangemSdk.cChangeFilesSettings);

  factory FilesChangeSettingsModel.fromJson(Map<String, dynamic> json) {
    final jsonList = (json[TangemSdk.changes] as List);
    final changes = jsonList.map((e) => ChangeFileSettings.fromJson(e)).toList();
    return CommandDataModel.attachBaseData(FilesChangeSettingsModel(changes), json);
  }

  @override
  Map<String, dynamic>? toJson(ConversionError onError) {
    if (changes.isEmpty) {
      onError(Exception("Can't create signature data, because changes is empty"));
      return null;
    }
    return {
      TangemSdk.changes: changes.map((e) => e.toJson()).toList(),
    }..addAll(getBaseData());
  }
}
