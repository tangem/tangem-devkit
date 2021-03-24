// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnDelay _$OnDelayFromJson(Map<String, dynamic> json) {
  return OnDelay(
    json['total'] as int,
    json['current'] as int,
    json['step'] as int,
  );
}

Map<String, dynamic> _$OnDelayToJson(OnDelay instance) => <String, dynamic>{
      'total': instance.total,
      'current': instance.current,
      'step': instance.step,
    };

OnPinRequested _$OnPinRequestedFromJson(Map<String, dynamic> json) {
  return OnPinRequested(
    enumDecodeNullable(_$PinTypeEnumMap, json['pinType']),
    json['isFirstAttempt'] as bool,
  );
}

Map<String, dynamic> _$OnPinRequestedToJson(OnPinRequested instance) => <String, dynamic>{
      'pinType': _$PinTypeEnumMap[instance.pinType],
      'isFirstAttempt': instance.isFirstAttempt,
    };

const _$PinTypeEnumMap = {
  PinType.PIN1: 'PIN1',
  PinType.PIN2: 'PIN2',
  PinType.PIN3: 'PIN3',
};

OnSecurityDelay _$OnSecurityDelayFromJson(Map<String, dynamic> json) {
  return OnSecurityDelay(
    json['ms'] as int,
    json['totalDurationSeconds'] as int,
  );
}

Map<String, dynamic> _$OnSecurityDelayToJson(OnSecurityDelay instance) => <String, dynamic>{
      'ms': instance.ms,
      'totalDurationSeconds': instance.totalDurationSeconds,
    };

OnSessionStarted _$OnSessionStartedFromJson(Map<String, dynamic> json) {
  return OnSessionStarted(
    json['cardId'] as String,
    json['message'] == null ? null : Message.fromJson(json['message'] as Map<String, dynamic>),
    json['enableHowTo'] as bool,
  );
}

Map<String, dynamic> _$OnSessionStartedToJson(OnSessionStarted instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'message': instance.message,
      'enableHowTo': instance.enableHowTo,
    };
