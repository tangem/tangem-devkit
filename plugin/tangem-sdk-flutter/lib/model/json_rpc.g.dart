// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JSONRPCRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) {
  return JSONRPCRequest(
    json['method'] as String,
    json['parameters'] as Map<String, dynamic>,
    json['id'],
    json['jsonRpc'] as String,
  );
}

Map<String, dynamic> _$JsonRpcRequestToJson(JSONRPCRequest instance) => <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'parameters': instance.parameters,
      'jsonRpc': instance.jsonrpc,
    };

JSONRPCResponse _$JsonRpcResponseFromJson(Map<String, dynamic> json) {
  return JSONRPCResponse(
    json['result'],
    json['error'],
    json['id'],
    json['jsonRpc'] as String,
  );
}

Map<String, dynamic> _$JsonRpcResponseToJson(JSONRPCResponse instance) => <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'error': instance.error,
      'jsonRpc': instance.jsonrpc,
    };
