import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/domain/test_storages.dart';
import 'package:devkit/app_test_launcher/domain/common/test_result.dart';
import 'package:devkit/app_test_launcher/domain/common/typedefs.dart';
import 'package:devkit/app_test_launcher/domain/error/error.dart';
import 'package:devkit/app_test_launcher/domain/error/test_error.dart';
import 'package:devkit/app_test_launcher/domain/executable/assert/assert.dart';
import 'package:devkit/app_test_launcher/domain/executable/step/step_launcher.dart';
import 'package:devkit/app_test_launcher/domain/variable_service.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

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
    _startSession(() async {
      final launcher = TestLauncher(jsonTest, AssertsFactory());
      launcher.onTestComplete = (result) {
        if (result is Success) {
          final message = result.name ?? "Unknown test";
          sendSnackbarMessage("$message is completed");
        } else {
          sendSnackbarMessage(result);
        }
        _stopSession(() {}, _handleError);
      };
      launcher.launch();
    }, _handleError);
  }

  void _startSession(Function onSuccess, Function(dynamic error) onError) {
    TangemSdk.startSession(Callback((success) => onSuccess(), onError), {
      TangemSdk.initialMessage: {
        TangemSdk.initialMessageHeader: "Session is started",
        TangemSdk.initialMessageBody: "COME ON !!!"
      }
    });
  }

  void _stopSession(Function onSuccess, Function(dynamic error) onError) {
    TangemSdk.stopSession(Callback((success) => onSuccess(), _handleError));
  }

  void _handleError(dynamic error) {
    sendSnackbarMessage(error);
  }
}

class TestLauncher {
  final JsonTest _jsonTest;
  final AssertsFactory _assertsFactory;

  OnComplete? onTestComplete;

  Queue _testQueue = Queue<JsonTest>();
  Queue _stepQueue = Queue<StepModel>();

  TestLauncher(this._jsonTest, this._assertsFactory);

  void launch() {
    _testQueue = _generateTestQueue();

    final nextTest = _testQueue.poll();
    if (nextTest == null) {
      onTestComplete?.call(Failure(TestIsEmptyError()));
    } else {
      _runTest(nextTest);
    }
  }

  void _runTest(JsonTest test) {
    VariableService.reset();
    _prepare().then((value) {
      _stepQueue = Queue.from(test.steps);
      final nextStep = _stepQueue.poll();
      if (nextStep == null) {
        _onStepSequenceComplete(Success(test.setup.name));
      } else {
        _runStep(nextStep);
      }
    }).onError((error, stackTrace) {
      _handleError(error);
    });
  }

  void _onStepComplete(TestResult result) {
    if (result is Success) {
      final nextStep = _stepQueue.poll();
      if (nextStep == null) {
        _onStepSequenceComplete(result);
      } else {
        _runStep(nextStep);
      }
    } else {
      _onStepSequenceComplete(result);
    }
  }

  void _runStep(StepModel step) {
    StepLauncher(step, _assertsFactory).run(_onStepComplete);
  }

  void _onStepSequenceComplete(TestResult result) {
    if (result is Success) {
      final nextTest = _testQueue.poll();
      if (nextTest == null) {
        onTestComplete?.call(Success(_jsonTest.setup.name));
      } else {
        _runTest(nextTest);
      }
    } else {
      _handleError(result);
    }
  }

  void _handleError(dynamic error) {
    onTestComplete?.call(Failure(CustomError(jsonEncode(error))));
  }

  Queue<JsonTest> _generateTestQueue() {
    final tests = [];
    if (_jsonTest.setup.iterations == null) {
      tests.add(_jsonTest);
    } else {
      _jsonTest.setup.iterations?.foreach((e) => tests.add(_jsonTest));
    }
    return Queue.from(tests);
  }

  Future _prepare() {
    final completer = Completer();
    _configureSdk(() {
      _rePersonalize(() {
        completer.complete();
      }, _handleError);
    }, _handleError);
    return completer.future;
  }

  void _configureSdk(Function onSuccess, Function(dynamic error) onError) {
    onSuccess();
  }

  void _rePersonalize(Function onSuccess, Function(dynamic error) onError) {
    onSuccess();
  }
}

abstract class JsonTestsRepository {
  Future init();

  List<JsonTest> getList();

  JsonTest? get(String name);
}

class JsonTestRepository implements JsonTestsRepository {
  final JsonTestsStorage storage = JsonTestsStorage();

  @override
  Future init() {
    final completer = Completer();
    storage.isReadyToUseStream.listen((event) {
      if (event) completer.complete();
    });
    return completer.future;
  }

  @override
  JsonTest? get(String name) {
    return storage.get(name);
  }

  @override
  List<JsonTest> getList() {
    return storage.names().map((e) => storage.get(e)).toList().toNullSafe();
  }
}
