import 'package:tangem_sdk/tangem_sdk.dart';

abstract class Event {
  const Event();
}

class ECardActionSuccess extends Event {
  final Object success;

  ECardActionSuccess(this.success);
}

class ECardActionError extends Event {
  final TangemSdkPluginError error;

  ECardActionError(this.error);
}
