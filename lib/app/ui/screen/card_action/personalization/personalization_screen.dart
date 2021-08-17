import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/finders.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers.dart';
import 'dialogs/import_config_dialog.dart';
import 'dialogs/save_config_dialog.dart';
import 'preset_list_screen.dart';
import 'segment_widgets/card_segment_widget.dart';
import 'segment_widgets/common_segment_widget.dart';
import 'segment_widgets/pins_segment_widget.dart';
import 'segment_widgets/product_mask_segment_widget.dart';
import 'segment_widgets/settings_mask_ndef_segment_widget.dart';
import 'segment_widgets/settings_mask_protocol_encryption_segment_widget.dart';
import 'segment_widgets/settings_mask_segment_widget.dart';
import 'segment_widgets/sign_hash_ex_prop_segment_widget.dart';
import 'segment_widgets/signing_method_segment_widget.dart';
import 'segment_widgets/token_segment_widget.dart';

class PersonalizationScreen extends StatefulWidget {
  @override
  _PersonalizationScreenState createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  late PersonalizationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final persConfigStorage = context.read<ApplicationContext>().storageRepo.personalizationConfigStorage;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PersonalizationBloc(persConfigStorage).apply((it) => _bloc = it))
      ],
      child: PersonalizeFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class PersonalizeFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.personalizationBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_personalize),
        actions: [
          RareFieldsSwitchWidget(),
          IconButton(
              onPressed: () {
                SaveConfigDialog(bloc).show(context);
                bloc.fetchSavedConfigNames();
              },
              icon: Icon(Icons.save)),
          Menu.popupPersonalization((MenuItem item) {
            switch (item) {
              case MenuItem.personalizationConfigs:
                PresetListScreen.navigate(context, bloc);
                break;
              case MenuItem.personalizationImport:
                ImportConfigDialog(bloc).show(context);
                break;
              case MenuItem.personalizationExport:
                bloc.shareCurrentConfig();
                break;
            }
          })
        ],
      ),
      body: PersonalizeBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class PersonalizeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.personalizationBloc(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          bloc.scrollingStateSink.add(true);
        } else if (notification is ScrollEndNotification) {
          bloc.scrollingStateSink.add(false);
        }
        return false;
      },
      child: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            HiddenResponseHandlerWidget(bloc),
            HiddenSnackBarHandlerWidget([bloc]),
            CardNumberSegmentWidget(),
            CommonSegmentWidget(),
            SigningMethodSegmentWidget(),
            SignHashExPropSegmentWidget(),
            TokenSegmentWidget(),
            ProductMaskSegmentWidget(),
            SettingsMaskSegmentWidget().visibilityHandler(bloc.statedFieldsVisibility),
            SettingsMaskProtocolEncryptionSegmentWidget().visibilityHandler(bloc.statedFieldsVisibility),
            SettingsMaskNdefSegmentWidget(),
            PinsSegmentWidget().gone(),
          ],
        ),
      ),
    );
  }
}

class RareFieldsSwitchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.personalizationBloc(context);
    return StreamBuilder<bool>(
      initialData: false,
      stream: bloc.statedFieldsVisibility.stream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? false;
        return IconButton(
            padding: EdgeInsets.only(right: 8),
            icon: Icon(data ? Icons.filter_alt_outlined : Icons.filter_alt),
            onPressed: () => bloc.statedFieldsVisibility.sink.add(!data));
      },
    );
  }
}
