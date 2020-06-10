import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/domain/actions_bloc/card_optional_values.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/extensions.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../finders.dart';
import 'helpers.dart';

class WriteIssuerDataScreen extends StatefulWidget {
  @override
  _WriteIssuerDataScreenState createState() => _WriteIssuerDataScreenState();
}

class _WriteIssuerDataScreenState extends State<WriteIssuerDataScreen> {
  WriteIssuerDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = WriteIssuerDataBloc();
          return _bloc;
        })
      ],
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
  WriteIssuerDataBloc _bloc;
  TextStreamController _cidController;
  TextStreamController _issuerDataController;
  TextStreamController _counterController;

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
        ),
        InputWidget(
          ItemName.issuerDataCounter,
          _counterController.controller,
          hint: transl.counter,
          description: transl.desc_counter,
          inputType: TextInputType.number,
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

class WriteIssuerDataBloc extends ActionBloc<WriteIssuerDataResponse> {
  final bsCid = BehaviorSubject<String>();
  final bsIssuerData = BehaviorSubject<String>();
  final bsIssuerDataCounter = BehaviorSubject<String>();

  String cid;
  String issuerData;
  int issuerDataCounter;

  WriteIssuerDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => cid = event));
    subscriptions.add(bsIssuerData.stream.listen((event) => issuerData = event));
    subscriptions.add(bsIssuerDataCounter.stream.listen((event) => issuerDataCounter = event.isEmpty ? null : int.parse(event)));
    bsIssuerData.add("Data to be written on a card as issuer data");
    bsIssuerDataCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeIssuerData(
      callback,
      issuerData.toHexString(),
      Issuer.def().dataKeyPair.privateKey.toHexString(),
      CardOptionalValues().cid(cid).issuerDataCounter(issuerDataCounter).get(),
    );
  }

  scanCard() {
    final callback = Callback((result) {
      bsCid.add(parseCidFromSuccessScan(result));
    }, (error) {
      sendError(error);
    });
    TangemSdk.scanCard(
      callback,
      CardOptionalValues().get(),
    );
  }
}
