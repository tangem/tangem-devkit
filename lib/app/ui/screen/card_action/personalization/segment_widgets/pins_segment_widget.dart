import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class PinsSegmentWidget extends StatefulWidget {
  @override
  _PinsSegmentWidgetState createState() => _PinsSegmentWidgetState();
}

class _PinsSegmentWidgetState extends State<PinsSegmentWidget> {
  PersonalizationBloc _bloc;
  TextStreamController _pin1Controller;
  TextStreamController _pin2Controller;
  TextStreamController _pin3Controller;
  TextStreamController _cvcController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.personalizationBloc(context);
    final pins = _bloc.pins;
    _pin1Controller = TextStreamController(pins.pin1);
    _pin2Controller = TextStreamController(pins.pin2);
    _pin3Controller = TextStreamController(pins.pin3);
    _cvcController = TextStreamController(pins.cvc);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_pins, description: transl.desc_pers_segment_pins),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.pin1,
          _pin1Controller.controller,
          hint: transl.pers_item_pin,
          description: transl.desc_pers_item_pin,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.pin2,
          _pin2Controller.controller,
          hint: transl.pers_item_pin2,
          description: transl.desc_pers_item_pin2,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.pin3,
          _pin3Controller.controller,
          hint: transl.pers_item_pin3,
          description: transl.desc_pers_item_pin3,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.cvc,
          _cvcController.controller,
          hint: transl.pers_item_cvc,
          description: transl.desc_pers_item_cvc,
        ),
        HorizontalDelimiter(),
      ],
    );
  }

  @override
  void dispose() {
    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _cvcController.dispose();
    super.dispose();
  }
}
