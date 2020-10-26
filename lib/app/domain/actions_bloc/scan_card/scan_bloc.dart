import 'package:bloc/bloc.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../base_events.dart';
import 'scan_card_es.dart';

class ScanBloc extends Bloc<Event, SScan> {
  Bloc _scanHandler;

  @override
  SScan get initialState => SScan();

  @override
  Stream<SScan> mapEventToState(Event event) async* {
    if (event is ECardScanError) {
      yield SCardScanError(event.error);
    } else if (event is ECardScanSuccess) {
      yield SCardScanSuccess(event.success);
    } else if (event is EScanCard) {
      _onScanCard(_scanHandler ?? this);
    }
  }

  scanCardWith(Bloc handler) {
    this._scanHandler = handler;
    add(EScanCard());
  }

  _onScanCard(Bloc bloc) {
    final callback = Callback((result) {
      bloc.add(ECardScanSuccess(result));
      _scanHandler = null;
    }, (error) {
      bloc.add(ECardScanError(error));
      _scanHandler = null;
    });
    TangemSdk.runCommand(callback, ScanModel());
  }
}

String parseCidFromSuccessScan(CardResponse card) {
  return card.cardId;
}
