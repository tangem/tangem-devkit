import 'dart:async';

import 'package:tangem_sdk/tangem_sdk.dart';

typedef ConversionError = Function(dynamic);

abstract class CommandSignatureData {
  String cardId;
  Message initialMessage;

  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]);

  static CommandSignatureData attachBaseData(CommandSignatureData taskData, Map<String, dynamic> json) {
    taskData.cardId = json[TangemSdk.cid];
    if (json[TangemSdk.initialMessage] != null)
      taskData.initialMessage = Message.fromJson(json[TangemSdk.initialMessage]);
    return taskData;
  }
}

class Message {
  final String body;
  final String header;

  Message(this.body, this.header);

  factory Message.fromJson(Map<String, dynamic> json) => Message(json["body"], json["header"]);

  Map<String, dynamic> toJson() => {
        "body": body,
        "header": header,
      };
}

abstract class SignatureDataModel extends CommandSignatureData {
  final String type;

  SignatureDataModel(this.type);

  Future<Map<String, dynamic>> toSignatureData([ConversionError onError]) => Future.value(getBaseData());

  Map<String, dynamic> getBaseData() {
    final map = <String, dynamic>{TangemSdk.commandType: type};
    if (cardId != null) map[TangemSdk.cid] = cardId;
    if (initialMessage != null) map[TangemSdk.initialMessage] = initialMessage.toJson();
    return map;
  }
}

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
