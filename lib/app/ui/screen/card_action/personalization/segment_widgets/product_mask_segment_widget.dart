import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class ProductMaskSegmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final productMask = RepoFinder.personalizationBloc(context).productMask;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_product_mask, description: transl.desc_pers_segment_product_mask),
        SwitchWidget(
          ItemName.note,
          transl.pers_item_note,
          transl.desc_pers_item_note,
          productMask.note,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.tag,
          transl.pers_item_tag,
          transl.desc_pers_item_tag,
          productMask.tag,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.idCard,
          transl.pers_item_id_card,
          transl.desc_pers_item_id_card,
          productMask.idCard,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.idIssuer,
          transl.pers_item_id_issuer_card,
          transl.desc_pers_item_id_issuer_card,
          productMask.idIssuer,
          initialData: false,
        ),
      ],
    );
  }
}
