import 'package:bloc/bloc.dart';
import 'package:devkit/app/domain/actions_bloc/card_optional_values.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../base_events.dart';
import 'depersonalize_card_es.dart';

class DepersonalizeBloc extends Bloc<Event, SDepersonalize> {
  @override
  SDepersonalize get initialState => SDepersonalize();

  @override
  Stream<SDepersonalize> mapEventToState(Event event) async* {
    if (event is ECardDepersonalizeError) {
      yield SCardDepersonalizeError(event.error);
    } else if (event is ECardDepersonalizeSuccess) {
      yield SCardDepersonalizeSuccess(event.success);
    } else if (event is EDepersonalize) {
      _onDepersonalize();
    }
  }

  _onDepersonalize() {
    final callback = Callback((result) {
      add(ECardDepersonalizeSuccess(result));
    }, (error) {
      add(ECardDepersonalizeError(error));
    });
    TangemSdk.depersonalize(
      callback,
      CardOptionalValues().get(),
    );
  }
}