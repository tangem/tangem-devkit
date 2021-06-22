import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/executable/assert/assert.dart';
import 'package:devkit/app_test_launcher/domain/repository/repositories.dart';
import 'package:devkit/app_test_launcher/domain/test_launcher.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

class JsonTestLauncherScreen extends StatefulWidget {
  const JsonTestLauncherScreen({Key? key}) : super(key: key);

  @override
  _JsonTestLauncherScreenState createState() => _JsonTestLauncherScreenState();
}

class _JsonTestLauncherScreenState extends State<JsonTestLauncherScreen> {
  late JsonTestLauncherBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => JsonTestLauncherBloc().apply((it) => _bloc = it)),
      ],
      child: JsonTestLauncherFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class JsonTestLauncherFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tests")),
      body: JsonTestLauncherBody(),
    );
  }
}

class JsonTestLauncherBody extends StatefulWidget {
  final bool attachSnackBarHandler;

  const JsonTestLauncherBody({Key? key, this.attachSnackBarHandler = true}) : super(key: key);

  @override
  _JsonTestLauncherBodyState createState() => _JsonTestLauncherBodyState();
}

class _JsonTestLauncherBodyState extends State<JsonTestLauncherBody> {
  late JsonTestLauncherBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<JsonTestLauncherBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HiddenSnackBarHandlerWidget([_bloc]),
        StubStreamBuilder<List<JsonTest>>(
          _bloc.bsJsonTests.stream,
          (context, data) {
            return ListView.separated(
              itemCount: _bloc.repo.getList().length,
              separatorBuilder: (context, index) => HorizontalDelimiter(),
              itemBuilder: (context, index) {
                final jsonTest = data[index];
                return ListTile(
                  title: Text(jsonTest.setup.name),
                  subtitle: Text(jsonTest.setup.description),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      _bloc.launch(jsonTest);
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class JsonTestLauncherBloc extends BaseBloc {
  final JsonTestRepository repo = JsonTestRepository();
  final bsJsonTests = BehaviorSubject<List<JsonTest>>();

  JsonTestLauncherBloc() {
    addSubject(bsJsonTests);
    initRepository();
  }

  void initRepository() async {
    await repo.init();
    bsJsonTests.add(repo.getList());
  }

  void launch(JsonTest jsonTest) {
    final launcher = TestLauncher(jsonTest, AssertsFactory());
    launcher.onTestComplete = (result) {
      if (result is Success) {
        final message = result.name ?? "Unknown test";
        sendSnackbarMessage("$message is completed");
      } else {
        sendSnackbarMessage(result);
      }
    };
    launcher.launch();
  }

  void _handleError(dynamic error) {
    sendSnackbarMessage(error);
  }
}
