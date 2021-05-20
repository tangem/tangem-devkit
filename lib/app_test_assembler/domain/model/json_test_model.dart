import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

part 'json_test_model.g.dart';

@JsonSerializable()
class JsonTest {
  final TestSetup setup;
  final List<TestStep> steps;

  JsonTest(this.setup, this.steps);

  factory JsonTest.fromJson(Map<String, dynamic> json) => _$JsonTestFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTestToJson(this);

  JsonTest copyWith({TestSetup? setup, List<TestStep>? steps}) => JsonTest(
      setup ?? this.setup,
      steps ?? this.steps,
    );
}

@JsonSerializable()
class TestSetup {
  final String name;
  final String description;
  final Map<String, dynamic> personalizationConfig;
  final ConfigSdk? sdkConfig;
  final FirmwareVersion? minimalFirmware;
  final String? platform;
  final int? iterations;
  final int creationDateMs;

  TestSetup(
    this.name,
    this.description,
    this.personalizationConfig, [
    this.sdkConfig,
    this.minimalFirmware,
    this.platform,
    this.iterations,
    int? creationDateMs,
  ]) : this.creationDateMs = creationDateMs ?? DateTime.now().millisecondsSinceEpoch;

  factory TestSetup.getDefault() {
    final persConfig = PersonalizationConfigStorage().getCurrent();
    final persCommandConfig = Utils.createPersonalizationCommandConfig(persConfig);
    return TestSetup(
      "Simple test",
      "It shows what we can do with a card",
      persCommandConfig,
      null,
      null,
      null,
      1,
    );
  }

  factory TestSetup.fromJson(Map<String, dynamic> json) => _$TestSetupFromJson(json);

  Map<String, dynamic> toJson() => _$TestSetupToJson(this);

  TestSetup copyWith({
    String? name,
    String? description,
    Map<String, dynamic>? personalizationConfig,
    ConfigSdk? sdkConfig,
    FirmwareVersion? minimalFirmware,
    String? platform,
    int? iterations,
  }) =>
      TestSetup(
        name ?? this.name,
        description ?? this.description,
        personalizationConfig ?? this.personalizationConfig,
        sdkConfig ?? this.sdkConfig,
        minimalFirmware ?? this.minimalFirmware,
        platform ?? this.platform,
        iterations ?? this.iterations,
      );
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
  final String method;
  final Map<String, dynamic> parameters;
  final Map<String, dynamic> expectedResult;
  final List<TestAssert> asserts;
  final String actionType;
  final int? iterations;

  TestStep(
    this.name,
    this.method,
    this.parameters,
    this.expectedResult,
    this.asserts,
    this.actionType,
    this.iterations,
  );

  factory TestStep.getDefault() {
    return TestStep("stepName", "methodName", {}, {}, [], "NFC_SESSION_RUNNABLE", 1);
  }

  factory TestStep.empty(String name, String method) {
    return TestStep(name, method, {}, {}, [], "NFC_SESSION_RUNNABLE", 1);
  }

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
