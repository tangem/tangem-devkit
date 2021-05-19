import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/commons/common_abstracts.dart';

class TestSetupDetailBloc extends BaseBloc {
  final TestStorageRepository _storageRepository;
  final JsonTestDetailScreenData screenData;

  TestSetupDetailBloc(this._storageRepository, this.screenData);

  Future<String> readFile() async {
    final setup = _storageRepository.testsStorage.get(screenData.testName)?.setup;
    final encoder = JsonEncoder.withIndent("  ");
    return Future.value(encoder.convert(setup));
  }

  @override
  dispose() {}

  void save() {
    sendSnackbarMessage("Not implemented yet");
  }
}
