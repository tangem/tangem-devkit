// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JSONRPCRequest _$JSONRPCRequestFromJson(Map<String, dynamic> json) {
  return JSONRPCRequest(
    json['method'] as String,
    json['parameters'] as Map<String, dynamic>,
    json['id'],
    json['jsonrpc'] as String,
  );
}

Map<String, dynamic> _$JSONRPCRequestToJson(JSONRPCRequest instance) => <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'parameters': instance.parameters,
    };

JSONRPCResponse _$JSONRPCResponseFromJson(Map<String, dynamic> json) {
  return JSONRPCResponse(
    json['result'],
    json['error'],
    json['id'],
    json['jsonrpc'] as String,
  );
}

Map<String, dynamic> _$JSONRPCResponseToJson(JSONRPCResponse instance) => <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'result': instance.result,
      'error': instance.error,
    };
