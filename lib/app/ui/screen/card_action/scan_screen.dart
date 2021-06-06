import 'package:devkit/app/domain/actions_bloc/exp_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/screen/finders.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late ScanBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => ScanBloc().apply((it) => _bloc = it),
      child: ScanFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class ScanFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.scanBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_scan),
        actions: [Menu.popupDescription()],
      ),
      body: ScanBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class ScanBody extends StatefulWidget {
  @override
  _ScanBodyState createState() => _ScanBodyState();
}

class _ScanBodyState extends State<ScanBody> {
  late ScanBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.scanBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      HiddenResponseHandlerWidget(_bloc),
      HiddenSnackBarHandlerWidget([_bloc]),
      HiddenTestRecorderWidget(_bloc),
      Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: TextWidget.howTo(Transl.of(context).how_to_scan),
        ),
      ),
    ]);
  }
}
