import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class ReadIssuerDataScreen extends StatefulWidget {
  @override
  _ReadIssuerDataScreenState createState() => _ReadIssuerDataScreenState();
}

class _ReadIssuerDataScreenState extends State<ReadIssuerDataScreen> {
  late ReadIssuerDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => ReadIssuerDataBloc().apply((it) => _bloc = it))],
      child: ReadIssuerDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class ReadIssuerDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.readIssuerDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_issuer_read_data),
        actions: [Menu.popupDescription()],
      ),
      body: ReadIssuerDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class ReadIssuerDataBody extends StatefulWidget {
  @override
  _ReadIssuerDataBodyState createState() => _ReadIssuerDataBodyState();
}

class _ReadIssuerDataBodyState extends State<ReadIssuerDataBody> {
  late ReadIssuerDataBloc _bloc;
  late TextStreamController _cidController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.readIssuerDataBloc(context);
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
