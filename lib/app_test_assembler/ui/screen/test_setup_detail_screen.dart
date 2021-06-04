import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_setup_detail_bloc.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/commons/extensions/widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

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
    final storageRepo = context.read<ApplicationContext>().storageRepo;
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
  final bool attachSnackBarHandler;

  const TestSetupDetailBody({Key? key, this.attachSnackBarHandler = true}) : super(key: key);

  @override
  _TestSetupDetailBodyState createState() => _TestSetupDetailBodyState();
}

class _TestSetupDetailBodyState extends State<TestSetupDetailBody> {
  late TestSetupDetailBloc _bloc;
  late TextStreamController _nameController;
  late TextStreamController _descriptionController;
  late TextStreamController _iterationCountController;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TestSetupDetailBloc>();
    _nameController = TextStreamController(_bloc.bsName);
    _descriptionController = TextStreamController(_bloc.bsDescription);
    _iterationCountController = TextStreamController(_bloc.bsIterationCount, [RegExp(r'\d+')]);
  }

  @override
  Widget build(BuildContext context) {
    return StateRecordingWidget(
      active: _immutableSetup(context),
      inactive: _mutableSetup(context),
    );
  }

  ListView _mutableSetup(BuildContext context) {
    final transl = Transl.of(context);
    return ListView(
      children: <Widget>[
        widget.attachSnackBarHandler ? HiddenSnackBarHandlerWidget([_bloc]) : StubWidget(),
        SizedBox(height: 16),
        TestInputWidget(
          _nameController.controller,
          hint: transl.get("Name"),
        ),
        TestInputWidget(
          _descriptionController.controller,
          hint: transl.get("Description"),
        ),
        TestInputWidget(
          _iterationCountController.controller,
          hint: transl.get("Iterations"),
          inputType: TextInputType.number,
        ),
        StubWidget().withUnderline(),
        StreamBuilder<String>(
          stream: _bloc.setupJsonValueStream,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return StubWidget();
            else
              return Text(snapshot.data!);
          },
        ),
      ],
    );
  }

  ListView _immutableSetup(BuildContext context) {
    return ListView(
      children: <Widget>[
        StreamBuilder<String>(
          stream: _bloc.setupJsonValueStream,
          builder: (context, snapshot) => snapshot.data == null ? StubWidget() : Text(snapshot.data!),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _iterationCountController.dispose();
    super.dispose();
  }
}
