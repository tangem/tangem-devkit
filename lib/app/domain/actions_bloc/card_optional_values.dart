import 'package:tangem_sdk/tangem_sdk.dart';

class CardOptionalValues {
  final _values = <String, dynamic>{};

  CardOptionalValues cid(String cid) {
    _values[TangemSdk.cid] = cid;
    return this;
  }

  CardOptionalValues initialMessage([String header = "Header", String body = "body of message"]) {
    _values[TangemSdk.initialMessage] = {
      TangemSdk.initialMessageHeader: header,
      TangemSdk.initialMessageBody: body,
    };
    return this;
  }

  Map<String, dynamic> get() => _values;
}
