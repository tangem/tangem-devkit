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

class WriteUserProtectedDataScreen extends StatefulWidget {
  @override
  _WriteUserProtectedDataScreenState createState() => _WriteUserProtectedDataScreenState();
}

class _WriteUserProtectedDataScreenState extends State<WriteUserProtectedDataScreen> {
  WriteUserProtectedDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = WriteUserProtectedDataBloc();
          return _bloc;
        })
      ],
      child: WriteUserProtectedDataFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class WriteUserProtectedDataFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.writeUserProtectedDataBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_user_write_data),
        actions: [Menu.popupDescription()],
      ),
      body: WriteUserProtectedDataBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class WriteUserProtectedDataBody extends StatefulWidget {
  @override
  _WriteUserProtectedDataBodyState createState() => _WriteUserProtectedDataBodyState();
}

class _WriteUserProtectedDataBodyState extends State<WriteUserProtectedDataBody> {
  TextStreamController _cidController;
  TextStreamController _userDataController;
  TextStreamController _userDataCounterController;
  WriteUserProtectedDataBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.writeUserProtectedDataBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _userDataController = TextStreamController(_bloc.bsUserProtectedData);
    _userDataCounterController = TextStreamController(_bloc.bsUserProtectedCounter, [RegExp(r'\d+')]);
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

class WriteUserProtectedDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserProtectedData = BehaviorSubject<String>();
  final bsUserProtectedCounter = BehaviorSubject<String>();

  String _cid;
  String _userProtectedData;
  int _userProtectedCounter;

  WriteUserProtectedDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
    subscriptions.add(bsUserProtectedData.stream.listen((event) => _userProtectedData = event));
    subscriptions.add(bsUserProtectedCounter.stream.listen((event) => _userProtectedCounter = event.isEmpty ? null : int.parse(event)));
    bsUserProtectedData.add("Protected user data to be written on a card");
    bsUserProtectedCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeUserProtectedData(callback, {
      TangemSdk.cid: _cid,
      TangemSdk.userProtectedDataHex: _userProtectedData.toHexString(),
      TangemSdk.userProtectedCounter: _userProtectedCounter,
    });
  }
}
