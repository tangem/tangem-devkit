// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonTest _$JsonTestFromJson(Map<String, dynamic> json) {
  return JsonTest(
    TestSetup.fromJson(json['setup'] as Map<String, dynamic>),
    (json['steps'] as List<dynamic>).map((e) => StepModel.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

Map<String, dynamic> _$JsonTestToJson(JsonTest instance) => <String, dynamic>{
      'setup': instance.setup,
      'steps': instance.steps,
    };

TestSetup _$TestSetupFromJson(Map<String, dynamic> json) {
  return TestSetup(
    json['name'] as String,
    json['description'] as String,
    json['personalizationConfig'] as Map<String, dynamic>,
    json['sdkConfig'] == null ? null : ConfigSdk.fromJson(json['sdkConfig'] as Map<String, dynamic>),
    json['minimalFirmware'] == null ? null : FirmwareVersion.fromJson(json['minimalFirmware'] as String),
    json['platform'] as String?,
    json['iterations'] as int?,
    json['creationDateMs'] as int?,
  );
}

Map<String, dynamic> _$TestSetupToJson(TestSetup instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'personalizationConfig': instance.personalizationConfig,
      'sdkConfig': instance.sdkConfig,
      'minimalFirmware': instance.minimalFirmware,
      'platform': instance.platform,
      'iterations': instance.iterations,
      'creationDateMs': instance.creationDateMs,
    };

ConfigSdk _$ConfigSdkFromJson(Map<String, dynamic> json) {
  return ConfigSdk();
}

Map<String, dynamic> _$ConfigSdkToJson(ConfigSdk instance) => <String, dynamic>{};

StepModel _$TestStepFromJson(Map<String, dynamic> json) {
  return StepModel(
    json['name'] as String,
    json['method'] as String,
    json['parameters'] as Map<String, dynamic>,
    json['expectedResult'] as Map<String, dynamic>,
    (json['asserts'] as List<dynamic>).map((e) => TestAssert.fromJson(e as Map<String, dynamic>)).toList(),
    json['actionType'] as String,
    json['iterations'] as int?,
  );
}

Map<String, dynamic> _$TestStepToJson(StepModel instance) => <String, dynamic>{
      'name': instance.name,
      'method': instance.method,
      'parameters': instance.params,
      'expectedResult': instance.expectedResult,
      'asserts': instance.asserts,
      'actionType': instance.actionType,
      'iterations': instance.iterations,
    };

TestAssert _$TestAssertFromJson(Map<String, dynamic> json) {
  return TestAssert(
    json['type'] as String,
    (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TestAssertToJson(TestAssert instance) => <String, dynamic>{
      'type': instance.type,
      'fields': instance.fields,
    };
