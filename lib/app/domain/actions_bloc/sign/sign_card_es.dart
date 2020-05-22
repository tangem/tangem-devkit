import '../base_events.dart';
import '../base_state.dart';
import 'sign_state.dart';

class ECardSignSuccess extends ECardActionSuccess {
  ECardSignSuccess(Object success) : super(success);
}

class ECardSignError extends ECardActionError {
  ECardSignError(Object success) : super(success);
}

class SCardSignSuccess extends SSign with SCardActionSuccess {
  SCardSignSuccess(Object success, SSign state) : super(cid: state.cid, dataForHashing: state.dataForHashing) {
    this.success = success;
  }
}

class SCardSignError extends SSign with SCardActionError {
  SCardSignError(Object error, SSign state) : super(cid: state.cid, dataForHashing: state.dataForHashing) {
    this.error = error;
  }
}
