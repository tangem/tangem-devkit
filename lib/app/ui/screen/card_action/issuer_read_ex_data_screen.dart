import 'package:devkit/app/domain/actions_bloc/actions_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class ReadIssuerExDataScreen extends StatefulWidget {
  @override
  _ReadIssuerExDataScreenState createState() => _ReadIssuerExDataScreenState();
}

class _ReadIssuerExDataScreenState extends State<ReadIssuerExDataScreen> {
  ReadIssuerExDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = ReadIssuerExDataBloc();
          return _bloc;
        })
      ],
      child: ReadIssuerExDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class ReadIssuerExDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.readIssuerExDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_issuer_read_ex_data),
        actions: [Menu.popupDescription()],
      ),
      body: ReadIssuerExDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class ReadIssuerExDataBody extends StatefulWidget {
  @override
  _ReadIssuerExDataBodyState createState() => _ReadIssuerExDataBodyState();
}

class _ReadIssuerExDataBodyState extends State<ReadIssuerExDataBody> {
  ReadIssuerExDataBloc _bloc;
  TextStreamController _cidController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.readIssuerExDataBloc(context);
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
