// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonTest _$JsonTestFromJson(Map<String, dynamic> json) {
  return JsonTest(
    TestSetup.fromJson(json['setup'] as Map<String, dynamic>),
    (json['steps'] as List<dynamic>)
        .map<TestStep>((e) => TestStep.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$JsonTestToJson(JsonTest instance) => <String, dynamic>{
      'setup': instance.setup,
      'steps': instance.steps,
    };

TestSetup _$TestSetupFromJson(Map<String, dynamic> json) {
  return TestSetup(
    json['description'] as String,
    json['iterations'] as int?,
    FirmwareVersionNew.fromJson(
        json['minimalFirmware'] as Map<String, dynamic>),
    json['platform'] as String,
    CardConfigSdk.fromJson(json['cardConfig'] as Map<String, dynamic>),
    ConfigSdk.fromJson(json['config'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TestSetupToJson(TestSetup instance) => <String, dynamic>{
      'description': instance.description,
      'iterations': instance.iterations,
      'minimalFirmware': instance.minimalFirmware,
      'platform': instance.platform,
      'cardConfig': instance.cardConfig,
      'config': instance.config,
    };

ConfigSdk _$ConfigSdkFromJson(Map<String, dynamic> json) {
  return ConfigSdk();
}

Map<String, dynamic> _$ConfigSdkToJson(ConfigSdk instance) =>
    <String, dynamic>{};

TestStep _$TestStepFromJson(Map<String, dynamic> json) {
  return TestStep(
    json['name'] as String,
    json['iterations'] as int?,
    json['actionType'] as String,
    json['method'] as String,
    json['parameters'] as Map<String, dynamic>,
    json['expectedResult'] as Map<String, dynamic>,
    (json['asserts'] as List<dynamic>)
        .map((e) => TestAssert.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TestStepToJson(TestStep instance) => <String, dynamic>{
      'name': instance.name,
      'iterations': instance.iterations,
      'actionType': instance.actionType,
      'method': instance.method,
      'parameters': instance.parameters,
      'expectedResult': instance.expectedResult,
      'asserts': instance.asserts,
    };

TestAssert _$TestAssertFromJson(Map<String, dynamic> json) {
  return TestAssert(
    json['type'] as String,
    (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TestAssertToJson(TestAssert instance) =>
    <String, dynamic>{
      'type': instance.type,
      'fields': instance.fields,
    };
