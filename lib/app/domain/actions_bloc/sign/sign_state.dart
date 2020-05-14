class SignState {
  final String cid;
  final bool isCidValid;
  final String dataForHashing;
  final bool isDataValid;

  SignState({
    this.cid,
    this.isCidValid,
    this.dataForHashing,
    this.isDataValid,
  });

  factory SignState.initial() => SignState(
        cid: "",
        isCidValid: false,
        dataForHashing: "Data used for hashing",
        isDataValid: true,
      );

  SignState copyWith({
    String cid,
    bool cidIsValid,
    String dataForHashing,
    bool dataForHashingIsValid,
  }) {
    return SignState(
      cid: cid ?? this.cid,
      isCidValid: cidIsValid ?? this.isCidValid,
      dataForHashing: dataForHashing ?? this.dataForHashing,
      isDataValid: dataForHashingIsValid ?? this.isDataValid,
    );
  }
}
