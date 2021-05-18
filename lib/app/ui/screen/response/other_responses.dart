import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
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
          transl.response_sign_cid,
          _response.cardId,
          transl.desc_response_sign_cid,
        ),
        ResponseTextWidget(
          transl.response_sign_wallet_signed_hashes,
          _response.walletSignedHashes,
          transl.desc_response_sign_wallet_signed_hashes,
        ),
        ResponseTextWidget(
          transl.response_sign_wallet_remaining_signatures,
          _response.walletRemainingSignatures,
          transl.desc_response_sign_wallet_remaining_signatures,
        ),
        ResponseTextWidget(
          transl.response_sign_signature,
          _response.signature,
          transl.desc_response_sign_signature,
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
      transl.response_depersonalize_is_success,
      _response.success,
      transl.desc_response_depersonalize_is_success,
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
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          transl.response_card_status,
          _response.status,
          transl.desc_response_card_wallet_public_key,
        ),
        ResponseTextWidget(
          transl.response_card_wallet_public_key,
          _response.walletPublicKey,
          transl.desc_response_card_wallet_public_key,
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
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          transl.response_card_status,
          _response.status,
          transl.desc_response_card_wallet_public_key,
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
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          transl.response_issuer_data,
          _response.issuerData.hexToString(),
          transl.desc_response_issuer_data,
        ),
        ResponseTextWidget(
          transl.response_issuer_data_signature,
          _response.issuerDataSignature,
          transl.desc_response_issuer_data_signature,
        ),
        ResponseTextWidget(
          transl.response_issuer_data_counter,
          _response.issuerDataCounter,
          transl.desc_response_issuer_data_counter,
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
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
      ],
    );
  }
}

class ReadIssuerExDataResponseBody extends StatelessWidget {
  final ReadIssuerExDataResponse _response;

  const ReadIssuerExDataResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ResponseTextWidget(
            transl.response_card_cid,
            _response.cardId,
            transl.desc_response_card_cid,
          ),
          ResponseTextWidget(
            transl.response_issuer_ex_data_size,
            _response.size,
            transl.desc_response_issuer_ex_data_size,
          ),
          ResponseTextWidget(
            transl.response_issuer_ex_data,
            _response.issuerData,
            transl.desc_response_issuer_ex_data,
          ),
          ResponseTextWidget(
            transl.response_issuer_ex_data_signature,
            _response.issuerDataSignature,
            transl.desc_response_issuer_ex_data_signature,
          ),
          ResponseTextWidget(
            transl.response_issuer_ex_data_counter,
            _response.issuerDataCounter,
            transl.desc_response_issuer_ex_data_counter,
          ),
        ],
      ),
    );
  }
}

class WriteIssuerExDataResponseBody extends StatelessWidget {
  final WriteIssuerExDataResponse _response;

  const WriteIssuerExDataResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return ResponseTextWidget(
      transl.card_id,
      _response.cardId,
      transl.desc_card_id,
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
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          transl.response_user_data,
          _response.userData.hexToString(),
          transl.desc_response_user_data,
        ),
        ResponseTextWidget(
          transl.response_user_data_counter,
          _response.userCounter,
          transl.desc_response_user_data_counter,
        ),
        ResponseTextWidget(
          transl.response_user_protected_data,
          _response.userProtectedData.hexToString(),
          transl.desc_response_user_protected_data,
        ),
        ResponseTextWidget(
          transl.response_user_data_protected_counter,
          _response.userProtectedCounter,
          transl.desc_response_user_data_protected_counter,
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
      transl.card_id,
      _response.cardId,
      transl.desc_card_id,
    );
  }
}

class SetPinResponseBody extends StatelessWidget {
  final SetPinResponse _response;

  const SetPinResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          transl.response_set_pin_status,
          _response.status,
          transl.desc_response_set_pin_status,
        ),
      ],
    );
  }
}

class WriteFilesResponseBody extends StatelessWidget {
  final WriteFilesResponse _response;

  WriteFilesResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        ResponseTextWidget(
          transl.response_card_cid,
          _response.cardId,
          transl.desc_response_card_cid,
        ),
        ResponseTextWidget(
          transl.response_files_write_index,
          _response.fileIndex,
          transl.response_files_write_index,
        ),
      ],
    );
  }
}

class ReadFilesResponseBody extends StatelessWidget {
  final ReadFilesResponse _response;

  ReadFilesResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    if (_response.files.isEmpty) {
      return ResponseTextWidget(
        "Files not found",
        "",
        "",
      );
    }
    final widgets = _response.files.map((e) {
      final fileSettings = e.fileSettings == null ? "" : enumToString(e.fileSettings!);
      return Column(
        children: [
          ResponseTextWidget(
            transl.response_file_index,
            e.fileIndex,
            transl.desc_response_file_index,
          ),
          ResponseTextWidget(
            transl.response_file_settings,
            fileSettings,
            transl.desc_response_file_settings,
          ),
          ResponseTextWidget(
            transl.response_file_data,
            e.fileData,
            transl.desc_response_file_data,
          ),
        ],
      );
    }).toList();
    return SingleChildScrollView(child: Column(children: widgets));
  }
}

class DeleteFilesResponseBody extends StatelessWidget {
  final DeleteFilesResponse _response;

  const DeleteFilesResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return ResponseTextWidget(
      transl.card_id,
      _response.cardId,
      transl.desc_card_id,
    );
  }
}

class ChangeFilesSettingsResponseBody extends StatelessWidget {
  final ChangeFilesSettingsResponse _response;

  const ChangeFilesSettingsResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return ResponseTextWidget(
      transl.card_id,
      _response.cardId,
      transl.desc_card_id,
    );
  }
}
