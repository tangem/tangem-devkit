import 'package:devkit/app/domain/actions_bloc/actions_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text(Transl.of(context).screen_user_write_protected_data),
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
  WriteUserProtectedDataBloc _bloc;
  TextStreamController _cidController;
  TextStreamController _userDataController;
  TextStreamController _userDataCounterController;

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
          ItemName.userProtectedData,
          _userDataController.controller,
          hint: transl.user_protected_data,
          description: transl.desc_user_protected_data,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        InputWidget(
          ItemName.userProtectedCounter,
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
