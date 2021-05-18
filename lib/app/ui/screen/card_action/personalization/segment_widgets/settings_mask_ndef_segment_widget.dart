import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SettingsMaskNdefSegmentWidget extends StatefulWidget {
  @override
  _SettingsMaskNdefSegmentWidgetState createState() => _SettingsMaskNdefSegmentWidgetState();
}

class _SettingsMaskNdefSegmentWidgetState extends State<SettingsMaskNdefSegmentWidget> {
  late PersonalizationBloc _bloc;
  late TextStreamController customAarController;
  late TextStreamController uriController;

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
        SwitchWidget(
          ItemName.useNDEF,
          transl.pers_item_use_ndef,
          transl.desc_pers_item_use_ndef,
          settingsMaskNdef.useNDEF,
          initialData: false,
        ).withUnderline().visibilityHandler(_bloc.statedFieldsVisibility),
        SwitchWidget(
          ItemName.useDynamicNDEF,
          transl.pers_item_dynamic_ndef,
          transl.desc_pers_item_dynamic_ndef,
          settingsMaskNdef.useDynamicNDEF,
          initialData: false,
        ).withUnderline().visibilityHandler(_bloc.statedFieldsVisibility),
        SwitchWidget(
          ItemName.disablePrecomputedNDEF,
          transl.pers_item_disable_precomputed_ndef,
          transl.desc_pers_item_disable_precomputed_ndef,
          settingsMaskNdef.disablePrecomputedNDEF,
          initialData: false,
        ).withUnderline().visibilityHandler(_bloc.statedFieldsVisibility),
        SpinnerWidget(
          ItemName.aar,
          _bloc.values.aar,
          settingsMaskNdef.aar,
          transl.pers_item_aar,
          transl.desc_pers_item_aar,
        ).withUnderline(),
        InputWidget(
          ItemName.customAar,
          customAarController.controller,
          hint: transl.pers_item_custom_aar_package_name,
          description: transl.desc_pers_item_custom_aar_package_name,
          scrollStream: _bloc.scrollingStateStream,
        ).withUnderline(),
        InputWidget(
          ItemName.uri,
          uriController.controller,
          hint: transl.pers_item_uri,
          description: transl.desc_pers_item_uri,
          scrollStream: _bloc.scrollingStateStream,
        ).withUnderline(),
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
