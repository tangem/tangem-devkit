import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';
import 'helpers.dart';

class SignScreen extends StatefulWidget {
  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late SignBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => SignBloc().apply((it) => _bloc = it))],
      child: SignFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class SignFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.signBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_sign),
        actions: [Menu.popupDescription()],
      ),
      body: SignBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class SignBody extends StatefulWidget {
  @override
  _SignBodyState createState() => _SignBodyState();
}

class _SignBodyState extends State<SignBody> {
  late SignBloc _bloc;
  late TextStreamController _cidController;
  late TextStreamController _dataForHashingController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.signBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _dataForHashingController = TextStreamController(_bloc.bsDataForHashing);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        HiddenResponseHandlerWidget(_bloc),
        HiddenSnackbarHandlerWidget([_bloc.snackbarMessageStream]),
        HiddenTestRecorderWidget(_bloc),
        SizedBox(height: 8),
        InputCidWidget(
          ItemName.cid,
          _cidController.controller,
          _bloc.scanCard,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        InputWidget(
          ItemName.dataForHashing,
          _dataForHashingController.controller,
          hint: transl.transaction_out_hash,
          description: transl.desc_transaction_out_hash,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cidController.dispose();
    _dataForHashingController.dispose();
    super.dispose();
  }
}
