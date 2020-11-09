import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/actions_bloc/actions_blocs.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../finders.dart';

class FilesDeleteScreen extends StatefulWidget {
  @override
  _FilesDeleteScreenState createState() => _FilesDeleteScreenState();
}

class _FilesDeleteScreenState extends State<FilesDeleteScreen> {
  FilesDeleteBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = FilesDeleteBloc();
          return _bloc;
        })
      ],
      child: FilesDeleteFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class FilesDeleteFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.setFilesDeleteBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_files_delete),
        actions: [Menu.popupDescription()],
      ),
      body: FilesDeleteBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class FilesDeleteBody extends StatefulWidget {
  @override
  _FilesDeleteBodyState createState() => _FilesDeleteBodyState();
}

class _FilesDeleteBodyState extends State<FilesDeleteBody> {
  FilesDeleteBloc _bloc;
  TextStreamController _cidController;
  TextStreamController _indicesController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.setFilesDeleteBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _indicesController = TextStreamController(_bloc.indicesStream);
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
          ItemName.indices,
          _indicesController.controller,
          hint: transl.files_delete_indices,
          description: transl.desc_files_delete_indices,
          inputType: TextInputType.number,
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