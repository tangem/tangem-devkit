abstract class Event {
  const Event();
}

class ECardActionSuccess extends Event {
  final Object success;

  ECardActionSuccess(this.success);
}

class ECardActionError extends Event {
  final Object error;

  ECardActionError(this.error);
}