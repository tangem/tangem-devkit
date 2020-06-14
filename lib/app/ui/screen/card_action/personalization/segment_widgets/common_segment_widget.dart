import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../finders.dart';

class CommonSegmentWidget extends StatefulWidget {
  @override
  _CommonSegmentWidgetState createState() => _CommonSegmentWidgetState();
}

class _CommonSegmentWidgetState extends State<CommonSegmentWidget> {
  PersonalizationBloc _bloc;
  TextStreamController _customBlockchainController;
  TextStreamController _maxSignaturesController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.personalizationBloc(context);
    _customBlockchainController = TextStreamController(_bloc.common.bsCustomBlockchain);
    _maxSignaturesController = TextStreamController(_bloc.common.bsMaxSignatures, [RegExp(r'\d+')]);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_common, description: transl.desc_pers_segment_common),
        SpinnerWidget(
          ItemName.blockchain,
          _bloc.values.blockchain,
          _bloc.common.bsBlockchain,
          transl.pers_item_blockchain,
          transl.desc_pers_item_blockchain,
        ).withUnderline(),
        InputWidget(
          ItemName.customBlockchain,
          _customBlockchainController.controller,
          hint: transl.pers_item_custom_blockchain,
          description: transl.desc_pers_item_custom_blockchain,
          scrollStream: _bloc.scrollingStateStream,
        ).withUnderline(),
        SpinnerWidget(
          ItemName.curve,
          _bloc.values.curves,
          _bloc.common.bsCurve,
          transl.pers_item_curve,
          transl.desc_pers_item_curve,
        ).withUnderline(),
        InputWidget(
          ItemName.maxSignatures,
          _maxSignaturesController.controller,
          hint: transl.pers_item_max_signatures,
          description: transl.desc_pers_item_max_signatures,
          inputType: TextInputType.number,
          scrollStream: _bloc.scrollingStateStream,
        ).withUnderline(),
        SwitchWidget(
          ItemName.createWallet,
          transl.pers_item_create_wallet,
          transl.desc_pers_item_create_wallet,
          _bloc.common.bsCreateWallet,
          initialData: false,
        ).withUnderline(),
        SpinnerWidget(
          ItemName.pauseBeforePin2,
          _bloc.values.pauseBeforePin,
          _bloc.common.bsPauseBeforePin,
          transl.pers_item_pause_before_pin2,
          transl.desc_pers_item_pause_before_pin2,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _customBlockchainController.dispose();
    super.dispose();
  }
}
