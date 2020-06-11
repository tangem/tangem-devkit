import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../finders.dart';
import 'helpers.dart';

class WriteUserDataScreen extends StatefulWidget {
  @override
  _WriteUserDataScreenState createState() => _WriteUserDataScreenState();
}

class _WriteUserDataScreenState extends State<WriteUserDataScreen> {
  WriteUserDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = WriteUserDataBloc();
          return _bloc;
        })
      ],
      child: WriteUserDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class WriteUserDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.writeUserDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_user_write_data),
        actions: [Menu.popupDescription()],
      ),
      body: WriteUserDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class WriteUserDataBody extends StatefulWidget {
  @override
  _WriteUserDataBodyState createState() => _WriteUserDataBodyState();
}

class _WriteUserDataBodyState extends State<WriteUserDataBody> {
  TextStreamController _cidController;
  TextStreamController _userDataController;
  TextStreamController _userDataCounterController;
  WriteUserDataBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.writeUserDataBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _userDataController = TextStreamController(_bloc.bsUserData);
    _userDataCounterController = TextStreamController(_bloc.bsUserCounter, [RegExp(r'\d+')]);
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
          ItemName.userData,
          _userDataController.controller,
          hint: transl.user_data,
          description: transl.desc_user_data,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        InputWidget(
          ItemName.userCounter,
          _userDataCounterController.controller,
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
    _userDataController.dispose();
    _userDataCounterController.dispose();
    super.dispose();
  }
}

class WriteUserDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserData = BehaviorSubject<String>();
  final bsUserCounter = BehaviorSubject<String>();

  String _cid;
  String _userData;
  int _userCounter;

  WriteUserDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
    subscriptions.add(bsUserData.stream.listen((event) => _userData = event));
    subscriptions.add(bsUserCounter.stream.listen((event) => _userCounter = event.isEmpty ? null : int.parse(event)));
    bsUserData.add("User data to be written on a card");
    bsUserCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeUserData(callback, {
      TangemSdk.cid: _cid,
      TangemSdk.userDataHex: _userData.toHexString(),
      TangemSdk.userCounter: _userCounter,
    });
  }
}
