import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:devkit/app/domain/actions_bloc/ex_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../finders.dart';

class FilesWriteScreen extends StatefulWidget {
  @override
  _FilesWriteScreenState createState() => _FilesWriteScreenState();
}

class _FilesWriteScreenState extends State<FilesWriteScreen> {
  late FilesWriteBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => FilesWriteBloc().apply((it) => _bloc = it))],
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
  late FilesWriteBloc _bloc;
  late TextStreamController _cidController;

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
        HiddenSnackBarHandlerWidget([_bloc]),
        HiddenTestRecorderWidget(_bloc),
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
            StreamBuilder<int>(
              initialData: null,
              stream: _bloc.photoFileSizeStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                final fileSize = stringOf(snapshot.data, def: "0");
                return TextWidget("Photo file size (bytes): $fileSize");
              },
            ),
            Expanded(child: Container(), flex: 1),
            Button(
              "Take a photo",
              key: ItemId.btnFrom(ItemName.takePhoto),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CameraCamera(
                            resolutionPreset: ResolutionPreset.low,
                            onFile: (file) {
                              _bloc.setPhotoFile(file);
                              Navigator.pop(context);
                            })));
              },
            ),
          ],
        ).paddingH16(),
        SizedBox(height: 15).withUnderline(),
        SizedBox(height: 15),
        StreamBuilder<File?>(
          initialData: null,
          stream: _bloc.photoStream,
          builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
            if (snapshot.data == null) return StubWidget();

            return Image.file(snapshot.data!, fit: BoxFit.fill, width: 200);
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
