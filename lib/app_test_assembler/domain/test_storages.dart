import 'package:devkit/app/domain/typed_storage.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';

class JsonTestsStorage extends FileStorage<JsonTest> {
  @override
  JsonTest convertFrom(Map<String, dynamic> json) => JsonTest.fromJson(json);
}

class TestSetupConfigStorage extends ConfigSharedPrefsStorage<TestSetup> {
  TestSetupConfigStorage() : super("testSetupConfigStorage");

  @override
  TestSetup getDefaultValue() => TestSetup.getDefault();

  @override
  TestSetup convertFrom(Map<String, dynamic> json) => TestSetup.fromJson(json);
}

class TestStepConfigStorage extends ConfigSharedPrefsStorage<TestStep> {
  TestStepConfigStorage() : super("testStepConfigStorage");

  @override
  TestStep getDefaultValue() => TestStep.getDefault();

  @override
  TestStep convertFrom(Map<String, dynamic> json) => TestStep.fromJson(json);
}
