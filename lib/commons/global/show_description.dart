import 'package:rxdart/rxdart.dart';

class DescriptionState {
  static BehaviorSubject<bool> _showDescription = BehaviorSubject<bool>();
  static bool _state = false;

  static bool get state => _state;

  static init(bool initialValue) {
    _showDescription.listen((event) => _state = event);
    _showDescription.add(initialValue);
  }

  static add(bool state) {
    _showDescription.add(state);
  }

  static Stream<bool> listen() => _showDescription.stream;

  static toggle() {
    add(!_state);
  }
}
