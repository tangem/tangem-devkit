import '../base_events.dart';

class ESign extends Event {}

class EInitSign extends Event {}

class ECidChanged extends Event {
  final String cid;

  ECidChanged(this.cid);
}

class EDataChanged extends Event {
  final String dataForHashing;

  EDataChanged(this.dataForHashing);
}