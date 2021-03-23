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