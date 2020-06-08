import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class TokenSegmentWidget extends StatefulWidget {
  @override
  _TokenSegmentWidgetState createState() => _TokenSegmentWidgetState();
}

class _TokenSegmentWidgetState extends State<TokenSegmentWidget> {
  PersonalizationBloc _bloc;
  TextStreamController tokenSymbol;
  TextStreamController tokenContractAddress;
  TextStreamController tokenDecimal;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.personalizationBloc(context);
    tokenSymbol = TextStreamController(_bloc.token.tokenSymbol);
    tokenContractAddress = TextStreamController(_bloc.token.tokenContractAddress);
    tokenDecimal = TextStreamController(_bloc.token.tokenDecimal, [RegExp(r'\d+')]);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final token = _bloc.token;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_token, description: transl.desc_pers_segment_token),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.itsToken,
          transl.pers_item_its_token,
          transl.desc_pers_item_its_token,
          token.itsToken,
          initialData: false,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.tokenSymbol,
          tokenSymbol.controller,
          hint: transl.pers_item_symbol,
          description: transl.desc_pers_item_symbol,
          scrollStream: _bloc.scrollingStateStream,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.tokenContractAddress,
          tokenContractAddress.controller,
          hint: transl.pers_item_contract_address,
          description: transl.desc_pers_item_contract_address,
          scrollStream: _bloc.scrollingStateStream,
        ),
        HorizontalDelimiter(),
        InputWidget(
          ItemName.tokenDecimal,
          tokenDecimal.controller,
          hint: transl.pers_item_decimal,
          description: transl.desc_pers_item_decimal,
          scrollStream: _bloc.scrollingStateStream,
          inputType: TextInputType.number,
        ),
        HorizontalDelimiter(),
      ],
    );
  }

  @override
  void dispose() {
    tokenSymbol.dispose();
    tokenContractAddress.dispose();
    tokenDecimal.dispose();
    super.dispose();
  }
}
