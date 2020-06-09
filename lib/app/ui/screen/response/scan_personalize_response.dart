import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';

import 'base_widgets.dart';

class ReadResponseBody extends StatelessWidget {
  final CardResponse _card;

  ReadResponseBody(this._card);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          ResponseTextWidget(
            name: transl.response_card_cid,
            value: _card.cardId,
            description: transl.desc_response_card_cid,
          ),
          ResponseTextWidget(
            name: transl.response_card_manufacturer_name,
            value: _card.manufacturerName,
            description: transl.desc_response_card_manufacturer_name,
          ),
          ResponseTextWidget(
            name: transl.response_card_status,
            value: _card.status,
            description: transl.desc_response_card_status,
          ),
          ResponseTextWidget(
            name: transl.response_card_firmware_version,
            value: _card.firmwareVersion,
            description: transl.desc_response_card_firmware_version,
          ),
          ResponseTextWidget(
            name: transl.response_card_public_key,
            value: _card.cardPublicKey,
            description: transl.desc_response_card_public_key,
          ),
          ResponseTextWidget(
            name: transl.response_card_issuer_data_public_key,
            value: _card.issuerPublicKey,
            description: transl.desc_response_card_issuer_data_public_key,
          ),
          ResponseTextWidget(
            name: transl.response_card_curve,
            value: _card.curve,
            description: transl.desc_response_card_curve,
          ),
          ResponseTextWidget(
            name: transl.response_card_max_signatures,
            value: _card.maxSignatures,
            description: transl.desc_response_card_max_signatures,
          ),
          ResponseTextWidget(
            name: transl.response_card_pause_before_pin2,
            value: _card.pauseBeforePin2,
            description: transl.desc_response_card_pause_before_pin2,
          ),
          ResponseTextWidget(
            name: transl.response_card_health,
            value: _card.health,
            description: transl.desc_response_card_health,
          ),
          ResponseTextWidget(
            name: transl.response_card_is_activated,
            value: _card.isActivated,
            description: transl.desc_response_card_is_activated,
          ),
          SegmentHeader(transl.response_card_signing_method, description: transl.desc_response_card_signing_method),
          SigningMethodsResponseWidget(_card),
          SegmentHeader(transl.response_card_card_data, description: transl.desc_response_card_card_data),
          CardDataResponseWidget(_card.cardData),
          SegmentHeader(transl.response_card_card_data_product_mask, description: transl.desc_response_card_card_data_product_mask),
          ProductMaskResponseWidget(_card.cardData),
          SegmentHeader(transl.response_card_settings_mask, description: transl.desc_response_card_settings_mask),
          SettingsMaskResponseWidget(_card),
        ],
      ),
    );
  }
}

class CardDataResponseWidget extends StatelessWidget {
  final CardDataResponse _cardData;
  final Color _color = AppColor.responseCardData;

  CardDataResponseWidget(this._cardData);

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);

    return Column(
      children: <Widget>[
        ResponseTextWidget(
          name: transl.response_card_card_data_batch_id,
          value: _cardData.batchId,
          description: transl.desc_response_card_card_data_batch_id,
          bgColor: _color,
        ),
        ResponseTextWidget(
          name: transl.response_card_card_data_issuer_name,
          value: _cardData.issuerName,
          description: transl.desc_response_card_card_data_issuer_name,
          bgColor: _color,
        ),
        ResponseTextWidget(
          name: transl.response_card_card_data_blockchain_name,
          value: _cardData.blockchainName,
          description: transl.desc_response_card_card_data_blockchain_name,
          bgColor: _color,
        ),
        ResponseTextWidget(
          name: transl.response_card_card_data_manufacturer_signature,
          value: _cardData.manufacturerSignature,
          description: transl.desc_response_card_card_data_manufacturer_signature,
          bgColor: _color,
        ),
        ResponseTextWidget(
          name: transl.response_card_card_data_token_symbol,
          value: _cardData.tokenSymbol,
          description: transl.desc_response_card_card_data_token_symbol,
          bgColor: _color,
        ),
        ResponseTextWidget(
          name: transl.response_card_card_data_token_contract_address,
          value: _cardData.tokenContractAddress,
          description: transl.desc_response_card_card_data_token_contract_address,
          bgColor: _color,
        ),
        ResponseTextWidget(
          name: transl.response_card_card_data_token_decimal,
          value: _cardData.tokenDecimal,
          description: transl.desc_response_card_card_data_token_decimal,
          bgColor: _color,
        ),
      ],
    );
  }
}

class SigningMethodsResponseWidget extends StatelessWidget {
  final CardResponse _card;
  final _signingMethods = [
    "SignHash",
    "SignRaw",
    "SignHashValidateByIssuer",
    "SignRawValidateByIssuer",
    "SignHashValidateByIssuerWriteIssuerData",
    "SignRawValidateByIssuerWriteIssuerData",
    "SignPos",
  ];

  SigningMethodsResponseWidget(this._card);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _signingMethods.map((method) => ResponseCheckboxWidget(name: method, value: _card.signingMethods.contains(method))).toList(),
    );
  }
}

class ProductMaskResponseWidget extends StatelessWidget {
  final CardDataResponse _cardData;
  final Color _color = AppColor.responseProductMask;

  final _productMaskList = [
    "Note",
    "Tag",
    "IdCard",
    "IdIssuer",
  ];

  ProductMaskResponseWidget(this._cardData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _productMaskList
          .map((method) => ResponseCheckboxWidget(
                name: method,
                value: _cardData.productMask.contains(method),
                bgColor: _color,
              ))
          .toList(),
    );
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
    "AllowSwapPIN",
    "AllowSwapPIN2",
    "UseCVC",
    "ForbidDefaultPIN",
    "UseOneCommandAtTime",
    "UseNdef",
    "UseDynamicNdef",
    "SmartSecurityDelay",
    "ProtocolAllowUnencrypted",
    "ProtocolAllowStaticEncryption",
    "ProtectIssuerDataAgainstReplay",
    "RestrictOverwriteIssuerDataEx",
    "AllowSelectBlockchain",
    "DisablePrecomputedNdef",
    "SkipSecurityDelayIfValidatedByLinkedTerminal",
    "SkipSecurityDelayIfValidatedByIssuer",
    "SkipCheckPin2andCvcIfValidatedByIssuer",
    "RequireTermTxSignature",
    "RequireTermCertSignature",
    "CheckPIN3onCard",
  ];

  SettingsMaskResponseWidget(this._card);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _settingsMaskList
          .map((method) => ResponseCheckboxWidget(
                name: method,
                value: _card.settingsMask.contains(method),
                bgColor: _color,
              ))
          .toList(),
    );
  }
}
