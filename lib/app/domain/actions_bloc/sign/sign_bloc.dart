import 'package:bloc/bloc.dart';
import 'package:devkit/commons/extensions/export.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../base_events.dart';
import 'sign_events.dart';
import 'sign_state.dart';

class SignBloc extends Bloc<Event, SSign> {
  @override
  SSign get initialState => SSign.initial();

  @override
  Stream<SSign> mapEventToState(Event event) async* {
    if (event is EInitSign) {
      yield SSign.def();
    } else if (event is ECidChanged) {
      yield state.copyWith(cid: event.cid);
    } else if (event is EDataChanged) {
      yield state.copyWith(dataForHashing: event.dataForHashing);
    } else if (event is ESign) {
      _onSign();
    } else if (event is ESignSuccess) {
      yield SSignSuccess(event.success, state);
    } else if (event is ESignError) {
      yield SSignError(event.error, state);
    } else if (event is EReadCard) {
      onReadCard(this);
    } else if (event is EReadSuccess) {
      final cid = _parseCidFromSuccessRead(event.success);
      yield state.copyWith(cid: cid, theseFromBloc: true);
    } else if (event is EReadError) {
      yield SSignError(event.error, state);
    }
  }

  String _parseCidFromSuccessRead(Object success) {
    return "bb03000000000004";
  }

  _onSign() {
    final callback = Callback((result) {
      add(ESignSuccess(result));
    }, (error) {
      add(ESignError(error));
    });
    TangemSdk.sign(callback, state.cid, [
      state.dataForHashing.toHexString(),
      state.dataForHashing.toHexString(),
    ]);
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
