import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/basic/semi_widget.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_step_detail_screen.dart';
import 'package:devkit/application.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions.dart';

class TestStepListScreen extends StatefulWidget {
  const TestStepListScreen({Key? key}) : super(key: key);

  @override
  _TestStepListScreenState createState() => _TestStepListScreenState();
}

class _TestStepListScreenState extends State<TestStepListScreen> {
  late TestStepListBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final screenData = ModalRoute.of(context)!.settings.arguments as JsonTestDetailScreenData;
    final storageRepo = context.read<ApplicationContext>().testStorageRepository;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TestStepListBloc(storageRepo, screenData).apply((it) => _bloc = it))
      ],
      child: TestStepListFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class TestStepListFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Step list")),
      body: TestStepListBody(),
    );
  }
}

class TestStepListBody extends StatefulWidget {
  const TestStepListBody({Key? key}) : super(key: key);

  @override
  _TestStepListBodyState createState() => _TestStepListBodyState();
}

class _TestStepListBodyState extends State<TestStepListBody> {
  late TestStepListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TestStepListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HiddenSnackBarHandlerWidget([_bloc]),
        ListView.separated(
          separatorBuilder: (BuildContext context, int index) => HorizontalDelimiter(),
          itemCount: _bloc.stepsList.length,
          itemBuilder: (context, index) {
            final item = _bloc.stepsList[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.method),
              onTap: () => TestStepDetailScreen.navigate(
                context,
                TestStepDetailScreenData(_bloc.screenData.testName, item.name),
              ),
            );
          },
        ),
      ],
    );
  }
}

class TestStepListBloc extends BaseBloc {
  final TestStorageRepository _storageRepo;
  final JsonTestDetailScreenData screenData;
  final List<TestStep> stepsList;

  TestStepListBloc(this._storageRepo, this.screenData)
      : this.stepsList = _storageRepo.testsStorage.get(screenData.testName)?.steps ?? [];

  List<TestStep> getSteps() {
    return stepsList;
  }

  @override
  dispose() {}
}
