import 'package:bloc/bloc.dart';

import 'sign_events.dart';
import 'sign_state.dart';

class SignBloc extends Bloc<Event, SignState> {
  final RegExp regCid = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  final RegExp reqData = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  @override
  SignState get initialState => SignState.initial();

  @override
  Stream<SignState> mapEventToState(Event event) async* {
    if (event is CidChanged) {
      yield state.copyWith(cid: event.cid, cidIsValid: regCid.hasMatch(event.cid));
    }
    if (event is DataChanged) {
      yield state.copyWith(dataForHashing: event.dataForHashing, dataForHashingIsValid: reqData.hasMatch(event.dataForHashing));
    }
  }
}
