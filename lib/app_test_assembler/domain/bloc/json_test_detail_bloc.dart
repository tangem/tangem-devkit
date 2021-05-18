import 'dart:convert';

import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/commons/common_abstracts.dart';

class JsonTestDetailBloc extends DisposableBloc {
  final String testName;
  final TestStorageRepository _storageRepository;

  JsonTestDetailBloc(this._storageRepository, this.testName);

  Future<String> readFile() async {
    final jsonTest = _storageRepository.testsStorage.get(testName);
    final encoder = JsonEncoder.withIndent("  ");
    return Future.value(encoder.convert(jsonTest));
  }

  @override
  dispose() {}
}
