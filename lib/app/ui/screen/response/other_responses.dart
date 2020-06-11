import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
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

class CreateWalletResponseBody extends StatelessWidget {
  final CreateWalletResponse _response;

  const CreateWalletResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_card_cid,
          value: _response.cardId,
          description: transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          name: transl.response_card_status,
          value: _response.status,
          description: transl.desc_response_card_wallet_public_key,
        ),
        ResponseTextWidget(
          name: transl.response_card_wallet_public_key,
          value: _response.walletPublicKey,
          description: transl.desc_response_card_wallet_public_key,
        ),
      ],
    );
  }
}

class PurgeWalletResponseBody extends StatelessWidget {
  final PurgeWalletResponse _response;

  const PurgeWalletResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_card_cid,
          value: _response.cardId,
          description: transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          name: transl.response_card_status,
          value: _response.status,
          description: transl.desc_response_card_wallet_public_key,
        ),
      ],
    );
  }
}

class ReadIssuerDataResponseBody extends StatelessWidget {
  final ReadIssuerDataResponse _response;

  const ReadIssuerDataResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_card_cid,
          value: _response.cardId,
          description: transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          name: transl.response_issuer_data,
          value: _response.issuerData.hexToString(),
          description: transl.desc_response_issuer_data,
        ),
        ResponseTextWidget(
          name: transl.response_issuer_data_signature,
          value: _response.issuerDataSignature,
          description: transl.desc_response_issuer_data_signature,
        ),
        ResponseTextWidget(
          name: transl.response_issuer_data_counter,
          value: _response.issuerDataCounter,
          description: transl.desc_response_issuer_data_counter,
        ),
      ],
    );
  }
}

class WriteIssuerDataResponseBody extends StatelessWidget {
  final WriteIssuerDataResponse _response;

  const WriteIssuerDataResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_card_cid,
          value: _response.cardId,
          description: transl.desc_response_card_cid,
        ),
      ],
    );
  }
}

class ReadUserDataResponseBody extends StatelessWidget {
  final ReadUserDataResponse _response;

  const ReadUserDataResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_card_cid,
          value: _response.cardId,
          description: transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          name: transl.response_user_data,
          value: _response.userData.hexToString(),
          description: transl.desc_response_user_data,
        ),
        ResponseTextWidget(
          name: transl.response_user_data_counter,
          value: _response.userCounter,
          description: transl.desc_response_user_data_counter,
        ),
        ResponseTextWidget(
          name: transl.response_user_protected_data,
          value: _response.userProtectedData.hexToString(),
          description: transl.desc_response_user_protected_data,
        ),
        ResponseTextWidget(
          name: transl.response_user_data_protected_counter,
          value: _response.userProtectedCounter,
          description: transl.desc_response_user_data_protected_counter,
        ),
      ],
    );
  }
}

class WriteUserDataResponseBody extends StatelessWidget {
  final WriteUserDataResponse _response;

  const WriteUserDataResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return ResponseTextWidget(
      name: transl.card_id,
      value: _response.cardId,
      description: transl.desc_card_id,
    );
  }
}
