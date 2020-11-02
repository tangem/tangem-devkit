import 'dart:async';
import 'dart:convert';

import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class ScanModel extends SignatureDataModel {
  ScanModel() : super(TangemSdk.cScanCard);

  factory ScanModel.fromJson(Map<String, dynamic> json) => CommandSignatureData.attachBaseData(ScanModel(), json);
}

class SignModel extends SignatureDataModel {
  final String dataForHashing;

  SignModel(this.dataForHashing) : super(TangemSdk.cSign);

  factory SignModel.fromJson(Map<String, dynamic> json) {
    return CommandSignatureData.attachBaseData(SignModel(json["dataForHashing"]), json);
  }

  static List<String> getHashesFromString(String dataForHashing) {
    final splitPattern = ",";
    if (dataForHashing.contains(splitPattern)) {
      final rawHashes = dataForHashing.split(splitPattern);
      return rawHashes.map((element) => element.trim().toHexString()).toList();
    } else {
      return [dataForHashing.toHexString()];
    }
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async =>
      {TangemSdk.hashes: getHashesFromString(dataForHashing)}..addAll(getBaseData());
}

class PersonalizationModel extends SignatureDataModel {
  final PersonalizationConfig config;
  final Issuer issuer;

  PersonalizationModel(this.config, this.issuer) : super(TangemSdk.cPersonalize);

  factory PersonalizationModel.fromJson(Map<String, dynamic> json) {
    final model = PersonalizationModel(
      PersonalizationConfig.fromJson(json["config"]),
      Issuer.fromJson(json["issuer"]),
    );
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) {
    final acquirer = Utils.createDefaultAcquirer();
    final manufacturer = Utils.createDefaultManufacturer();
    final data = {
      TangemSdk.cardConfig: json.encode(Utils.createCardConfig(config, issuer, acquirer)),
      TangemSdk.issuer: json.encode(issuer),
      TangemSdk.acquirer: json.encode(acquirer),
      TangemSdk.manufacturer: json.encode(manufacturer),
    };
    return Future.value(getBaseData()..addAll(data));
  }
}

class DepersonalizeModel extends SignatureDataModel {
  DepersonalizeModel() : super(TangemSdk.cDepersonalize);

  factory DepersonalizeModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(DepersonalizeModel(), json);
}

class CreateWalletModel extends SignatureDataModel {
  CreateWalletModel() : super(TangemSdk.cCreateWallet);

  factory CreateWalletModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(CreateWalletModel(), json);
}

class PurgeWalletModel extends SignatureDataModel {
  PurgeWalletModel() : super(TangemSdk.cPurgeWallet);

  factory PurgeWalletModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(PurgeWalletModel(), json);
}

class WriteIssuerDataModel extends SignatureDataModel {
  final String issuerData;
  final String issuerPrivateKeyHex;
  final int issuerDataCounter;

  WriteIssuerDataModel(
    String cardId,
    this.issuerData,
    this.issuerPrivateKeyHex, [
    this.issuerDataCounter,
  ]) : super(TangemSdk.cWriteIssuerData) {
    this.cardId = cardId;
  }

  factory WriteIssuerDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteIssuerDataModel(
      json[TangemSdk.cid],
      json[TangemSdk.issuerData],
      json[TangemSdk.privateKey],
      json[TangemSdk.issuerDataCounter],
    );
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async {
    final issuerDataHex = issuerData.toHexString();
    final completer = Completer<Map<String, dynamic>>();

    final callback = Callback((success) {
      if (success is! FileHashData) {
        onError(Exception("PrepareHashes success, but type of result isn't the FileHashData"));
        completer.complete(null);
        return;
      }

      final finalizingSignature = (success as FileHashData).finalizingSignature;
      final signatureData = {
        TangemSdk.issuerData: issuerDataHex,
        TangemSdk.issuerDataSignature: finalizingSignature,
        TangemSdk.issuerDataCounter: issuerDataCounter,
      }..addAll(getBaseData());
      completer.complete(signatureData);
    }, (error) {
      onError(error);
      completer.complete(null);
    });

    TangemSdk.prepareHashes(callback, cardId, issuerDataHex, issuerDataCounter, issuerPrivateKeyHex);

    return completer.future;
  }
}

class ReadIssuerDataModel extends SignatureDataModel {
  ReadIssuerDataModel() : super(TangemSdk.cReadIssuerData);

