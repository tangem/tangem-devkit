import 'package:devkit/commons/common_abstracts.dart';
import 'package:intl/intl.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

class PersonalizationValues {
  static final String CUSTOM = "--- CUSTOM ---";
  static final Pair<String, String> _customPair = Pair(CUSTOM, CUSTOM);

  List<Pair<String, String>> _curves = [
    Pair("secp256k1", "secp256k1"),
    Pair("secp256r1", "secp256r1"),
    Pair("ed25519", "ed25519"),
  ];

  List<Pair<String, String>> _blockchain = [
    _customPair,
    Pair("BTC", "BTC"),
    Pair("BTC/test", "BTC/test"),
    Pair("ETH", "ETH"),
    Pair("ETH/test", "ETH/test"),
    Pair("BCH", "BCH"),
    Pair("BCH/test", "BCH/test"),
    Pair("LTC", "LTC"),
    Pair("XLM", "XLM"),
    Pair("XLM/test", "XLM/test"),
    Pair("RSK", "RSK"),
    Pair("XRP", "XRP"),
    Pair("CARDANO", "CARDANO"),
    Pair("BNB", "BINANCE"),
    Pair("XTZ", "TEZOS"),
    Pair("DUC", "DUC"),
  ];

  List<Pair<String, String>> _aar = [
    _customPair,
    Pair("Release APP", "com.tangem.wallet"),
    Pair("Debug APP", "com.tangem.wallet.debug"),
    Pair("None", ""),
  ];

  List<Pair<String, int>> _pauseBeforePin = [
    Pair("immediately", 0),
    Pair("2 seconds", 2000),
    Pair("5 seconds", 5000),
    Pair("15 seconds", 15000),
    Pair("30 seconds", 30000),
    Pair("1 minute", 60000),
    Pair("2 minute", 120000),
  ];

  List<Pair<String, String>> get blockchain => _blockchain;

  List<Pair<String, String>> get curves => _curves;

  List<Pair<String, String>> get aar => _aar;

  List<Pair<String, int>> get pauseBeforePin => _pauseBeforePin;

  bool has(Pair pair, List<Pair> into) =>
      into.firstWhereOrNull((element) => element.a == pair.a && element.b == pair.b) != null;

  bool hasValue(dynamic value, List<Pair> into) => into.firstWhereOrNull((element) => element.b == value) != null;

  Pair<String, dynamic>? getOrNull(dynamic value, List<Pair<String, dynamic>> from) {
    return from.firstWhereOrNull((element) => element.b == value);
  }

  bool hasBlockchain(dynamic value) => hasValue(value, blockchain);

  bool hasCurve(dynamic value) => hasValue(value, curves);

  bool hasAar(dynamic value) => hasValue(value, aar);

  bool hasPauseBeforePin(dynamic value) => hasValue(value, pauseBeforePin);

  Pair<String, String>? getBlockchain(dynamic value) => getOrNull(value, blockchain) as Pair<String, String>?;

  Pair<String, String>? getCurve(String value) {
    Pair? curve = getOrNull(value, curves) ?? getOrNull(toBeginningOfSentenceCase(value), _curves);
    return curve == null ? _curves[0] : curve as Pair<String, String>?;
  }

  Pair<String, String>? getAar(dynamic value) => getOrNull(value, aar) as Pair<String, String>?;

  Pair<String, int>? getPauseBeforePin(dynamic value) => getOrNull(value, pauseBeforePin) as Pair<String, int>?;

  Pair<String, String> getCustom() => _customPair;
}
