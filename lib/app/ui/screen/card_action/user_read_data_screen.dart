import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class ReadUserDataScreen extends StatefulWidget {
  @override
  _ReadUserDataScreenState createState() => _ReadUserDataScreenState();
}

class _ReadUserDataScreenState extends State<ReadUserDataScreen> {
  late ReadUserDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => ReadUserDataBloc().apply((it) => _bloc = it))],
      child: ReadUserDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class ReadUserDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.readUserDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_user_read_data),
        actions: [Menu.popupDescription()],
      ),
      body: ReadUserDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class ReadUserDataBody extends StatefulWidget {
  @override
  _ReadUserDataBodyState createState() => _ReadUserDataBodyState();
}

class _ReadUserDataBodyState extends State<ReadUserDataBody> {
  late ReadUserDataBloc _bloc;
  late TextStreamController _cidController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.readUserDataBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HiddenResponseHandlerWidget(_bloc),
        HiddenSnackbarHandlerWidget([_bloc.snackbarMessageStream]),
        HiddenTestRecorderWidget(_bloc),
        SizedBox(height: 8),
        InputCidWidget(
          ItemName.cid,
          _cidController.controller,
          _bloc.scanCard,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cidController.dispose();
    super.dispose();
  }
}
