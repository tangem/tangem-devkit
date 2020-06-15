import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../finders.dart';
import 'helpers.dart';

class ReadUserDataScreen extends StatefulWidget {
  @override
  _ReadUserDataScreenState createState() => _ReadUserDataScreenState();
}

class _ReadUserDataScreenState extends State<ReadUserDataScreen> {
  ReadUserDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = ReadUserDataBloc();
          return _bloc;
        })
      ],
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
        title: Text(Transl.of(context).screen_issuer_read_data),
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
  TextStreamController _cidController;
  ReadUserDataBloc _bloc;

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

class ReadUserDataBloc extends ActionBloc<ReadUserDataResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  ReadUserDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.readUserData(callback, {TangemSdk.cid: _cid});
  }
}