  factory ReadIssuerDataModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(ReadIssuerDataModel(), json);
}

class WriteIssuerExDataModel extends SignatureDataModel {
  final String issuerExData;
  final String issuerPrivateKeyHex;
  final int issuerDataCounter;

  WriteIssuerExDataModel(
    String cardId,
    this.issuerExData,
    this.issuerPrivateKeyHex, [
    this.issuerDataCounter,
  ]) : super(TangemSdk.cWriteIssuerExData) {
    this.cardId = cardId;
  }

  factory WriteIssuerExDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteIssuerExDataModel(
      json[TangemSdk.cid],
      json[TangemSdk.issuerData],
      json[TangemSdk.privateKey],
      json[TangemSdk.issuerDataCounter],
    );
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async {
    final issuerDataHex = issuerExData.toHexString();
    final completer = Completer<Map<String, dynamic>>();

    final callback = Callback((success) {
      if (success is! FileHashData) {
        onError(Exception("PrepareHashes success, but type of result isn't the FileHashData"));
        completer.complete(null);
        return;
      }

      final fileHasData = success as FileHashData;
      final signatureData = {
        TangemSdk.issuerData: issuerExData.toHexString(),
        TangemSdk.startingSignature: fileHasData.startingSignature,
        TangemSdk.finalizingSignature: fileHasData.finalizingSignature,
        TangemSdk.issuerDataCounter: issuerDataCounter,
      }..addAll(getBaseData());
      completer.complete(signatureData);
    }, (error) {
      onError(error);
      completer.complete(null);
    });

    TangemSdk.prepareHashes(callback, cardId, issuerDataHex, issuerDataCounter, issuerPrivateKeyHex);

    return completer.future;
  }
}

class ReadIssuerExDataModel extends SignatureDataModel {
  ReadIssuerExDataModel() : super(TangemSdk.cReadIssuerExData);

  factory ReadIssuerExDataModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(ReadIssuerExDataModel(), json);
}

class WriteUserDataModel extends SignatureDataModel {
  final String userData;
  final int userCounter;

  WriteUserDataModel(this.userData, [this.userCounter]) : super(TangemSdk.cWriteUserData);

  factory WriteUserDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteUserDataModel(json[TangemSdk.userData], json[TangemSdk.userCounter]);
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async {
    return {
      TangemSdk.userData: userData.toHexString(),
      TangemSdk.userCounter: userCounter,
    }..addAll(getBaseData());
  }
}

class ReadUserDataModel extends SignatureDataModel {
  ReadUserDataModel() : super(TangemSdk.cReadUserData);

  factory ReadUserDataModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(ReadUserDataModel(), json);
}

class WriteUserProtectedDataModel extends SignatureDataModel {
  final String userProtectedData;
  final int userProtectedCounter;

  WriteUserProtectedDataModel(this.userProtectedData, [this.userProtectedCounter])
      : super(TangemSdk.cWriteUserProtectedData);

  factory WriteUserProtectedDataModel.fromJson(Map<String, dynamic> json) {
    final model = WriteUserProtectedDataModel(json[TangemSdk.userProtectedData], json[TangemSdk.userProtectedCounter]);
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async {
    return {
      TangemSdk.userProtectedData: userProtectedData.toHexString(),
      TangemSdk.userProtectedCounter: userProtectedCounter,
    }..addAll(getBaseData());
  }
}

class SetPin1Model extends SignatureDataModel {
  final String pinCode;

  SetPin1Model(this.pinCode) : super(TangemSdk.cSetPin1);

  factory SetPin1Model.fromJson(Map<String, dynamic> json) {
    final model = SetPin1Model(json[TangemSdk.pinCode]);
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async {
    return {
      TangemSdk.pinCode: pinCode,
    }..addAll(getBaseData());
  }
}

class SetPin2Model extends SignatureDataModel {
  final String pinCode;

  SetPin2Model(this.pinCode) : super(TangemSdk.cSetPin2);

  factory SetPin2Model.fromJson(Map<String, dynamic> json) {
    final model = SetPin2Model(json[TangemSdk.pinCode]);
    return CommandSignatureData.attachBaseData(model, json);
  }

  @override
  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) async {
    return {
      TangemSdk.pinCode: pinCode,
    }..addAll(getBaseData());
  }
}
