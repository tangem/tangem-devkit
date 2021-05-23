import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

part 'json_rpc.g.dart';

abstract class JsonRpc {
  final dynamic id;
  final String jsonrpc;

  JsonRpc(this.id, [this.jsonrpc = "2.0"]);

  static String? getJsonRpcMethod(String commandType) {
    switch (commandType) {
      case TangemSdk.cScanCard:
        {
          return TangemSdkJson.methodScan;
        }
      case TangemSdk.cSign:
        {
          return "";
        }
      case TangemSdk.cPersonalize:
        {
          return "";
        }
      case TangemSdk.cDepersonalize:
        {
          return "";
        }
      case TangemSdk.cCreateWallet:
        {
          return "";
        }
      case TangemSdk.cPurgeWallet:
        {
          return "";
        }
      case TangemSdk.cReadIssuerData:
        {
          return "";
        }
      case TangemSdk.cWriteIssuerData:
        {
          return "";
        }
      case TangemSdk.cReadIssuerExData:
        {
          return "";
        }
      case TangemSdk.cWriteIssuerExData:
        {
          return "";
        }
      case TangemSdk.cReadUserData:
        {
          return "";
        }
      case TangemSdk.cWriteUserData:
        {
          return "";
        }
      case TangemSdk.cWriteUserProtectedData:
        {
          return "";
        }
      case TangemSdk.cSetPin1:
        {
          return "";
        }
      case TangemSdk.cSetPin2:
        {
          return "";
        }
      case TangemSdk.cWriteFiles:
        {
          return "";
        }
      case TangemSdk.cReadFiles:
        {
          return "";
        }
      case TangemSdk.cDeleteFiles:
        {
          return "";
        }
      case TangemSdk.cChangeFilesSettings:
        {
          return "";
        }
      case TangemSdk.cPrepareHashes:
        {
          return "";
        }
    }
    return null;
  }
}

@JsonSerializable()
class JsonRpcRequest extends JsonRpc {
  final String method;
  final Map<String, dynamic> parameters;

  JsonRpcRequest(this.method, this.parameters, [dynamic id]) : super(id);

  Map<String, dynamic> toJson() => _$JsonRpcRequestToJson(this);

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) => _$JsonRpcRequestFromJson(json);

  factory JsonRpcRequest.fromCommandDataJson(Map<String, dynamic> commandDataJson) {
    final method = JsonRpc.getJsonRpcMethod(commandDataJson.remove(TangemSdk.commandType)) ?? "";
    return JsonRpcRequest(method, commandDataJson);
  }
}

@JsonSerializable()
class JsonRpcResponse extends JsonRpc {
  final dynamic result;
  final dynamic error;

  JsonRpcResponse(this.result, this.error, [dynamic id]) : super(id);

  Map<String, dynamic> toJson() => _$JsonRpcResponseToJson(this);

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) => _$JsonRpcResponseFromJson(json);
}
