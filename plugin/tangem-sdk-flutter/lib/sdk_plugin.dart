import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/model/command_data.dart';
import 'package:tangem_sdk/model/json_rpc.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'extensions/exp_extensions.dart';
import 'model/sdk.dart';

/// Flutter TangemSdk is an interface which provides access to platform specific TangemSdk library.
/// The response from the successfully completed execution of the 'channel method' is expected in the json.
/// If an error occurs within the 'channel method', it is expected PlatformException converter to the json.
class TangemSdk {
  static const commandType = "commandType";

  static const cJsonRpcRequest = 'runJSONRPCRequest';
  static const cScanCard = 'scanCard';
  static const cPreflightRead = 'preflightRead';
  static const cSignHash = 'signHash';
  static const cSignHashes = 'signHashes';
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
  static const cSetAccessCode = 'setAccessCode';
  static const cSetPasscode = 'setPasscode';
  static const cResetUserCodes = 'resetUserCodes';
  static const cWriteFiles = 'writeFiles';
  static const cReadFiles = 'readFiles';
  static const cDeleteFiles = 'deleteFiles';
  static const cChangeFilesSettings = 'changeFilesSettings';
  static const cPrepareHashes = "prepareHashes";

  static const isAllowedOnlyDebugCards = "isAllowedOnlyDebugCards";
  static const jsonRpcRequest = "JSONRPCRequest";
  static const cardId = "cardId";
  static const initialMessage = "initialMessage";
  static const initialMessageHeader = "header";
  static const initialMessageBody = "body";
  static const readMode = "readMode";
  static const hash = "hash";
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

  static const MethodChannel _channel = const MethodChannel('tangemSdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @Deprecated("Use runJSONRPCRequest instead")
  static Future runCommand(Callback callback, CommandDataModel command) async {
    await prepareCommandData(command, callback, (commandJsonMap) {
      final type = commandJsonMap[commandType];
      _channel
          .invokeMethod(type, commandJsonMap)
          .then((result) => callback.onSuccess(_createResponse(type, result)))
          .catchError((error) => _sendBackError(callback, error));
    });
  }

  @Deprecated("Use runJSONRPCRequest instead")
  static Future runCommandAsJSONRPCRequest(Callback callback, CommandDataModel command) async {
    await prepareCommandData(command, callback, (commandJsonMap) {
      final cardId = commandJsonMap[TangemSdk.cardId];
      final initialMessage = commandJsonMap[TangemSdk.initialMessage];
      try {
        final jsonRpc = JSONRPCRequest.fromCommandDataJson(commandJsonMap);
        runJSONRPCRequest(callback, jsonRpc, cardId, initialMessage);
      } catch (error) {
        print(error.toString());
        runCommand(callback, command);
      }
    });
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

    _channel
        .invokeMethod(cJsonRpcRequest, valuesToExport)
        .then((result) => callback.onSuccess(_createJSONRPCResponse(result)))
        .catchError((error) => _sendBackError(callback, error));
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
      _sendBackError(callback, TangemSdkError("Can't get command json data. Error: ${exception.toString()}"));
      return;
    }

    final type = jsonMap[commandType];
    if (type == null) {
      _sendBackError(callback, TangemSdkError("Can't execute the task. Missing the '$commandType' field"));
      return;
    }
    onPrepareComplete(jsonMap);
  }

  static Future allowsOnlyDebugCards(bool isAllowed) {
    return _channel.invokeMethod("allowsOnlyDebugCards", {isAllowedOnlyDebugCards: isAllowed});
  }

  static Future prepareHashes(Callback callback, String cardId, String fileDataHex, int counter,
      [String? privateKeyHex]) async {
    final valuesToExport = <String, dynamic>{
      TangemSdk.cardId: cardId,
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

    return jsonResponse;

    switch (name) {
      case cScanCard:
        return ReadResponse.fromJson(jsonResponse);
      case cSignHash:
        return SignHashResponse.fromJson(jsonResponse);
      case cSignHashes:
        return SignResponse.fromJson(jsonResponse);
      case cPersonalize:
        return ReadResponse.fromJson(jsonResponse);
      case cDepersonalize:
        return DepersonalizeResponse.fromJson(jsonResponse);
      case cCreateWallet:
        return CreateWalletResponse.fromJson(jsonResponse);
      case cPurgeWallet:
        return PurgeWalletResponse.fromJson(jsonResponse);
      case cReadIssuerData:
        return ReadIssuerDataResponse.fromJson(jsonResponse);
      case cWriteIssuerData:
        return SuccessResponse.fromJson(jsonResponse);
      case cReadIssuerExData:
        return ReadIssuerExtraDataResponse.fromJson(jsonResponse);
      case cWriteIssuerExData:
        return SuccessResponse.fromJson(jsonResponse);
      case cReadUserData:
        return ReadUserDataResponse.fromJson(jsonResponse);
      case cWriteUserData:
        return SuccessResponse.fromJson(jsonResponse);
      case cWriteUserProtectedData:
        return SuccessResponse.fromJson(jsonResponse);
      case cSetAccessCode:
        return SuccessResponse.fromJson(jsonResponse);
      case cSetPasscode:
        return SuccessResponse.fromJson(jsonResponse);
      case cWriteFiles:
        return WriteFilesResponse.fromJson(jsonResponse);
      case cReadFiles:
        return ReadFilesResponse.fromJson(jsonResponse);
      case cDeleteFiles:
        return SuccessResponse.fromJson(jsonResponse);
      case cChangeFilesSettings:
        return SuccessResponse.fromJson(jsonResponse);
      case cPrepareHashes:
        return FileHashDataHex.fromJson(jsonResponse);
    }
    return response;
  }

  static dynamic _createJSONRPCResponse(dynamic response) {
    final jsonResponse = jsonDecode(response);
    return JSONRPCResponse.fromJson(jsonResponse);
  }

  static _sendBackError(Callback callback, dynamic error) {
    if (error is TangemSdkBaseError) {
      callback.onError(error);
    } else if (error is PlatformException) {
      final jsonString = error.details;
      final map = json.decode(jsonString);
      if (map["code"] == 50002) {
        callback.onError(UserCancelledError(map['localizedDescription']));
      } else {
        callback.onError(SdkPluginError(map['localizedDescription']));
      }
    } else if (error is Exception) {
      callback.onError(SdkPluginError(error.toString()));
    } else {
      callback.onError(SdkPluginError("Unknown plugin error: ${error.toString()}"));
    }
  }
}

abstract class TangemSdkBaseError implements Exception {
  final String message;

  TangemSdkBaseError(this.message);

  String toString() => "${this.runtimeType}: $message";
}

class SdkPluginError extends TangemSdkBaseError {
  SdkPluginError(String message) : super(message);
}

class TangemSdkError extends TangemSdkBaseError {
  TangemSdkError(String message) : super(message);
}

class UserCancelledError extends SdkPluginError {
  UserCancelledError(String message) : super(message);
}

class Callback {
  final Function(dynamic success) onSuccess;
  final Function(dynamic error) onError;

  Callback(this.onSuccess, this.onError);
}

@Deprecated("Use JSONRPC")
class TangemSdkJson {
  static const keyMethod = "method";
  static const keyParams = "parameters";

  static const methodScan = "SCAN_TASK";
}
