import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SettingsMaskProtocolEncryptionSegmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final settingMaskProtocolEncryption = RepoFinder.personalizationBloc(context).settingMaskProtocolEncryption;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_settings_mask_protocol_enc, description: transl.desc_pers_segment_settings_mask_protocol_enc),
        SwitchWidget(
          ItemName.allowUnencrypted,
          transl.pers_item_allow_unencrypted,
          transl.desc_pers_item_allow_unencrypted,
          settingMaskProtocolEncryption.allowUnencrypted,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.allowFastEncryption,
          transl.pers_item_allow_fast_encryption,
          transl.desc_pers_item_allow_fast_encryption,
          settingMaskProtocolEncryption.allowFastEncryption,
          initialData: false,
        ),
      ],
    );
  }
}
