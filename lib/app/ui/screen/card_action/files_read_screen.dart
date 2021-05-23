import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';

class FilesReadScreen extends StatefulWidget {
  @override
  _FilesReadScreenState createState() => _FilesReadScreenState();
}

class _FilesReadScreenState extends State<FilesReadScreen> {
  late FilesReadBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => FilesReadBloc().apply((it) => _bloc = it))],
      child: FilesReadFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class FilesReadFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.setFilesReadBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_files_read),
        actions: [Menu.popupDescription()],
      ),
      body: FilesReadBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class FilesReadBody extends StatefulWidget {
  @override
  _FilesReadBodyState createState() => _FilesReadBodyState();
}

class _FilesReadBodyState extends State<FilesReadBody> {
  late FilesReadBloc _bloc;
  late TextStreamController _cidController;
  late TextStreamController _indicesController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.setFilesReadBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _indicesController = TextStreamController(_bloc.bsIndices);
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
          ItemName.indices,
          _indicesController.controller,
          hint: transl.files_read_indices,
          description: transl.desc_files_read_indices,
          inputType: TextInputType.number,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        SwitchWidget(
          ItemName.readPrivateFiles,
          transl.read_private_files,
          transl.desc_read_private_files,
          _bloc.bsReadProtectedFiles,
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
