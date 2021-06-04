import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/basic/semi_widget.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_step_list_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_step_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

class TestStepListScreen extends StatefulWidget {
  const TestStepListScreen({Key? key}) : super(key: key);

  @override
  _TestStepListScreenState createState() => _TestStepListScreenState();
}

class _TestStepListScreenState extends State<TestStepListScreen> {
  late TestStepListBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _createTestStepListBloc(context).apply((it) => _bloc = it)),
      ],
      child: TestStepListFrame(),
    );
  }

  TestStepListBloc _createTestStepListBloc(BuildContext context) {
    final screenData = ModalRoute.of(context)!.settings.arguments as JsonTestDetailScreenData;
    final bsTestName = StatedBehaviorSubject(screenData.testName);
    return TestStepListBloc(context.read<ApplicationContext>().storageRepo, bsTestName.stream);
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
  final bool attachSnackBarHandler;

  const TestStepListBody({Key? key, this.attachSnackBarHandler = true}) : super(key: key);

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
        widget.attachSnackBarHandler ? HiddenSnackBarHandlerWidget([_bloc]) : StubWidget(),
        StreamBuilder<JsonTest>(
          stream: _bloc.stepsListStream,
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data!.steps.isEmpty) {
              return CenterText("No test steps have been created yet");
            }

            final jsonTest = snapshot.data!;
            return ListView.separated(
              itemCount: jsonTest.steps.length,
              itemBuilder: (context, index) {
                final item = jsonTest.steps[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.method),
                  onTap: () => TestStepDetailScreen.navigate(
                    context,
                    TestStepDetailScreenData(jsonTest.setup.name, item.name),
                  ),
                  trailing: IconButton(icon: Icon(Icons.delete_outline), onPressed: () => _bloc.delete(index)),
                );
              },
              separatorBuilder: (BuildContext context, int index) => HorizontalDelimiter(),
            );
          },
        ),
      ],
    );
  }
}
