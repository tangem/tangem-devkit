import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/card_responses/card_response_new.dart';
import 'package:tangem_sdk/model/sdk.dart';

part 'json_test_model.g.dart';

@JsonSerializable()
class JsonTest {
  final TestSetup setup;
  final List<TestStep> steps;

  JsonTest(this.setup, this.steps);

  factory JsonTest.fromJson(Map<String, dynamic> json) => _$JsonTestFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTestToJson(this);
}

@JsonSerializable()
class TestSetup {
  final String description;
  final int? iterations;
  final FirmwareVersionNew minimalFirmware;
  final String platform;
  final CardConfigSdk cardConfig;
  final ConfigSdk config;

  TestSetup(this.description, this.iterations, this.minimalFirmware, this.platform, this.cardConfig, this.config);

  factory TestSetup.fromJson(Map<String, dynamic> json) => _$TestSetupFromJson(json);

  Map<String, dynamic> toJson() => _$TestSetupToJson(this);
}

@JsonSerializable()
class ConfigSdk {
  ConfigSdk();

  factory ConfigSdk.fromJson(Map<String, dynamic> json) => ConfigSdk();

  Map<String, dynamic> toJson() => {};
}

@JsonSerializable()
class TestStep {
  final String name;
  final int? iterations;
  final String actionType;
  final String method;
  final Map<String, dynamic> parameters;
  final Map<String, dynamic> expectedResult;
  final List<TestAssert> asserts;

  TestStep(
    this.name,
    this.iterations,
    this.actionType,
    this.method,
    this.parameters,
    this.expectedResult,
    this.asserts,
  );

  factory TestStep.fromJson(Map<String, dynamic> json) => _$TestStepFromJson(json);

  Map<String, dynamic> toJson() => _$TestStepToJson(this);
}

@JsonSerializable()
class TestAssert {
  final String type;
  final List<String> fields;

  TestAssert(this.type, this.fields);

  factory TestAssert.fromJson(Map<String, dynamic> json) => _$TestAssertFromJson(json);

  Map<String, dynamic> toJson() => _$TestAssertToJson(this);
}