abstract class Event {
  const Event();
}

class ECardSuccess extends Event {
  final Object success;

  ECardSuccess(this.success);
}

class ECardError extends Event {
  final Object error;

  ECardError(this.error);
}

class EReadCard extends Event {}

class EReadSuccess extends ECardSuccess {
  EReadSuccess(Object success) : super(success);
}

class EReadError extends ECardError {
  EReadError(Object error) : super(error);
}
