import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app_test_assembler/domain/bloc/json_test_assembler_bloc.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

class JsonTestAssemblerScreen extends StatefulWidget {
  const JsonTestAssemblerScreen({Key? key}) : super(key: key);

  @override
  _JsonTestAssemblerScreenState createState() => _JsonTestAssemblerScreenState();
}

class _JsonTestAssemblerScreenState extends State<JsonTestAssemblerScreen> {
  late JsonTestAssemblerBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final storageRepo = context.read<ApplicationContext>().storageRepo;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => JsonTestAssemblerBloc(storageRepo).apply((it) => _bloc = it))
      ],
      child: JsonTestAssemblerFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class JsonTestAssemblerFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test assembler"),
        actions: [StartStopRecordWidget()],
      ),
      body: JsonTestAssemblerBody(),
    );
  }
}

class JsonTestAssemblerBody extends StatefulWidget {
  @override
  _JsonTestAssemblerBodyState createState() => _JsonTestAssemblerBodyState();
}

class _JsonTestAssemblerBodyState extends State<JsonTestAssemblerBody> {
  late JsonTestAssemblerBloc _jsonTestAssemblerBloc;
  late TestRecorderBlock _testRecorderBlock;

  @override
  void initState() {
    super.initState();

    _jsonTestAssemblerBloc = context.read<JsonTestAssemblerBloc>();
    _testRecorderBlock = context.read<ApplicationContext>().testRecorderBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HiddenSnackBarHandlerWidget([_jsonTestAssemblerBloc, _testRecorderBlock]),
        StreamBuilder<List<JsonTest>>(
          stream: _jsonTestAssemblerBloc.bsRecords.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) return CenterLoadingText();
            if (snapshot.data!.isEmpty) return CenterText("No tests have been created yet");

            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.setup.name),
                  subtitle: Text(item.setup.description),
                  onTap: () => JsonTestDetailScreen.navigate(context, JsonTestDetailScreenData(item.setup.name)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed:
                            _testRecorderBlock.recordIsActive() ? null : () => _jsonTestAssemblerBloc.delete(index),
                      ),
                      IconButton(icon: Icon(Icons.ios_share), onPressed: () => _jsonTestAssemblerBloc.share(index)),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => HorizontalDelimiter(),
            );
          },
        )
      ],
    );
  }
}

class StartStopRecordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ApplicationContext>().testRecorderBloc;
    return StreamBuilder<bool>(
      stream: bloc.bsRecordingState.stream,
      builder: (context, snapshot) {
        final isRecording = snapshot.data ?? false;
        return IconButton(
            padding: EdgeInsets.only(right: 8),
            icon: Icon(isRecording ? Icons.stop : Icons.fiber_manual_record),
            onPressed: () => bloc.toggleRecordState());
      },
    );
  }
}
