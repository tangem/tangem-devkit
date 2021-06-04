import 'package:devkit/app/domain/actions_bloc/exp_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class WriteUserDataScreen extends StatefulWidget {
  @override
  _WriteUserDataScreenState createState() => _WriteUserDataScreenState();
}

class _WriteUserDataScreenState extends State<WriteUserDataScreen> {
  late WriteUserDataBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => WriteUserDataBloc().apply((it) => _bloc = it))],
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
  late WriteUserDataBloc _bloc;
  late TextStreamController _cidController;
  late TextStreamController _userDataController;
  late TextStreamController _userDataCounterController;

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
