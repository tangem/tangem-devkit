import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class CardNumberSegmentWidget extends StatefulWidget {
  @override
  _CardNumberSegmentWidgetState createState() => _CardNumberSegmentWidgetState();
}

class _CardNumberSegmentWidgetState extends State<CardNumberSegmentWidget> {
  late PersonalizationBloc _bloc;
  late TextStreamController _seriesController;
  late TextStreamController _numberController;
  late TextStreamController _batchIdController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.personalizationBloc(context);
    final cardNumber = _bloc.cardNumber;
    _seriesController = TextStreamController(cardNumber.bsSeries, []);
    _numberController = TextStreamController(cardNumber.bsNumber, [RegExp(r'\d+')]);
    _batchIdController = TextStreamController(cardNumber.bsBatchId, []);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        SegmentHeader(
          transl.pers_segment_card_number,
          description: transl.desc_pers_segment_card_number,
        ).visibilityHandler(_bloc.statedFieldsVisibility),
        InputWidget(
          ItemName.series,
          _seriesController.controller,
          hint: transl.pers_item_series,
          description: transl.desc_pers_item_series,
          scrollStream: _bloc.scrollingStateStream,
        ).gone(),
        InputWidget(
          ItemName.batchId,
          _batchIdController.controller,
          hint: transl.pers_item_batch_id,
          description: transl.desc_pers_item_batch_id,
          scrollStream: _bloc.scrollingStateStream,
        ).visibilityHandler(_bloc.statedFieldsVisibility),
        InputWidget(
          ItemName.number,
          _numberController.controller,
          hint: transl.pers_item_number,
          description: transl.desc_pers_item_number,
          inputType: TextInputType.number,
          scrollStream: _bloc.scrollingStateStream,
        ).withUnderline().visibilityHandler(_bloc.statedFieldsVisibility),
      ],
    );
  }

  @override
  void dispose() {
    _seriesController.dispose();
    _numberController.dispose();
    _batchIdController.dispose();
    super.dispose();
  }
}
