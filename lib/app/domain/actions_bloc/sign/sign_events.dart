abstract class Event {
  const Event();
}

class CidChanged extends Event {
  final String cid;

  CidChanged(this.cid);
}

class DataChanged extends Event {
  final String dataForHashing;

  DataChanged(this.dataForHashing);
}
