import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';

import 'base_widgets.dart';

class SuccessResponseBody extends StatelessWidget {
  final SuccessResponse _response;

  const SuccessResponseBody(this._response);

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

class SignResponseBody extends StatelessWidget {
  final SignResponse _response;

  const SignResponseBody(this._response);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: _response.signatures
          .map((hash) => ResponseTextWidget(transl.response_sign_signature, hash, transl.desc_response_sign_signature))
          .toList(),
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
        // ResponseTextWidget(
        //   transl.response_card_status,
        //   _response.status,
        //   transl.desc_response_card_wallet_public_key,
        // ),
        ResponseTextWidget(
          transl.response_card_wallet_public_key,
          _response.wallet,
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

class ReadIssuerExDataResponseBody extends StatelessWidget {
  final ReadIssuerExtraDataResponse _response;

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
          transl.response_files_write_indices,
          _response.fileIndices.join(", ").wrapBrackets(),
          transl.response_files_write_indices,
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
      final fileSettings = e.fileSettings == null ? "" : describeEnum(e.fileSettings!);
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
