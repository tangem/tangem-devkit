import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/model/sdk.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

part 'model.g.dart';

// Used to convert data from the TangemSdkPlugin.SessionViewDelegate

@JsonSerializable()
class OnDelay {
  final int total;
  final int current;
  final int step;

  OnDelay(this.total, this.current, this.step);

  factory OnDelay.fromJson(Map<String, dynamic> json) => _$OnDelayFromJson(json);

  Map<String, dynamic> toJson() => _$OnDelayToJson(this);
}

@JsonSerializable()
class OnPinRequested {
  final PinType pinType;
  final bool isFirstAttempt;

  OnPinRequested(this.pinType, this.isFirstAttempt);

  factory OnPinRequested.fromJson(Map<String, dynamic> json) => _$OnPinRequestedFromJson(json);

  Map<String, dynamic> toJson() => _$OnPinRequestedToJson(this);
}

@JsonSerializable()
class OnSecurityDelay {
  final int ms;
  final int totalDurationSeconds;

  OnSecurityDelay(this.ms, this.totalDurationSeconds);

  factory OnSecurityDelay.fromJson(Map<String, dynamic> json) => _$OnSecurityDelayFromJson(json);

  Map<String, dynamic> toJson() => _$OnSecurityDelayToJson(this);
}

@JsonSerializable()
class OnSessionStarted {
  final String cardId;
  final Message message;
  final bool enableHowTo;

  OnSessionStarted(this.cardId, this.message, this.enableHowTo);

  factory OnSessionStarted.fromJson(Map<String, dynamic> json) => _$OnSessionStartedFromJson(json);

  Map<String, dynamic> toJson() => _$OnSessionStartedToJson(this);
}

enum WrongValueType { CardId, CardType }
