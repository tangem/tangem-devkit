import 'dart:convert';

import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions.dart';

class TestStepDetailScreen extends StatefulWidget {
  const TestStepDetailScreen({Key? key}) : super(key: key);

  @override
  _TestStepDetailScreenState createState() => _TestStepDetailScreenState();

  static navigate(BuildContext context, TestStepDetailScreenData screenData) {
    Navigator.pushNamed(context, Routes.TEST_STEP_DETAIL, arguments: screenData);
  }
}

class TestStepDetailScreenData {
  final String testName;
  final String stepName;

  TestStepDetailScreenData(this.testName, this.stepName);
}

class _TestStepDetailScreenState extends State<TestStepDetailScreen> {
  late TestStepDetailBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final screenData = ModalRoute.of(context)!.settings.arguments as TestStepDetailScreenData;
    final storageRepo = context.read<ApplicationContext>().testStorageRepository;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TestStepDetailBloc(storageRepo, screenData).apply((it) => _bloc = it),
        )
      ],
      child: TestStepDetailFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class TestStepDetailFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final testStepDetailBloc = context.read<TestStepDetailBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(testStepDetailBloc.screenData.stepName),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () => testStepDetailBloc.save())],
      ),
      body: TestStepDetailBody(),
    );
  }
}

class TestStepDetailBody extends StatefulWidget {
  @override
  _TestStepDetailBodyState createState() => _TestStepDetailBodyState();
}

class _TestStepDetailBodyState extends State<TestStepDetailBody> {
  late TestStepDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TestStepDetailBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final stepContent = _bloc.readStep();
    if (stepContent == null) return CenterText("Error. Step no found");
    return Stack(
      children: [
        HiddenSnackBarHandlerWidget([_bloc]),
        SingleChildScrollView(
          child: Text(stepContent),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TestStepDetailBloc extends BaseBloc {
  final TestStorageRepository _storageRepo;
  final TestStepDetailScreenData screenData;

  TestStepDetailBloc(this._storageRepo, this.screenData);

  String? readStep() {
    final jsonTest = _storageRepo.testsStorage.get(screenData.testName);
    if (jsonTest == null || jsonTest.steps.isEmpty) return null;

    final step = jsonTest.steps.firstWhereOrNull((e) => e.name == screenData.stepName);
    if (step == null) return null;

    final encoder = JsonEncoder.withIndent("  ");
    return encoder.convert(step);
  }

  save() {
    sendSnackbarMessage("Not implemented yet");
  }

  @override
  dispose() {}
}
