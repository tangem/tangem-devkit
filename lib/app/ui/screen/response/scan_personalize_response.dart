import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'base_widgets.dart';

class ReadResponseBody extends StatelessWidget {
  final CardResponse _card;

  ReadResponseBody(this._card);

  //TODO: contains incomplete information about the card
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          ResponseTextWidget(
            transl.response_card_cid,
            _card.cardId,
            transl.desc_response_card_cid,
          ),
          ResponseTextWidget(
            transl.response_card_manufacturer_name,
            _card.manufacturerName,
            transl.desc_response_card_manufacturer_name,
          ),
          ResponseTextWidget(
            transl.response_card_status,
            _card.status,
            transl.desc_response_card_status,
          ),
          ResponseTextWidget(
            transl.response_card_firmware_version,
            _card.firmwareVersion.version,
            transl.desc_response_card_firmware_version,
          ),
          ResponseTextWidget(
            transl.response_card_public_key,
            _card.cardPublicKey,
            transl.desc_response_card_public_key,
          ),
          ResponseTextWidget(
            transl.response_card_issuer_data_public_key,
            _card.issuerPublicKey,
            transl.desc_response_card_issuer_data_public_key,
          ),
          ResponseTextWidget(
            transl.response_card_curve,
            _card.defaultCurve,
            transl.desc_response_card_curve,
          ),
          // ResponseTextWidget(
          //   transl.response_card_max_signatures,
          //   _card.maxSignatures,
          //   transl.desc_response_card_max_signatures,
          // ),
          ResponseTextWidget(
            transl.response_card_pause_before_pin2,
            _card.pauseBeforePin2,
            transl.desc_response_card_pause_before_pin2,
          ),
          // ResponseTextWidget(
          //   transl.response_card_wallet_public_key,
          //   _card.walletPublicKey,
          //   transl.desc_response_card_wallet_public_key,
          // ),
          // ResponseTextWidget(
          //   transl.response_card_wallet_remaining_signatures,
          //   _card.walletRemainingSignatures,
          //   transl.desc_response_card_wallet_remaining_signatures,
          // ),
          // ResponseTextWidget(
          //   transl.response_card_wallet_signed_hashes,
          //   _card.walletSignedHashes,
          //   transl.desc_response_card_wallet_signed_hashes,
          // ),
          ResponseTextWidget(
            transl.response_card_health,
            _card.health,
            transl.desc_response_card_health,
          ),
          ResponseTextWidget(
            transl.response_card_is_activated,
            _card.isActivated,
            transl.desc_response_card_is_activated,
          ),
          SigningMethodsResponseWidget(_card),
          CardDataResponseWidget(_card.cardData),
          // ProductMaskResponseWidget(_card.cardData),
          SettingsMaskResponseWidget(_card),
        ],
      ),
    );
  }
}

class CardDataResponseWidget extends StatelessWidget {
  final CardData? _cardData;
  final Color _color = AppColor.responseCardData;

  CardDataResponseWidget(this._cardData);

  @override
  Widget build(BuildContext context) {
    if (_cardData == null) return StubWidget();

    final cardData = _cardData!;
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        SegmentHeader(transl.response_card_card_data, description: transl.desc_response_card_card_data),
        ResponseTextWidget(
          transl.response_card_card_data_batch_id,
          cardData.batchId,
          transl.desc_response_card_card_data_batch_id,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_manufacture_date_time,
          cardData.manufactureDateTime,
          transl.desc_response_card_card_data_manufacture_date_time,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_issuer_name,
          cardData.issuerName,
          transl.desc_response_card_card_data_issuer_name,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_blockchain_name,
          cardData.blockchainName,
          transl.desc_response_card_card_data_blockchain_name,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_manufacturer_signature,
          cardData.manufacturerSignature,
          transl.desc_response_card_card_data_manufacturer_signature,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_token_symbol,
          cardData.tokenSymbol,
          transl.desc_response_card_card_data_token_symbol,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_token_contract_address,
          cardData.tokenContractAddress,
          transl.desc_response_card_card_data_token_contract_address,
          bgColor: _color,
        ),
        ResponseTextWidget(
          transl.response_card_card_data_token_decimal,
          cardData.tokenDecimal,
          transl.desc_response_card_card_data_token_decimal,
          bgColor: _color,
        ),
      ],
    );
  }
}

class SigningMethodsResponseWidget extends StatelessWidget {
  final CardResponse _card;

  SigningMethodsResponseWidget(this._card);

  @override
  Widget build(BuildContext context) {
    if (_card.signingMethods == null) return StubWidget();

    final transl = Transl.of(context);
    List<Widget> widgets = [];
    widgets.add(
      SegmentHeader(
        transl.response_card_signing_method,
        description: transl.desc_response_card_signing_method,
      ),
    );
    SigningMethod.values.enumToStringList().forEach((element) {
      widgets.add(ResponseCheckboxWidget(element, _card.signingMethods!.contains(element)));
    });
    return Column(children: widgets);
  }
}

class ProductMaskResponseWidget extends StatelessWidget {
  final CardData? _cardData;
  final Color _color = AppColor.responseProductMask;

  final _productMaskList = [
    "Note",
    "Tag",
    "IdCard",
    "IdIssuer",
    "TwinCard",
  ];

  ProductMaskResponseWidget(this._cardData);

  @override
  Widget build(BuildContext context) {
    if (_cardData == null || _cardData!.productMask == null) return StubWidget();

    final productMask = _cardData!.productMask!;
    final transl = Transl.of(context);
    List<Widget> widgets = [];
    widgets.add(
      SegmentHeader(
        transl.response_card_card_data_product_mask,
        description: transl.desc_response_card_card_data_product_mask,
      ),
    );

    _productMaskList.forEach((element) {
      widgets.add(ResponseCheckboxWidget(element, productMask.contains(element), bgColor: _color));
    });
    return Column(children: widgets);
  }
}

class SettingsMaskResponseWidget extends StatelessWidget {
  final CardResponse _card;
  final Color _color = AppColor.responseSettingsMask;

  final _settingsMaskList = [
    "IsReusable",
    "UseActivation",
    "ProhibitPurgeWallet",
    "UseBlock",
    "AllowSetPIN1",
    "AllowSetPIN2",
    "UseCvc",
    "ProhibitDefaultPIN1",
    "UseOneCommandAtTime",
    "UseNDEF",
    "UseDynamicNDEF",
    "SmartSecurityDelay",
    "AllowUnencrypted",
    "AllowFastEncryption",
    "ProtectIssuerDataAgainstReplay",
    "RestrictOverwriteIssuerExtraData",
    "AllowSelectBlockchain",
    "DisablePrecomputedNDEF",
    "SkipSecurityDelayIfValidatedByLinkedTerminal",
    "SkipCheckPIN2CVCIfValidatedByIssuer",
    "SkipSecurityDelayIfValidatedByIssuer",
    "RequireTermTxSignature",
    "RequireTermCertSignature",
    "CheckPIN3OnCard",
  ];

  SettingsMaskResponseWidget(this._card);

  @override
  Widget build(BuildContext context) {
    if (_card.settingsMask == null) return StubWidget();

    final transl = Transl.of(context);
    List<Widget> widgets = [];
    widgets.add(
      SegmentHeader(
        transl.response_card_settings_mask,
        description: transl.desc_response_card_settings_mask,
      ),
    );
    _settingsMaskList.forEach((element) {
      widgets.add(ResponseCheckboxWidget(element, _card.settingsMask!.contains(element), bgColor: _color));
    });
    return Column(children: widgets);
  }
}
