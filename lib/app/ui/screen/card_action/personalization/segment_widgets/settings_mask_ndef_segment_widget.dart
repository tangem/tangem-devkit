import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SettingsMaskNdefSegmentWidget extends StatefulWidget {
  @override
  _SettingsMaskNdefSegmentWidgetState createState() => _SettingsMaskNdefSegmentWidgetState();
}

class _SettingsMaskNdefSegmentWidgetState extends State<SettingsMaskNdefSegmentWidget> {
  TextStreamController customAarController;
  TextStreamController uriController;
  PersonalizationBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.personalizationBloc(context);
    customAarController = TextStreamController(_bloc.settingsMaskNdef.customAar);
    uriController = TextStreamController(_bloc.settingsMaskNdef.uri);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final settingsMaskNdef = _bloc.settingsMaskNdef;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_settings_mask_ndef, description: transl.desc_pers_segment_settings_mask_ndef),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.useNdef,
          transl.pers_item_use_ndef,
          transl.desc_pers_item_use_ndef,
          settingsMaskNdef.useNdef,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.dynamicNdef,
          transl.pers_item_dynamic_ndef,
          transl.desc_pers_item_dynamic_ndef,
          settingsMaskNdef.dynamicNdef,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.disablePrecomputedNdef,
          transl.pers_item_disable_precomputed_ndef,
          transl.desc_pers_item_disable_precomputed_ndef,
          settingsMaskNdef.disablePrecomputedNdef,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SpinnerWidget(
          ItemName.idIssuer,
          _bloc.values.aar,
          settingsMaskNdef.aar,
          transl.pers_item_aar,
          transl.desc_pers_item_aar,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.customAar,
          customAarController.controller,
          hint: transl.pers_item_custom_aar_package_name,
          description: transl.desc_pers_item_custom_aar_package_name,
          scrollStream: _bloc.scrollingStateStream,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.uri,
          uriController.controller,
          hint: transl.pers_item_uri,
          description: transl.desc_pers_item_uri,
          scrollStream: _bloc.scrollingStateStream,
        ),
        HorizontalDelimiter(),
      ],
    );
  }

  @override
  void dispose() {
    customAarController.dispose();
    uriController.dispose();
    super.dispose();
  }
}
