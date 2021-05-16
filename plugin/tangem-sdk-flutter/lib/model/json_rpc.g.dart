// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) {
  return JsonRpcRequest(
    json['method'] as String,
    json['parameters'] as Map<String, dynamic>,
    json['id'],
  );
}

Map<String, dynamic> _$JsonRpcRequestToJson(JsonRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'parameters': instance.parameters,
    };

JsonRpcResponse _$JsonRpcResponseFromJson(Map<String, dynamic> json) {
  return JsonRpcResponse(
    json['result'],
    json['error'],
    json['id'],
  );
}

Map<String, dynamic> _$JsonRpcResponseToJson(JsonRpcResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'error': instance.error,
    };
