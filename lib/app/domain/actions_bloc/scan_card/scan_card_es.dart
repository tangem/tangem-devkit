import '../base_events.dart';
import '../base_state.dart';

class EScanCard extends Event {}

class ECardScanSuccess extends ECardActionSuccess {
  ECardScanSuccess(Object success) : super(success);
}

class ECardScanError extends ECardActionError {
  ECardScanError(Object error) : super(error);
}

class SScan extends SState {}

class SCardScanSuccess extends SScan with SCardActionSuccess {
  SCardScanSuccess(Object success) {
    this.success = success;
  }
}

class SCardScanError extends SScan with SCardActionError {
  SCardScanError(Object error) {
    this.error = error;
  }
}
