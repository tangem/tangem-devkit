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
import 'package:tangem_sdk/tangem_sdk.dart';

import '../finders.dart';
import 'helpers.dart';

class PurgeWalletScreen extends StatefulWidget {
  @override
  _PurgeWalletScreenState createState() => _PurgeWalletScreenState();
}

class _PurgeWalletScreenState extends State<PurgeWalletScreen> {
  PurgeWalletBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = PurgeWalletBloc();
          return _bloc;
        })
      ],
      child: PurgeWalletFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class PurgeWalletFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.purgeWalletBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_wallet_purge),
        actions: [Menu.popupDescription()],
      ),
      body: PurgeWalletBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class PurgeWalletBody extends StatefulWidget {
  @override
  _PurgeWalletBodyState createState() => _PurgeWalletBodyState();
}

class _PurgeWalletBodyState extends State<PurgeWalletBody> {
  TextStreamController _cidController;
  PurgeWalletBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.purgeWalletBloc(context);
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

class PurgeWalletBloc extends ActionBloc<PurgeWalletResponse> {
  final bsCid = BehaviorSubject<String>();

  String _fCid;

  PurgeWalletBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _fCid = event));
  }

  @override
  invokeAction() {
    TangemSdk.purgeWallet(callback, CardOptionalValues().cid(_fCid).get());
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
