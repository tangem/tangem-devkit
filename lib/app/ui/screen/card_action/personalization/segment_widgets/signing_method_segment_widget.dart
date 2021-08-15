import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../finders.dart';

class SigningMethodSegmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final bloc = RepoFinder.personalizationBloc(context);
    final signingMethod = bloc.signingMethod;

    return Column(
      children: <Widget>[
        SegmentHeader(transl.pers_segment_signing_method, description: transl.desc_pers_segment_signing_method),
        SwitchWidget(
          ItemName.txHashes,
          transl.pers_item_sign_tx_hashes,
          transl.desc_pers_item_sign_tx_hashes,
          signingMethod.bsTxHashes,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.rawTx,
          transl.pers_item_sign_raw_tx,
          transl.desc_pers_item_sign_raw_tx,
          signingMethod.bsRawTx,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.validatedTxHashes,
          transl.pers_item_sign_validated_tx_hashes,
          transl.desc_pers_item_sign_validated_tx_hashes,
          signingMethod.bsHashSignedByIssuer,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.validatedRawTx,
          transl.pers_item_sign_validated_raw_tx,
          transl.desc_pers_item_sign_validated_raw_tx,
          signingMethod.bsRawSignedByIssuer,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.validatedTxHashesWithIssuerData,
          transl.pers_item_sign_validated_tx_hashes_with_iss_data,
          transl.desc_pers_item_sign_validated_tx_hashes_with_iss_data,
          signingMethod.bsHashSignedByIssuerAndUpdateIssuerData,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.validatedRawTxWithIssuerData,
          transl.pers_item_sign_validated_raw_tx_with_iss_data,
          transl.desc_pers_item_sign_validated_raw_tx_with_iss_data,
          signingMethod.bsRawSignedByIssuerAndUpdateIssuerData,
          initialData: false,
        ).withUnderline(),
        SwitchWidget(
          ItemName.externalHash,
          transl.pers_item_sign_hash_ex,
          transl.desc_pers_item_sign_hash_ex,
          signingMethod.bsExternalHash,
          initialData: false,
        ).gone(),
      ],
    ).visibilityHandler(bloc.statedFieldsVisibility);
  }
}
