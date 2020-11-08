import 'package:bloc/bloc.dart';
import 'package:devkit/app/domain/actions_bloc/scan_card/scan_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/scan_card/scan_card_es.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../base_events.dart';
import 'sign_card_es.dart';
import 'sign_events.dart';
import 'sign_state.dart';

class SignBloc extends Bloc<Event, SSign> {
  @override
  SSign get initialState => SSign.initial();

  @override
  Stream<SSign> mapEventToState(Event event) async* {
    if (event is ECardScanSuccess) {
      final cid = parseCidFromSuccessScan(event.success);
      yield state.copyWith(cid: cid, theseFromBloc: true);
    } else if (event is ECardActionError) {
      yield SCardSignError(event.error, state);
    } else if (event is ECardSignSuccess) {
      yield SCardSignSuccess(event.success, state);
    } else if (event is EInitSign) {
      yield SSign.def();
    } else if (event is ECidChanged) {
      yield state.copyWith(cid: event.cid);
    } else if (event is EDataChanged) {
      yield state.copyWith(dataForHashing: event.dataForHashing);
    } else if (event is ESign) {
      _onSign();
    }
  }

  _onSign() {
    final callback = Callback((result) {
      add(ECardSignSuccess(result));
    }, (error) {
      add(ECardSignError(error));
    });
    List<String> listOfData = state.dataForHashing?.toList(ifEmpty: []);
    TangemSdk.runCommand(callback, SignModel(listOfData)..cardId = state.cid);
  }
}
