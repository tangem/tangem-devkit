import '../base_events.dart';

class EInitSign extends Event {}

class ECidChanged extends Event {
  final String cid;

  ECidChanged(this.cid);
}

class EDataChanged extends Event {
  final String dataForHashing;

  EDataChanged(this.dataForHashing);
}

class ESign extends Event {}

class ESignSuccess extends ECardSuccess {
  ESignSuccess(Object success) : super(success);
}

class ESignError extends ECardError {
  ESignError(Object success) : super(success);
}
