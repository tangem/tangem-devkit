import 'package:tangem_sdk/card_responses/other_responses.dart';

abstract class Event {
  const Event();
}

class ECardActionSuccess extends Event {
  final Object success;

  ECardActionSuccess(this.success);
}

class ECardActionError extends Event {
  final ErrorResponse error;

  ECardActionError(this.error);
}
