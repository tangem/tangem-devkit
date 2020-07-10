import 'package:devkit/commons/common_abstracts.dart';
import 'package:intl/intl.dart';

class PersonalizationValues {
  static final String CUSTOM = "--- CUSTOM ---";
  static final Pair<String, String> _customPair = Pair(CUSTOM, CUSTOM);

  List<Pair<String, String>> _curves = [
    Pair("secp256k1", "secp256k1"),
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
    Pair("XPR", "XPR"),
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

  bool has(Pair pair, List<Pair> into) => into.firstWhere((element) => element.a == pair.a && element.b == pair.b, orElse: () => null) != null;

  bool hasValue(dynamic value, List<Pair> into) => into.firstWhere((element) => element.b == value, orElse: () => null) != null;

  Pair getOrNull(dynamic value, List<Pair> from) => from.firstWhere((element) => element.b == value, orElse: () => null);

  bool hasBlockchain(dynamic value) => hasValue(value, blockchain);

  bool hasCurve(dynamic value) => hasValue(value, curves);

  bool hasAar(dynamic value) => hasValue(value, aar);

  bool hasPauseBeforePin(dynamic value) => hasValue(value, pauseBeforePin);

  Pair<String, String> getBlockchain(dynamic value) => getOrNull(value, blockchain);

  Pair<String, String> getCurve(String value) {
    Pair curve = getOrNull(value, curves);
    return curve ?? getOrNull(toBeginningOfSentenceCase(value), _curves);
  }

  Pair<String, String> getAar(dynamic value) => getOrNull(value, aar);

  Pair<String, int> getPauseBeforePin(dynamic value) => getOrNull(value, pauseBeforePin);

  Pair<String, String> getCustom() => _customPair;
}
