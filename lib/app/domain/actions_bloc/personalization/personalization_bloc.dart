import 'package:devkit/app/domain/actions_bloc/personalization/personalization_values.dart';
import 'package:devkit/app/domain/model/personalization/peresonalization.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'segments/common_segment.dart';
import 'store.dart';

abstract class PersonalizationState {}

class Loading extends PersonalizationState {}

class Done extends PersonalizationState {}

class ShowLoadConfig extends PersonalizationState {}

class PersonalizationBloc {
  PersonalizationValues values = PersonalizationValues();

  List<BaseSegment> _configSegments = [];
  PersonalizationConfigStore _store;

  PublishSubject<List<String>> psSavedConfigNames = PublishSubject();

  CommonSegment common;

  PersonalizationBloc() {
    logD(this, "new instance");
    _store = PersonalizationConfigStore(_getDefaultConfig);
    _store.load();
    _initSegments();
    _updateConfigIntoTheSegments(_store.getCurrent());
  }

  _initSegments() {
    final currentConfig = _store.getCurrent();
    common = CommonSegment(this, currentConfig);

    _configSegments.add(common);
  }

  resetToDefaultConfig() {
    _store.setCurrent(_store.getDefault());
    _store.save();
    _updateConfigIntoTheSegments(_store.getCurrent());
  }

  saveConfig() {
    _store.save();
  }

  fetchSavedConfigNames() {
    List<String> listNames = _store.getNames();
    psSavedConfigNames.add(listNames);
  }

  saveNewConfig(String name) {
    _store.set(name, _store.getCurrent());
    _store.save();
  }

  deleteConfig(String name) {
    _store.remove(name);
    _store.save();
  }

  _updateConfigIntoTheSegments(PersonalizationConfig config) {
    _configSegments.forEach((element) => element.update(config));
  }

  PersonalizationConfig _getDefaultConfig() => PersonalizationConfig.getDefault();

  dispose() {
    _configSegments.forEach((element) => element.dispose());
    _store.save();
  }
}
