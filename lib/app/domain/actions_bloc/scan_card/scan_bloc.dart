import 'package:bloc/bloc.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../base_events.dart';
import '../base_state.dart';

class EScan extends Event {}

class SScan extends SState {}

class SScanSuccess extends SScan with SCardResponseSuccess {
  SScanSuccess(Object success) {
    this.success = success;
  }
}

class SScanError extends SScan with SCardResponseError {
  SScanError(Object error) {
    this.error = error;
  }
}

class ScanBloc extends Bloc<Event, SScan> {
  @override
  SScan get initialState => SScan();

  @override
  Stream<SScan> mapEventToState(Event event) async* {
    if (event is EScan) {
      onReadCard(this);
    } else if (event is EReadSuccess) {
      yield SScanSuccess(event.success);
    } else if (event is EReadError) {
      yield SScanError(event.error);
    }
  }
}

onReadCard(Bloc bloc) {
  final callback = Callback((result) {
    bloc.add(EReadSuccess(result));
  }, (error) {
    bloc.add(EReadError(error));
  });
  TangemSdk.scanCard(callback);
}
