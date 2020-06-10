import 'package:devkit/app/resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';

import 'base_widgets.dart';

class SignResponseBody extends StatelessWidget {
  final SignResponse _response;

  const SignResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_sign_cid,
          value: _response.cardId,
          description: transl.desc_response_sign_cid,
        ),
        ResponseTextWidget(
          name: transl.response_sign_wallet_signed_hashes,
          value: _response.walletSignedHashes,
          description: transl.desc_response_sign_wallet_signed_hashes,
        ),
        ResponseTextWidget(
          name: transl.response_sign_wallet_remaining_signatures,
          value: _response.walletRemainingSignatures,
          description: transl.desc_response_sign_wallet_remaining_signatures,
        ),
        ResponseTextWidget(
          name: transl.response_sign_signature,
          value: _response.signature,
          description: transl.desc_response_sign_signature,
        ),
      ],
    );
  }
}

class DepersonalizeResponseBody extends StatelessWidget {
  final DepersonalizeResponse _response;

  const DepersonalizeResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return ResponseTextWidget(
      name: transl.response_depersonalize_is_success,
      value: _response.success,
      description: transl.desc_response_depersonalize_is_success,
    );
  }
}
