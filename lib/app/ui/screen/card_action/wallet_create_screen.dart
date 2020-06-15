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

class CreateWalletScreen extends StatefulWidget {
  @override
  _CreateWalletScreenState createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  CreateWalletBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = CreateWalletBloc();
          return _bloc;
        })
      ],
      child: CreateWalletFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class CreateWalletFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.createWalletBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_wallet_create),
        actions: [Menu.popupDescription()],
      ),
      body: CreateWalletBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class CreateWalletBody extends StatefulWidget {
  @override
  _CreateWalletBodyState createState() => _CreateWalletBodyState();
}

class _CreateWalletBodyState extends State<CreateWalletBody> {
  TextStreamController _cidController;
  CreateWalletBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.createWalletBloc(context);
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

class CreateWalletBloc extends ActionBloc<CreateWalletResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  CreateWalletBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.createWallet(callback, {TangemSdk.cid: _cid});
  }
}
