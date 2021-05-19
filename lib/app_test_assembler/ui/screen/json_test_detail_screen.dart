import 'package:devkit/app_test_assembler/domain/bloc/test_setup_detail_bloc.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_setup_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_step_list_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions.dart';

class JsonTestDetailScreen extends StatefulWidget {
  @override
  _JsonTestDetailScreenState createState() => _JsonTestDetailScreenState();

  static navigate(BuildContext context, JsonTestDetailScreenData data) {
    Navigator.pushNamed(context, Routes.JSON_TEST_DETAIL, arguments: data);
  }
}

class JsonTestDetailScreenData {
  final String testName;
  final int index;

  JsonTestDetailScreenData(this.testName, this.index);
}

class _JsonTestDetailScreenState extends State<JsonTestDetailScreen> {
  late TestSetupDetailBloc _setupBloc;
  TestStepListBloc? _stepListBloc;

  @override
  Widget build(BuildContext context) {
    final screenData = ModalRoute.of(context)!.settings.arguments as JsonTestDetailScreenData;
    final storageRepo = context.read<ApplicationContext>().testStorageRepository;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TestSetupDetailBloc(storageRepo, screenData).apply((it) => _setupBloc = it),
        ),
        RepositoryProvider(
          create: (context) => TestStepListBloc(storageRepo, screenData).apply((it) => _stepListBloc = it),
        )
      ],
      child: JsonTestDetailFrame(),
    );
  }

  @override
  void dispose() {
    _setupBloc.dispose();
    _stepListBloc?.dispose();
    super.dispose();
  }
}

class JsonTestDetailFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setupDetailBloc = context.read<TestSetupDetailBloc>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(setupDetailBloc.screenData.testName),
          actions: [
            IconButton(icon: Icon(Icons.save), onPressed: () => setupDetailBloc.save()),
          ],
          bottom: TabBar(
            tabs: [
              TabTextIconWidget(Icon(Icons.settings), Text("Setup")),
              TabTextIconWidget(Icon(Icons.list_alt), Text("Steps")),
            ],
          ),
        ),
        body: JsonTestDetailBody(),
      ),
    );
  }
}

class JsonTestDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        TestSetupDetailBody(),
        TestStepListBody(),
      ],
    );
  }
}
