import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';

class FilesWriteScreen extends StatefulWidget {
  @override
  _FilesWriteScreenState createState() => _FilesWriteScreenState();
}

class _FilesWriteScreenState extends State<FilesWriteScreen> {
  FilesWriteBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = FilesWriteBloc();
          return _bloc;
        })
      ],
      child: FilesWriteFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class FilesWriteFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.setFilesWriteBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_files_write),
        actions: [Menu.popupDescription()],
      ),
      body: FilesWriteBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class FilesWriteBody extends StatefulWidget {
  @override
  _FilesWriteBodyState createState() => _FilesWriteBodyState();
}

class _FilesWriteBodyState extends State<FilesWriteBody> {
  FilesWriteBloc _bloc;
  TextStreamController _cidController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.setFilesWriteBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
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
        SpinnerWidget(
          ItemName.protectionType,
          _bloc.protectionTypes,
          _bloc.bsProtectionType,
          transl.files_data_protection,
          transl.desc_files_data_protection,
        ),
        Row(
          children: [
            StreamBuilder(
              initialData: null,
              stream: _bloc.photoFileSizeStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                final fileSize = snapshot == null || snapshot.data == null ? "0" : snapshot.data.toString();
                return TextWidget("Photo file size (bytes): $fileSize");
              },
            ),
            Expanded(child: Container(), flex: 1),
            Button(
              key: ItemId.btnFrom(ItemName.takePhoto),
              text: "Take a photo",
              onPressed: () async {
                File file = await Navigator.push(context, MaterialPageRoute(builder: (context) => Camera()));
                _bloc.setPhotoFile(file);
              },
            ),
          ],
        ).paddingH16(),
        SizedBox(height: 15).withUnderline(),
        SizedBox(height: 15),
        StreamBuilder(
          initialData: null,
          stream: _bloc.photoStream,
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot == null || snapshot.data == null) return StubWidget();

            return Image.file(snapshot.data, fit: BoxFit.fill, width: 200);
          },
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
