import 'package:devkit/app/domain/actions_bloc/exp_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class WriteIssuerExDataScreen extends StatefulWidget {
  @override
  _WriteIssuerExDataScreenState createState() => _WriteIssuerExDataScreenState();
}

class _WriteIssuerExDataScreenState extends State<WriteIssuerExDataScreen> {
  late WriteIssuerExDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => WriteIssuerExDataBloc().apply((it) => _bloc = it))],
      child: WriteIssuerExDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class WriteIssuerExDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.writeIssuerExDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_issuer_write_ex_data),
        actions: [Menu.popupDescription()],
      ),
      body: WriteIssuerExDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class WriteIssuerExDataBody extends StatefulWidget {
  @override
  _WriteIssuerExDataBodyState createState() => _WriteIssuerExDataBodyState();
}

class _WriteIssuerExDataBodyState extends State<WriteIssuerExDataBody> {
  late WriteIssuerExDataBloc _bloc;
  late TextStreamController _cidController;
  late TextStreamController _counterController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.writeIssuerExDataBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _counterController = TextStreamController(_bloc.bsIssuerDataCounter, [RegExp(r'\d+')]);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        HiddenResponseHandlerWidget(_bloc),
        HiddenSnackBarHandlerWidget([_bloc]),
        HiddenTestRecorderWidget(_bloc),
        SizedBox(height: 8),
        InputCidWidget(
          ItemName.cid,
          _cidController.controller,
          _bloc.scanCard,
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
    _counterController.dispose();
    super.dispose();
  }
}
