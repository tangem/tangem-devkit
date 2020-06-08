import 'dart:async';

import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/personalization/dialogs/import_config_dialog.dart';
import 'package:devkit/app/ui/screen/card_action/personalization/segment_widgets/sign_hash_ex_prop_segment_widget.dart';
import 'package:devkit/app/ui/screen/finders.dart';
import 'package:devkit/app/ui/screen/response/response_main.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialogs/save_load_configs_dialog.dart';
import 'segment_widgets/card_number_segment_widget.dart';
import 'segment_widgets/common_segment_widget.dart';
import 'segment_widgets/pins_segment_widget.dart';
import 'segment_widgets/product_mask_segment_widget.dart';
import 'segment_widgets/settings_mask_ndef_segment_widget.dart';
import 'segment_widgets/settings_mask_protocol_encryption_segment_widget.dart';
import 'segment_widgets/settings_mask_segment_widget.dart';
import 'segment_widgets/signing_method_segment_widget.dart';
import 'segment_widgets/token_segment_widget.dart';

class PersonalizationScreen extends StatefulWidget {
  @override
  _PersonalizationScreenState createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  PersonalizationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = PersonalizationBloc();
          return _bloc;
        })
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
          Menu.popupPersonalization((MenuItem item) {
            switch (item) {
              case MenuItem.personalizationConfigs:
                SaveLoadConfigsDialog(bloc).show(context);
                bloc.fetchSavedConfigNames();
                break;
              case MenuItem.personalizationImport:
                ImportConfigDialog(bloc).show(context);
                break;
              case MenuItem.personalizationExport:
                bloc.exportCurrentConfig();
                break;
            }
          })
        ],
      ),
      body: PersonalizeBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.personalize,
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
      child: ListView(
        children: <Widget>[
          HiddenResponseHandlerWidget(),
          HiddenSnackbarHandlerWidget([bloc.snackbarMessageStream]),
          CardNumberSegmentWidget(),
          CommonSegmentWidget(),
          SigningMethodSegmentWidget(),
          SignHashExPropSegmentWidget(),
          TokenSegmentWidget(),
          ProductMaskSegmentWidget(),
          SettingMaskSegmentWidget(),
          SettingMaskProtocolEncryptionSegmentWidget(),
          SettingsMaskNdefSegmentWidget(),
          PinsSegmentWidget(),
        ],
      ),
    );
  }
}

class HiddenResponseHandlerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.personalizationBloc(context);
    return Stack(
      children: <Widget>[
        StreamBuilder(
          stream: bloc.successResponseStream,
          initialData: null,
          builder: (context, snapshot) {
            final widget = StubWidget();
            if (snapshot == null || snapshot.data == null) return widget;

            Future.delayed(Duration(milliseconds: 100), () => ResponseScreen.navigate(context, snapshot.data));
            return widget;
          },
        ),
        StreamBuilder(
          stream: bloc.errorResponseStream,
          initialData: null,
          builder: (context, snapshot) {
            final widget = StubWidget();
            if (snapshot == null || snapshot.data == null) return widget;

            Future.delayed(Duration(milliseconds: 100), () => showSnackbar(context, snapshot.data));
            return widget;
          },
        ),
      ],
    );
  }
}

class HiddenSnackbarHandlerWidget extends StatefulWidget {
  final List<Stream> messageStreams;

  const HiddenSnackbarHandlerWidget(this.messageStreams);

  @override
  _HiddenSnackbarHandlerWidgetState createState() => _HiddenSnackbarHandlerWidgetState();
}

class _HiddenSnackbarHandlerWidgetState extends State<HiddenSnackbarHandlerWidget> {
  List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    widget.messageStreams.forEach((element) => _subscriptions.add(element.listen((event) => showJsonSnackbar(context, event))));
  }

  @override
  Widget build(BuildContext context) => StubWidget();

  @override
  void dispose() {
    super.dispose();
    _subscriptions.forEach((element) => element.cancel());
  }
}