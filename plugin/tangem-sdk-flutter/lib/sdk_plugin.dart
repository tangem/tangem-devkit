import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/model/command_data.dart';
import 'package:tangem_sdk/model/json_rpc.dart';
import 'package:tangem_sdk/plugin_error.dart';

import 'extensions/exp_extensions.dart';
import 'model/sdk.dart';

/// Flutter TangemSdk is an interface which provides access to platform specific TangemSdk library.
/// The response from the successfully completed execution of the 'channel method' is expected in the json.
/// If an error occurs within the 'channel method', it is expected PlatformException converter to the json.
class TangemSdk {
  static const commandType = "commandType";

  static const cStartSession = 'startSession';
  static const cStopSession = 'stopSession';
  static const cScanCard = 'scanCard';
  static const cSign = 'sign';
  static const cPersonalize = 'personalize';
  static const cDepersonalize = 'depersonalize';
  static const cCreateWallet = 'createWallet';
  static const cPurgeWallet = 'purgeWallet';
  static const cReadIssuerData = 'readIssuerData';
  static const cWriteIssuerData = 'writeIssuerData';
  static const cReadIssuerExData = 'readIssuerExData';
  static const cWriteIssuerExData = 'writeIssuerExData';
  static const cReadUserData = 'readUserData';
  static const cWriteUserData = 'writeUserData';
  static const cWriteUserProtectedData = 'writeUserProtectedData';
  static const cSetPin1 = 'setPin1';
  static const cSetPin2 = 'setPin2';
  static const cWriteFiles = 'writeFiles';
  static const cReadFiles = 'readFiles';
  static const cDeleteFiles = 'deleteFiles';
  static const cChangeFilesSettings = 'changeFilesSettings';
  static const cPrepareHashes = "prepareHashes";
  static const cJsonRpcRequest = 'runJSONRPCRequest';

  static const isAllowedOnlyDebugCards = "isAllowedOnlyDebugCards";
  static const cardId = "cardId";
  static const initialMessage = "initialMessage";
  static const initialMessageHeader = "header";
  static const initialMessageBody = "body";
  static const hashes = "hashes";
  static const walletPublicKey = "walletPublicKey";

  //TODO: replace by walletPublicKey
  @Deprecated("replace by walletPublicKey")
  static const walletIndex = "walletIndex";
  static const walletConfig = "config";
  static const cardConfig = "config";
  static const issuer = "issuer";
  static const manufacturer = "manufacturer";
  static const acquirer = "acquirer";
  static const issuerData = "issuerData";
  static const issuerDataSignature = "issuerDataSignature";
  static const startingSignature = "startingSignature";
  static const finalizingSignature = "finalizingSignature";
  static const issuerDataCounter = "issuerDataCounter";
  static const userData = "userData";
  static const userCounter = "userCounter";
  static const userProtectedData = "userProtectedData";
  static const userProtectedCounter = "userProtectedCounter";
  static const pinCode = "pinCode";
  static const files = "files";
  static const fileData = "fileData";
  static const fileCounter = "fileCounter";
  static const readPrivateFiles = "readPrivateFiles";
  static const indices = "indices";
  static const counter = "counter";
  static const changes = "changes";
  static const privateKey = "privateKey";
  static const jsonRpcRequest = 'JSONRPCRequest';
  static const jsonRpcResponse = 'JSONRPCResponse';

  static const _jsonRpcCommands = {
    cScanCard: 'SCAN_TASK',
    cSign: 'SIGN_COMMAND',
    cPersonalize: 'PERSONALIZE_COMMAND',
    cDepersonalize: 'DEPERSONALIZE_COMMAND',
    cCreateWallet: 'createWallet',
    cPurgeWallet: 'purgeWallet',
    cReadIssuerData: 'readIssuerData',
    cWriteIssuerData: 'writeIssuerData',
    cReadIssuerExData: 'readIssuerExData',
    cWriteIssuerExData: 'writeIssuerExData',
    cReadUserData: 'readUserData',
    cWriteUserData: 'writeUserData',
    cWriteUserProtectedData: 'writeUserProtectedData',
    cSetPin1: 'setPin1',
    cSetPin2: 'setPin2',
    cWriteFiles: 'writeFiles',
    cReadFiles: 'readFiles',
    cDeleteFiles: 'deleteFiles',
    cChangeFilesSettings: 'changeFilesSettings',
  };

