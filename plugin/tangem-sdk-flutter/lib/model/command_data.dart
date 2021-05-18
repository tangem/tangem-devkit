import 'dart:async';

import 'package:tangem_sdk/model/sdk.dart';

import '../sdk_plugin.dart';

typedef ConversionError = Function(dynamic);
typedef PrepareError = Function(dynamic);

abstract class CommandDataModel {
  final Exception notPrepared = Exception("Data not prepared");
  final String type;
  String? cardId;
  Message? initialMessage;

  CommandDataModel(this.type);

  Map<String, dynamic>? toJson(ConversionError onError) => getBaseData();

  Future prepare() async => Completer()
    ..complete()
    ..future;

  bool isPrepared() => true;

  Map<String, dynamic> getBaseData() {
    final map = <String, dynamic>{TangemSdk.commandType: type};
    if (cardId != null) map[TangemSdk.cid] = cardId;
    if (initialMessage != null) map[TangemSdk.initialMessage] = initialMessage!.toJson();
    return map;
  }

  static T attachBaseData<T extends CommandDataModel>(T taskData, Map<String, dynamic> json) {
    taskData.cardId = json[TangemSdk.cid];
    if (json[TangemSdk.initialMessage] != null)
      taskData.initialMessage = Message.fromJson(json[TangemSdk.initialMessage]);
    return taskData;
  }
}
