import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SettingMaskSegmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final settingMask = RepoFinder.personalizationBloc(context).settingsMask;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_settings_mask, description: transl.desc_pers_segment_settings_mask),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.isReusable,
          transl.pers_item_is_reusable,
          transl.desc_pers_item_is_reusable,
          settingMask.isReusable,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.useActivation,
          transl.pers_item_use_activation,
          transl.desc_pers_item_use_activation,
          settingMask.useActivation,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.forbidPurgeWallet,
          transl.pers_item_forbid_purge,
          transl.desc_pers_item_forbid_purge,
          settingMask.forbidPurgeWallet,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.allowSelectBlockchain,
          transl.pers_item_allow_select_blockchain,
          transl.desc_pers_item_allow_select_blockchain,
          settingMask.allowSelectBlockchain,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.useBlock,
          transl.pers_item_use_block,
          transl.desc_pers_item_use_block,
          settingMask.useBlock,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.useOneCommandAtTime,
          transl.pers_item_one_apdu_at_once,
          transl.desc_pers_item_one_apdu_at_once,
          settingMask.useOneCommandAtTime,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.useCVC,
          transl.pers_item_use_cvc,
          transl.desc_pers_item_use_cvc,
          settingMask.useCVC,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.allowSwapPIN1,
          transl.pers_item_allow_swap_pin1,
          transl.desc_pers_item_allow_swap_pin1,
          settingMask.allowSwapPIN1,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.allowSwapPIN2,
          transl.pers_item_allow_swap_pin2,
          transl.desc_pers_item_allow_swap_pin2,
          settingMask.allowSwapPIN2,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.forbidDefaultPIN,
          transl.pers_item_forbid_default_pin,
          transl.desc_pers_item_forbid_default_pin,
          settingMask.forbidDefaultPIN,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.smartSecurityDelay,
          transl.pers_item_smart_security_delay,
          transl.desc_pers_item_smart_security_delay,
          settingMask.smartSecurityDelay,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.protectIssuerDataAgainstReplay,
          transl.pers_item_protect_issuer_data_against_replay,
          transl.desc_pers_item_protect_issuer_data_against_replay,
          settingMask.protectIssuerDataAgainstReplay,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.skipSecurityDelayIfValidatedByIssuer,
          transl.pers_item_skip_security_delay_if_validated,
          transl.desc_pers_item_skip_security_delay_if_validated,
          settingMask.skipSecurityDelayIfValidatedByIssuer,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.skipCheckPIN2andCVCIfValidatedByIssuer,
          transl.pers_item_skip_pin2_and_cvc_if_validated,
          transl.desc_pers_item_skip_pin2_and_cvc_if_validated,
          settingMask.skipCheckPIN2andCVCIfValidatedByIssuer,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.skipSecurityDelayIfValidatedByLinkedTerminal,
          transl.pers_item_skip_security_delay_on_linked_terminal,
          transl.desc_pers_item_skip_security_delay_on_linked_terminal,
          settingMask.skipSecurityDelayIfValidatedByLinkedTerminal,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.restrictOverwriteIssuerDataEx,
          transl.pers_item_restrict_overwrite_ex_issuer_data,
          transl.desc_pers_item_restrict_overwrite_ex_issuer_data,
          settingMask.restrictOverwriteIssuerDataEx,
          initialData: false,
        ),
        HorizontalDelimiter(),
      ],
    );
  }
}
