import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

part 'json_test_model.g.dart';

@JsonSerializable()
class JsonTest {
  final TestSetup setup;
  final List<StepModel> steps;

  JsonTest(this.setup, this.steps);

  factory JsonTest.fromJson(Map<String, dynamic> json) => _$JsonTestFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTestToJson(this);

  JsonTest copyWith({TestSetup? setup, List<StepModel>? steps}) => JsonTest(
        setup ?? this.setup,
        steps ?? this.steps,
      );
}

@JsonSerializable()
class TestSetup {
  final String name;
  final String description;
  final Map<String, dynamic> personalizationConfig;
  final Map<String, dynamic> sdkConfig;
  final FirmwareVersion? minimalFirmware;
  final String? platform;
  final int? iterations;
  final int creationDateMs;

  TestSetup(
    this.name,
    this.description,
    this.personalizationConfig,
    this.sdkConfig, [
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
      {},
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
    Map<String, dynamic>? sdkConfig,
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
class StepModel {
  final String name;
  final String method;
  final Map<String, dynamic> params;
  final Map<String, dynamic> expectedResult;
  final List<AssertModel> asserts;
  final String actionType;
  final int? iterations;

  Map<String, dynamic> _rawParams = {};

  Map<String, dynamic> get rawParams => {}..addAll(_rawParams);

  StepModel(
    this.name,
    this.method,
    this.params,
    this.expectedResult,
    this.asserts,
    this.actionType,
    this.iterations,
  ) {
    this._rawParams.addAll(params);
  }

  factory StepModel.getDefault() {
    return StepModel("stepName", "methodName", {}, {}, [], "NFC_SESSION_RUNNABLE", 1);
  }

  factory StepModel.empty(String name, String method) {
    return StepModel(name, method, {}, {}, [], "NFC_SESSION_RUNNABLE", 1);
  }

  factory StepModel.fromJson(Map<String, dynamic> json) => _$TestStepFromJson(json);

  Map<String, dynamic> toJson() => _$TestStepToJson(this);
}

@JsonSerializable()
class AssertModel {
  final String type;
  final List<String> fields;

  AssertModel(this.type, this.fields);

  factory AssertModel.fromJson(Map<String, dynamic> json) => _$TestAssertFromJson(json);

  Map<String, dynamic> toJson() => _$TestAssertToJson(this);
}
