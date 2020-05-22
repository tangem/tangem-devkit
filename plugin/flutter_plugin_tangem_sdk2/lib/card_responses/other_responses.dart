import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'other_responses.g.dart';

@JsonSerializable(nullable: false)
class ErrorResponse {
  int code;
  String localizedDescription;

  ErrorResponse({this.code, this.localizedDescription});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  ErrorResponse.fromException(PlatformException ex) {
    final jsonString = ex.details;
    final map = json.decode(jsonString);
    this.code = map['code'];
    this.localizedDescription = map['localizedDescription'];
  }
}

@JsonSerializable(nullable: false)
class SignResponse {
  String cardId;
  String signature;
  int walletRemainingSignatures;
  int walletSignedHashes;

  SignResponse({this.cardId, this.signature, this.walletRemainingSignatures, this.walletSignedHashes});

  factory SignResponse.fromJson(Map<String, dynamic> json) => _$SignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignResponseToJson(this);
}

@JsonSerializable(nullable: false)
class DepersonalizeResponse {
  bool success;

  DepersonalizeResponse({this.success});

  factory DepersonalizeResponse.fromJson(Map<String, dynamic> json) => _$DepersonalizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepersonalizeResponseToJson(this);
}
