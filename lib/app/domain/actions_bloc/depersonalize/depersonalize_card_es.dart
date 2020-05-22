import '../base_events.dart';
import '../base_state.dart';

class EDepersonalize extends Event {}

class ECardDepersonalizeSuccess extends ECardActionSuccess {
  ECardDepersonalizeSuccess(Object success) : super(success);
}

class ECardDepersonalizeError extends ECardActionError {
  ECardDepersonalizeError(Object error) : super(error);
}

class SDepersonalize extends SState {}

class SCardDepersonalizeSuccess extends SDepersonalize with SCardActionSuccess {
  SCardDepersonalizeSuccess(Object success) {
    this.success = success;
  }
}

class SCardDepersonalizeError extends SDepersonalize with SCardActionError {
  SCardDepersonalizeError(Object error) {
    this.error = error;
  }
}
