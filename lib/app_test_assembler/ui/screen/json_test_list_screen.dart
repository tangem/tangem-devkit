import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app_test_assembler/domain/bloc/json_test_list_bloc.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/app_test_assembler/domain/model/json_test_model.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions.dart';

class JsonTestListScreen extends StatefulWidget {
  const JsonTestListScreen({Key? key}) : super(key: key);

  @override
  _JsonTestListScreenState createState() => _JsonTestListScreenState();
}

class _JsonTestListScreenState extends State<JsonTestListScreen> {
  late JsonTestListBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final storageRepo = context.read<ApplicationContext>().storageRepo;
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => JsonTestListBloc(storageRepo).apply((it) => _bloc = it))],
      child: JsonTestListFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class JsonTestListFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test assembler"),
        actions: [StartStopRecordWidget()],
      ),
      body: JsonTestListBody(),
    );
  }
}

class JsonTestListBody extends StatefulWidget {
  @override
  _JsonTestListBodyState createState() => _JsonTestListBodyState();
}

class _JsonTestListBodyState extends State<JsonTestListBody> {
  late JsonTestListBloc _jsonTestListBloc;
  late TestRecorderBlock _testRecorderBlock;

  @override
  void initState() {
    super.initState();

    _jsonTestListBloc = context.read<JsonTestListBloc>();
    _testRecorderBlock = context.read<ApplicationContext>().testRecorderBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HiddenSnackBarHandlerWidget([_jsonTestListBloc, _testRecorderBlock]),
        StreamBuilder<List<JsonTest>>(
          stream: _jsonTestListBloc.bsRecords.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) return CenterLoadingText();
            if (snapshot.data!.isEmpty) return CenterText("Tests not created yet");

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
                      _testRecorderBlock.recordIsActive() ? StubWidget() : IconButton(icon: Icon(Icons.delete_forever), onPressed: ()=>_jsonTestListBloc.delete(index)),
                      IconButton(icon: Icon(Icons.ios_share), onPressed: () => _jsonTestListBloc.share(index)),
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
