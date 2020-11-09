import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/actions_bloc/actions_blocs.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import '../finders.dart';

class FilesChangeSettingsScreen extends StatefulWidget {
  @override
  _FilesReadScreenState createState() => _FilesReadScreenState();
}

class _FilesReadScreenState extends State<FilesChangeSettingsScreen> {
  FilesChangeSettingsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = FilesChangeSettingsBloc();
          return _bloc;
        })
      ],
      child: FilesChangeSettingsFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class FilesChangeSettingsFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.setFilesChangeSettingsBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_files_change_settings),
        actions: [Menu.popupDescription()],
      ),
      body: FilesChangeSettingsBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class FilesChangeSettingsBody extends StatefulWidget {
  @override
  _FilesReadBodyState createState() => _FilesReadBodyState();
}

class _FilesReadBodyState extends State<FilesChangeSettingsBody> {
  FilesChangeSettingsBloc _bloc;
  TextStreamController _cidController;
  TextStreamController _indicesController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.setFilesChangeSettingsBloc(context);
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
          hint: transl.files_read_indices,
          description: transl.desc_files_read_indices,
          inputType: TextInputType.number,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        SpinnerWidget(
          ItemName.fileSettings,
          _bloc.fileSettings,
          _bloc.bsFileSettings,
          transl.files_file_settings,
          transl.desc_files_file_settings,
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