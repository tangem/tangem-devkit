import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

part 'json_rpc.g.dart';

abstract class JSONRPC {
  final dynamic id;
  final String jsonrpc;

  JSONRPC(this.id, this.jsonrpc);

  static final _methods = {
    TangemSdk.cScanCard: "SCAN",
    TangemSdk.cPreflightRead: "PREFLIGHT_READ",
    TangemSdk.cSignHash: "SIGN_HASH",
    TangemSdk.cSignHashes: "SIGN_HASHES",
    TangemSdk.cPersonalize: "PERSONALIZE",
    TangemSdk.cDepersonalize: "DEPERSONALIZE",
    TangemSdk.cCreateWallet: "CREATE_WALLET",
    TangemSdk.cPurgeWallet: "PURGE_WALLET",
    TangemSdk.cReadIssuerData: TangemSdk.cReadIssuerData,
    TangemSdk.cWriteIssuerData: TangemSdk.cWriteIssuerData,
    TangemSdk.cReadIssuerExData: TangemSdk.cReadIssuerExData,
    TangemSdk.cWriteIssuerExData: TangemSdk.cWriteIssuerExData,
    TangemSdk.cReadUserData: TangemSdk.cReadUserData,
    TangemSdk.cWriteUserData: TangemSdk.cWriteUserData,
    TangemSdk.cWriteUserProtectedData: TangemSdk.cWriteUserProtectedData,
    TangemSdk.cSetAccessCode: "SET_ACCESSCODE",
    TangemSdk.cSetPasscode: "SET_PASSCODE",
    TangemSdk.cResetUserCodes: "RESET_USERCODES",
    TangemSdk.cWriteFiles: TangemSdk.cWriteFiles,
    TangemSdk.cReadFiles: TangemSdk.cReadFiles,
    TangemSdk.cDeleteFiles: TangemSdk.cDeleteFiles,
    TangemSdk.cChangeFilesSettings: TangemSdk.cChangeFilesSettings,
    TangemSdk.cPrepareHashes: TangemSdk.cPrepareHashes,
  };

  static String? getJsonRpcMethod(String commandType) {
    return _methods[commandType];
  }
}

@JsonSerializable()
class JSONRPCRequest extends JSONRPC {
  final String method;
  final Map<String, dynamic> params;

  JSONRPCRequest(this.method, this.params, [dynamic id = 1, String jsonrpc = "2.0"]) : super(id, jsonrpc);

  Map<String, dynamic> toJson() => _$JSONRPCRequestToJson(this);

  factory JSONRPCRequest.fromJson(Map<String, dynamic> json) => _$JSONRPCRequestFromJson(json);

  factory JSONRPCRequest.fromCommandDataJson(Map<String, dynamic> commandDataJson) {
    final commandType = commandDataJson.remove(TangemSdk.commandType);
    final method = JSONRPC.getJsonRpcMethod(commandType);
    if (method == null) {
      throw UnimplementedError("JSONRPCRequest not implemented yet for the command: $commandType");
    }

    commandDataJson.remove(TangemSdk.cardId);
    commandDataJson.remove(TangemSdk.initialMessage);
    return JSONRPCRequest(method, commandDataJson);
  }
}

@JsonSerializable()
class JSONRPCResponse extends JSONRPC {
  final dynamic result;
  final dynamic error;

  JSONRPCResponse(this.result, this.error, [dynamic id, String jsonrpc = "2.0"]) : super(id, jsonrpc);

  Map<String, dynamic> toJson() => _$JSONRPCResponseToJson(this);

  factory JSONRPCResponse.fromJson(Map<String, dynamic> json) => _$JSONRPCResponseFromJson(json);
}
