part of 'common_segment_widget.dart';

abstract class BaseSegment {
  final PersonalizationBloc _bloc;
  final List<StreamSubscription> _subscriptions = [];

  PersonalizationConfig _config;

  BaseSegment(this._bloc, this._config) {
    _initSubscriptions();
  }

  update(PersonalizationConfig config) {
    this._config = config;
    _configWasUpdated();
  }

  bool isCustom(Pair pair) => pair.a == PersonalizationValues.CUSTOM && pair.b == PersonalizationValues.CUSTOM;

  dispose() {
    _subscriptions.forEach((element) => element.cancel());
  }

  _initSubscriptions();
  _configWasUpdated();
}
