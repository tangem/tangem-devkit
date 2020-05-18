import 'package:rxdart/rxdart.dart';

class DescriptionState {
  static BehaviorSubject<bool> _showDescription = BehaviorSubject<bool>();

  static Sink<bool> sinkShowDescription = _showDescription.sink;
  static Stream<bool> streamShowDescription = _showDescription.stream;

  static bool _state = false;

  static bool get showDescriptionState => _state;

  static init(bool initialValue) {
    streamShowDescription.listen((event) => _state = event);
    sinkShowDescription.add(initialValue);
  }
}
