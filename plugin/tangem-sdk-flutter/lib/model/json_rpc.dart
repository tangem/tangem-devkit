import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

part 'json_rpc.g.dart';

abstract class JSONRPC {
  final dynamic id;
  final String jsonrpc;

  JSONRPC(this.id, this.jsonrpc);

  static String? getJsonRpcMethod(String commandType) {
    switch (commandType) {
      case TangemSdk.cScanCard:
        {
          return "SCAN_TASK";
        }
      case TangemSdk.cSign:
        {
          return TangemSdk.cSign;
        }
      case TangemSdk.cPersonalize:
        {
          return TangemSdk.cPersonalize;
        }
      case TangemSdk.cDepersonalize:
        {
          return TangemSdk.cDepersonalize;
        }
      case TangemSdk.cCreateWallet:
        {
          return TangemSdk.cCreateWallet;
        }
      case TangemSdk.cPurgeWallet:
        {
          return TangemSdk.cPurgeWallet;
        }
      case TangemSdk.cReadIssuerData:
        {
          return TangemSdk.cReadIssuerData;
        }
      case TangemSdk.cWriteIssuerData:
        {
          return TangemSdk.cWriteIssuerData;
        }
      case TangemSdk.cReadIssuerExData:
        {
          return TangemSdk.cReadIssuerExData;
        }
      case TangemSdk.cWriteIssuerExData:
        {
          return TangemSdk.cWriteIssuerExData;
        }
      case TangemSdk.cReadUserData:
        {
          return TangemSdk.cReadUserData;
        }
      case TangemSdk.cWriteUserData:
        {
          return TangemSdk.cWriteUserData;
        }
      case TangemSdk.cWriteUserProtectedData:
        {
          return TangemSdk.cWriteUserProtectedData;
        }
      case TangemSdk.cSetPin1:
        {
          return TangemSdk.cSetPin1;
        }
      case TangemSdk.cSetPin2:
        {
          return TangemSdk.cSetPin2;
        }
      case TangemSdk.cWriteFiles:
        {
          return TangemSdk.cWriteFiles;
        }
      case TangemSdk.cReadFiles:
        {
          return TangemSdk.cReadFiles;
        }
      case TangemSdk.cDeleteFiles:
        {
          return TangemSdk.cDeleteFiles;
        }
      case TangemSdk.cChangeFilesSettings:
        {
          return TangemSdk.cChangeFilesSettings;
        }
      case TangemSdk.cPrepareHashes:
        {
          return TangemSdk.cPrepareHashes;
        }
    }
    return null;
  }
}

@JsonSerializable()
class JSONRPCRequest extends JSONRPC {
  final String method;
  final Map<String, dynamic> params;

  JSONRPCRequest(this.method, this.params, [dynamic id, String jsonrpc = "2.0"]) : super(id, jsonrpc);

  Map<String, dynamic> toJson() => _$JSONRPCRequestToJson(this);

  factory JSONRPCRequest.fromJson(Map<String, dynamic> json) => _$JSONRPCRequestFromJson(json);

  factory JSONRPCRequest.fromCommandDataJson(Map<String, dynamic> commandDataJson) {
    final method = JSONRPC.getJsonRpcMethod(commandDataJson.remove(TangemSdk.commandType)) ?? "";
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
