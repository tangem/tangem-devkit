import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/basic/semi_widget.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_setup_detail_bloc.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_step_list_bloc.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_setup_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_step_list_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JsonTestDetailScreen extends StatefulWidget {
  @override
  _JsonTestDetailScreenState createState() => _JsonTestDetailScreenState();

  static navigate(BuildContext context, JsonTestDetailScreenData data) {
    Navigator.pushNamed(context, Routes.JSON_TEST_DETAIL, arguments: data);
  }
}

class JsonTestDetailScreenData {
  final String testName;

  JsonTestDetailScreenData(this.testName);
}

class _JsonTestDetailScreenState extends State<JsonTestDetailScreen> {
  late TestSetupDetailBloc _setupBloc;
  TestStepListBloc? _stepListBloc;

  @override
  Widget build(BuildContext context) {
    final screenData = ModalRoute.of(context)!.settings.arguments as JsonTestDetailScreenData;
    final storageRepo = context.read<ApplicationContext>().storageRepo;
    _setupBloc = TestSetupDetailBloc(storageRepo, screenData);
    _stepListBloc = TestStepListBloc(storageRepo, _setupBloc.jsonTestNameStream);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _setupBloc),
        RepositoryProvider(create: (context) => _stepListBloc)
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

class JsonTestDetailFrame extends StatefulWidget {
  const JsonTestDetailFrame({Key? key}) : super(key: key);

  @override
  _JsonTestDetailFrameState createState() => _JsonTestDetailFrameState();
}

class _JsonTestDetailFrameState extends State<JsonTestDetailFrame> with SingleTickerProviderStateMixin {
  final int _tabLength = 2;
  late final TabController _tabController;
  bool _showSaveMenuItem = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLength, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final setupDetailBloc = context.read<TestSetupDetailBloc>();
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
        appBar: AppBar(
          title: Text(setupDetailBloc.screenData.testName),
          actions: [
            _showSaveMenuItem
                ? StateRecordingWidget(
                    inactive: IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () => setupDetailBloc.save(),
                    ),
                  )
                : StubWidget(),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              TabTextIconWidget(Icon(Icons.settings), Text("Setup")),
              TabTextIconWidget(Icon(Icons.list_alt), Text("Steps")),
            ],
          ),
        ),
        body: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification) _onTabChanged();
            return false;
          },
          child: Stack(
            children: [
              HiddenSnackBarHandlerWidget([context.read<TestSetupDetailBloc>(), context.read<TestStepListBloc>()]),
              TabBarView(
                controller: _tabController,
                children: [
                  TestSetupDetailBody(attachSnackBarHandler: false),
                  TestStepListBody(attachSnackBarHandler: false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTabChanged() {
    setState(() => _showSaveMenuItem = _tabController.index == 0);
  }
}
