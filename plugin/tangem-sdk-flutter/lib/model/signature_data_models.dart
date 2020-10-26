import 'package:tangem_sdk/tangem_sdk.dart';

abstract class CommandSignatureData {
  String cardId;
  Message initialMessage;

  Map<String, dynamic> toSignatureData();

  static CommandSignatureData attachBaseData(CommandSignatureData taskData, Map<String, dynamic> json) {
    taskData.cardId = json[TangemSdk.cid];
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

  Map<String, dynamic> toSignatureData() => toJson();

  Map<String, dynamic> toJson() => getBaseData();

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
  Map<String, dynamic> toJson() => {
        TangemSdk.hashes: getHashesFromString(dataForHashing),
      }..addAll(getBaseData());
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
  final int issuerDataCounter;

  WriteIssuerDataModel(this.issuerData, [this.issuerDataCounter]) : super(TangemSdk.cWriteIssuerData);

  @override
  Map<String, dynamic> toJson() => {
        TangemSdk.issuerData: issuerData.toHexString(),
        TangemSdk.issuerDataSignature: "issuerDataSignature".toHexString(),
        TangemSdk.issuerDataCounter: issuerDataCounter,
      }..addAll(getBaseData());
}

class ReadIssuerDataModel extends SignatureDataModel {
  ReadIssuerDataModel() : super(TangemSdk.cReadIssuerData);

  factory ReadIssuerDataModel.fromJson(Map<String, dynamic> json) =>
      CommandSignatureData.attachBaseData(ReadIssuerDataModel(), json);
}

class WriteIssuerExDataModel extends SignatureDataModel {
  final String issuerExData;
  final int issuerDataCounter;

  WriteIssuerExDataModel(this.issuerExData, [this.issuerDataCounter]) : super(TangemSdk.cWriteIssuerExData);

  @override
  Map<String, dynamic> toJson() => {
        TangemSdk.issuerData: issuerExData.toHexString(),
        TangemSdk.startingSignature: "startingSignature".toHexString(),
        TangemSdk.finalizingSignature: "finalizingSignature".toHexString(),
        TangemSdk.issuerDataCounter: issuerDataCounter,
      }..addAll(getBaseData());
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

  @override
  Map<String, dynamic> toJson() => {
        TangemSdk.userData: userData.toHexString(),
        TangemSdk.userCounter: userCounter,
      }..addAll(getBaseData());
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

  @override
  Map<String, dynamic> toJson() => {
        TangemSdk.userProtectedData: userProtectedData.toHexString(),
        TangemSdk.userProtectedCounter: userProtectedCounter,
      }..addAll(getBaseData());
}

class PinCode1Model extends SignatureDataModel {
  final String pinCode;

  PinCode1Model(this.pinCode) : super(TangemSdk.cSetPin1);

  @override
  Map<String, dynamic> toJson() => {
        TangemSdk.pinCode: pinCode,
      }..addAll(getBaseData());
}

class PinCode2Model extends SignatureDataModel {
  final String pinCode;

  PinCode2Model(this.pinCode) : super(TangemSdk.cSetPin2);

  @override
  Map<String, dynamic> toJson() => {
        TangemSdk.pinCode: pinCode,
      }..addAll(getBaseData());
}
