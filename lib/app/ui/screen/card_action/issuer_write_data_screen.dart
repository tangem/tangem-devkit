import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class WriteIssuerDataScreen extends StatefulWidget {
  @override
  _WriteIssuerDataScreenState createState() => _WriteIssuerDataScreenState();
}

class _WriteIssuerDataScreenState extends State<WriteIssuerDataScreen> {
  late WriteIssuerDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => WriteIssuerDataBloc().apply((it) => _bloc = it))],
      child: WriteIssuerDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class WriteIssuerDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.writeIssuerDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_issuer_write_data),
        actions: [Menu.popupDescription()],
      ),
      body: WriteIssuerDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class WriteIssuerDataBody extends StatefulWidget {
  @override
  _WriteIssuerDataBodyState createState() => _WriteIssuerDataBodyState();
}

class _WriteIssuerDataBodyState extends State<WriteIssuerDataBody> {
  late WriteIssuerDataBloc _bloc;
  late TextStreamController _cidController;
  late TextStreamController _issuerDataController;
  late TextStreamController _counterController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.writeIssuerDataBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _issuerDataController = TextStreamController(_bloc.bsIssuerData);
    _counterController = TextStreamController(_bloc.bsIssuerDataCounter, [RegExp(r'\d+')]);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
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
        InputWidget(
          ItemName.issuerData,
          _issuerDataController.controller,
          hint: transl.issuer_data,
          description: transl.desc_issuer_data,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        InputWidget(
          ItemName.issuerDataCounter,
          _counterController.controller,
          hint: transl.counter,
          description: transl.desc_counter,
          inputType: TextInputType.number,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cidController.dispose();
    _issuerDataController.dispose();
    _counterController.dispose();
    super.dispose();
  }
}
