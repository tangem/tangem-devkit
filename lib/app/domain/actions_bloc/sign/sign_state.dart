import '../base_state.dart';

class SSign extends SState {
  final String cid;
  final String dataForHashing;
  final bool theseFromBloc;

  SSign({this.cid, this.dataForHashing, this.theseFromBloc = false});
  
  factory SSign.initial() => SSign(cid: "", dataForHashing: "");
  factory SSign.def() => SSign(cid: "", dataForHashing: "Data used for hashing", theseFromBloc: true);

  SSign copyWith({String cid, String dataForHashing, bool theseFromBloc}) {
    return SSign(
      cid: cid ?? this.cid,
      dataForHashing: dataForHashing ?? this.dataForHashing,
      theseFromBloc: theseFromBloc ?? false,
    );
  }
}