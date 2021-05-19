import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_setup_detail_bloc.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions.dart';

class TestSetupDetailScreen extends StatefulWidget {
  const TestSetupDetailScreen({Key? key}) : super(key: key);

  @override
  _TestSetupDetailScreenState createState() => _TestSetupDetailScreenState();
}

class _TestSetupDetailScreenState extends State<TestSetupDetailScreen> {
  late TestSetupDetailBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final screenData = ModalRoute.of(context)!.settings.arguments as JsonTestDetailScreenData;
    final storageRepo = context.read<ApplicationContext>().testStorageRepository;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TestSetupDetailBloc(storageRepo, screenData).apply((it) => _bloc = it),
        )
      ],
      child: TestSetupDetailFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class TestSetupDetailFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setup detail")),
      body: TestSetupDetailBody(),
    );
  }
}

class TestSetupDetailBody extends StatefulWidget {
  @override
  _TestSetupDetailBodyState createState() => _TestSetupDetailBodyState();
}

class _TestSetupDetailBodyState extends State<TestSetupDetailBody> {
  late TestSetupDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TestSetupDetailBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HiddenSnackBarHandlerWidget([_bloc]),
        SimpleFutureBuilder<String>(
          _bloc.readFile(),
          (context) => CenterLoadingText(),
          (context, data) => SingleChildScrollView(
            child: Text(data),
          ),
        ),
      ],
    );
  }
}
