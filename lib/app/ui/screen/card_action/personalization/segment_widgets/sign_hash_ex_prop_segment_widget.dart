import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SignHashExPropSegmentWidget extends StatefulWidget {
  @override
  _SignHashExPropSegmentWidgetState createState() => _SignHashExPropSegmentWidgetState();
}

class _SignHashExPropSegmentWidgetState extends State<SignHashExPropSegmentWidget> {
  PersonalizationBloc _bloc;
  TextStreamController pinLessFloorLimitController;
  TextStreamController hexCrExKeyController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.personalizationBloc(context);
    pinLessFloorLimitController = TextStreamController(_bloc.signHashExProperties.pinLessFloorLimit);
    hexCrExKeyController = TextStreamController(_bloc.signHashExProperties.hexCrExKey);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final signHashExProperties = _bloc.signHashExProperties;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_sign_hash_ex_prop, description: transl.desc_pers_segment_sign_hash_ex_prop),
        InputWidget(
          ItemName.pinLessFloorLimit,
          pinLessFloorLimitController.controller,
          hint: transl.pers_item_pin_less_floor_limit,
          description: transl.desc_pers_item_pin_less_floor_limit,
          scrollStream: _bloc.scrollingStateStream,
        ).withUnderline(),
        InputWidget(
          ItemName.hexCrExKey,
          hexCrExKeyController.controller,
          hint: transl.pers_item_sign_hash_ex,
          description: transl.desc_pers_item_sign_hash_ex,
          scrollStream: _bloc.scrollingStateStream,
        ).gone(),
        SwitchWidget(
          ItemName.requireTerminalCertSignature,
          transl.pers_item_require_terminal_cert_sig,
          transl.desc_pers_item_require_terminal_cert_sig,
          signHashExProperties.requireTerminalCertSignature,
          initialData: false,
        ).gone(),
        SwitchWidget(
          ItemName.requireTerminalTxSignature,
          transl.pers_item_require_terminal_tx_sig,
          transl.desc_pers_item_require_terminal_tx_sig,
          signHashExProperties.requireTerminalTxSignature,
          initialData: false,
        ).gone(),
        SwitchWidget(
          ItemName.checkPIN3onCard,
          transl.pers_item_check_pin3_on_card,
          transl.desc_pers_item_check_pin3_on_card,
          signHashExProperties.checkPIN3onCard,
          initialData: false,
        ).gone(),
      ],
    );
  }

  @override
  void dispose() {
    pinLessFloorLimitController.dispose();
    hexCrExKeyController.dispose();
    super.dispose();
  }
}
