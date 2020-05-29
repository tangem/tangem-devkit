import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SigningMethodSegmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final signingMethod = RepoFinder.personalizationBloc(context).signingMethod;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_signing_method, description: transl.desc_pers_segment_signing_method),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.txHashes,
          transl.pers_item_sign_tx_hashes,
          transl.desc_pers_item_sign_tx_hashes,
          signingMethod.bsTxHashes,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.rawTx,
          transl.pers_item_sign_raw_tx,
          transl.desc_pers_item_sign_raw_tx,
          signingMethod.bsRawTx,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.validatedTxHashes,
          transl.pers_item_sign_validated_tx_hashes,
          transl.desc_pers_item_sign_validated_tx_hashes,
          signingMethod.bsValidatedTxHashes,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.validatedRawTx,
          transl.pers_item_sign_validated_raw_tx,
          transl.desc_pers_item_sign_validated_raw_tx,
          signingMethod.bsValidatedRawTx,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.validatedTxHashesWithIssuerData,
          transl.pers_item_sign_validated_tx_hashes_with_iss_data,
          transl.desc_pers_item_sign_validated_tx_hashes_with_iss_data,
          signingMethod.bsValidatedTxHashesWithIssuerData,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.validatedRawTxWithIssuerData,
          transl.pers_item_sign_validated_raw_tx_with_iss_data,
          transl.desc_pers_item_sign_validated_raw_tx_with_iss_data,
          signingMethod.bsValidatedRawTxWithIssuerData,
          initialData: false,
        ),
        HorizontalDelimiter(),
        SwitchWidget(
          ItemName.externalHash,
          transl.pers_item_sign_hash_ex,
          transl.desc_pers_item_sign_hash_ex,
          signingMethod.bsExternalHash,
          initialData: false,
        ),
        HorizontalDelimiter(),
      ],
    );
  }
}
