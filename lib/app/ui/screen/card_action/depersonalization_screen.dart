import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/finders.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers.dart';

class DepersonalizationScreen extends StatefulWidget {
  @override
  _DepersonalizationScreenState createState() => _DepersonalizationScreenState();
}

class _DepersonalizationScreenState extends State<DepersonalizationScreen> {
  late DepersonalizationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => DepersonalizationBloc().apply((it) => _bloc = it),
      child: DepersonalizationFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class DepersonalizationFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.depersonalizationBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_depersonalize),
        actions: [Menu.popupDescription()],
      ),
      body: DepersonalizationBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class DepersonalizationBody extends StatefulWidget {
  @override
  _DepersonalizationBodyState createState() => _DepersonalizationBodyState();
}

class _DepersonalizationBodyState extends State<DepersonalizationBody> {
  late DepersonalizationBloc _bloc;
  late TextStreamController _cidController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.depersonalizationBloc(context);
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