  static String? getJsonRpcMethod(String commandType) {
    return _jsonRpcCommands[commandType];
  }

  static const MethodChannel _channel = const MethodChannel('tangemSdk');
  static const MethodChannel _channelJSONRPC = const MethodChannel('tangemSdk_JSONRPC');

  static Future startSession(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cStartSession, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cStartSession, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future stopSession(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cStopSession, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cStopSession, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future allowsOnlyDebugCards(bool isAllowed) {
    return _channel.invokeMethod("allowsOnlyDebugCards", {isAllowedOnlyDebugCards: isAllowed});
  }

  static Future runCommand(Callback callback, CommandDataModel command) async {
    await prepareCommandData(command, callback, (commandJsonMap) {
      final type = commandJsonMap[commandType];
      _channel
          .invokeMethod(type, commandJsonMap)
          .then((result) => callback.onSuccess(_createResponse(type, result)))
          .catchError((error) => _sendBackError(callback, error));
    });
  }

  static Future runCommandAsJson(Callback callback, CommandDataModel command) async {
    await prepareCommandData(command, callback, (commandJsonMap) {
      final type = commandJsonMap[commandType];
      final jsonRpc = JSONRPCRequest.fromCommandDataJson(commandJsonMap);
      _channel
          .invokeMethod(cJsonRpcRequest, jsonRpc.toJson())
          .then((result) => callback.onSuccess(_createResponse(type, result)))
          .catchError((error) => _sendBackError(callback, error));
    });
  }

  static Future prepareCommandData(
    CommandDataModel command,
    Callback callback,
    Function(Map<String, dynamic> commandJsonMap) onPrepareComplete,
  ) async {
    Map<String, dynamic> jsonMap = {};
    try {
      final map = command.toJson((error) => _sendBackError(callback, error));
      if (map == null) {
        return;
      } else {
        jsonMap = map;
      }
    } catch (exception) {
      _sendBackError(callback, PluginFlutterError("Can't get command json data. Error: ${exception.toString()}"));
      return;
    }

    final type = jsonMap[commandType];
    if (type == null) {
      _sendBackError(callback, PluginFlutterError("Can't execute the task. Missing the '$commandType' field"));
      return;
    }
    onPrepareComplete(jsonMap);
  }

  static Future scanCard(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cScanCard, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cScanCard, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future sign(Callback callback, List<String> hashesHex,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[hashes] = hashesHex;
    _channel
        .invokeMethod(cSign, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cSign, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future personalize(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cPersonalize, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cPersonalize, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future depersonalize(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cDepersonalize, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cDepersonalize, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future createWallet(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cCreateWallet, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cCreateWallet, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future purgeWallet(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cPurgeWallet, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cPurgeWallet, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeIssuerData(Callback callback, String issuerDataHex, String issuerDataSignatureHex,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[issuerData] = issuerDataHex;
    valuesToExport[issuerDataSignature] = issuerDataSignatureHex;
    _channel
        .invokeMethod(cWriteIssuerData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteIssuerData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readIssuerData(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cReadIssuerData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadIssuerData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeIssuerExtraData(
      Callback callback, String issuerDataHex, String startingSignatureHex, String finalizingSignatureHex,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[issuerData] = issuerDataHex;
    valuesToExport[startingSignature] = startingSignatureHex;
    valuesToExport[finalizingSignature] = finalizingSignatureHex;
    _channel
        .invokeMethod(cWriteIssuerExData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteIssuerExData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readIssuerExtraData(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cReadIssuerExData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadIssuerExData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeUserData(Callback callback, String userDataHex,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[userData] = userDataHex;
    _channel
        .invokeMethod(cWriteUserData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteUserData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readUserData(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cReadUserData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadUserData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeUserProtectedData(Callback callback, String userProtectedDataHex,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[userProtectedData] = userProtectedDataHex;
    _channel
        .invokeMethod(cWriteUserProtectedData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteUserData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future setPinCode(Callback callback, PinType pinType, [Map<String, dynamic> valuesToExport = const {}]) async {
    final cPinMethod = pinType == PinType.PIN1 ? cSetPin1 : cSetPin2;
    _channel
        .invokeMethod(cPinMethod, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cPinMethod, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeFiles(Callback callback, List<FileDataHex> filesData,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[files] = jsonEncode(filesData);
    _channel
        .invokeMethod(cWriteFiles, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteFiles, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readFiles(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cReadFiles, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadFiles, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future deleteFiles(Callback callback, [Map<String, dynamic> valuesToExport = const {}]) async {
    _channel
        .invokeMethod(cDeleteFiles, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cDeleteFiles, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future changeFilesSettings(Callback callback, List<ChangeFileSettings> changes,
      [Map<String, dynamic> valuesToExport = const {}]) async {
    valuesToExport[TangemSdk.changes] = jsonEncode(changes);
    _channel
        .invokeMethod(cChangeFilesSettings, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cChangeFilesSettings, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future prepareHashes(Callback callback, String cid, String fileDataHex, int counter,
      [String? privateKeyHex]) async {
    final valuesToExport = <String, dynamic>{
      cid: cid,
      fileData: fileDataHex,
      fileCounter: counter,
      privateKey: privateKeyHex,
    };
    _channel
        .invokeMethod(cPrepareHashes, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cPrepareHashes, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static dynamic _createResponse(String name, dynamic response) {
    final jsonResponse = jsonDecode(response);

    switch (name) {
      case cScanCard:
        return CardResponse.fromJson(jsonResponse);
      case cSign:
        return SignResponse.fromJson({"signedHashes": jsonResponse});
      case cPersonalize:
        return CardResponse.fromJson(jsonResponse);
      case cDepersonalize:
        return DepersonalizeResponse.fromJson(jsonResponse);
      case cCreateWallet:
        return CreateWalletResponse.fromJson(jsonResponse);
      case cPurgeWallet:
        return PurgeWalletResponse.fromJson(jsonResponse);
      case cReadIssuerData:
        return ReadIssuerDataResponse.fromJson(jsonResponse);
      case cWriteIssuerData:
        return WriteIssuerDataResponse.fromJson(jsonResponse);
      case cReadIssuerExData:
        return ReadIssuerExDataResponse.fromJson(jsonResponse);
      case cWriteIssuerExData:
        return WriteIssuerExDataResponse.fromJson(jsonResponse);
      case cReadUserData:
        return ReadUserDataResponse.fromJson(jsonResponse);
      case cWriteUserData:
        return WriteUserDataResponse.fromJson(jsonResponse);
      case cWriteUserProtectedData:
        return WriteUserDataResponse.fromJson(jsonResponse);
      case cSetPin1:
        return SetPinResponse.fromJson(jsonResponse);
      case cSetPin2:
        return SetPinResponse.fromJson(jsonResponse);
      case cWriteFiles:
        return WriteFilesResponse.fromJson(jsonResponse);
      case cReadFiles:
        return ReadFilesResponse.fromJson(jsonResponse);
      case cDeleteFiles:
        return DeleteFilesResponse.fromJson(jsonResponse);
      case cChangeFilesSettings:
        return ChangeFilesSettingsResponse.fromJson(jsonResponse);
      case cPrepareHashes:
        return FileHashDataHex.fromJson(jsonResponse);
    }
    return response;
  }

  static _sendBackError(Callback callback, dynamic error) {
    callback.onError(TangemSdkPluginError.createError(error));
  }

  static Future runJSONRPCRequest(
    Callback callback,
    JSONRPCRequest request, [
    String? cardId,
    Message? initialMessage,
  ]) async {
    final valuesToExport = <String, dynamic>{TangemSdk.jsonRpcRequest: jsonEncode(request.toJson())};
    cardId?.let((it) => valuesToExport[TangemSdk.cardId] = it);
    initialMessage?.let((it) => valuesToExport[TangemSdk.initialMessage] = it.toJson());

    _channelJSONRPC
        .invokeMethod(cJsonRpcRequest, valuesToExport)
        .then((result) => callback.onSuccess(_createJSONRPCResponse(result)))
        .catchError((error) => _sendBackError(callback, error));
  }
  // все ошибки перехваченные этим методом должны прерывать выполнение теста

  static dynamic _createJSONRPCResponse(dynamic response) {
    final jsonResponse = jsonDecode(response);
    return JSONRPCResponse.fromJson(jsonResponse);
  }
}

class Callback {
  final Function(dynamic success) onSuccess;
  final Function(dynamic error) onError;

  Callback(this.onSuccess, this.onError);
}
