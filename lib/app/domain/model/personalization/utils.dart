import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tangem_sdk/model/sdk.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'product_mask.dart';
import 'support_classes.dart';

class Utils {
  static CardDataSdk createCardDataSdk(PersonalizationConfig config, Issuer issuer) {
    final cardData = config.cardData;
    cardData.date = cardData.date != null && cardData.date.isEmpty ? _createCardDate() : cardData.date;
    return CardDataSdk(
      productMask: createProductMask(config),
      issuerName: issuer.name,
      batchId: cardData.batch,
      blockchainName: cardData.blockchain,
      manufactureDateTime: cardData.date,
      tokenSymbol: cardData.tokenSymbol,
      tokenContractAddress: cardData.tokenContractAddress,
      tokenDecimal: cardData.tokenDecimal,
      manufacturerSignature: null,
    );
  }

  static String _createCardDate() => DateFormat("yyyy-MM-dd").format(DateTime.now());

  static CardConfigSdk createCardConfig(PersonalizationConfig config, Issuer issuer, Acquirer acquirer) {
    List<int> convertToSha256(String code) {
      return sha256.convert(utf8.encode(code)).bytes;
    }

    return CardConfigSdk(
      issuerName: issuer.name,
      acquirerName: acquirer.name,
      series: config.series,
      startNumber: config.startNumber,
      count: config.count,
      pin: convertToSha256(config.PIN),
      pin2: convertToSha256(config.PIN2),
      pin3: convertToSha256(config.PIN3),
      hexCrExKey: config.hexCrExKey,
      cvc: config.CVC,
      pauseBeforePin2: config.pauseBeforePIN2,
      smartSecurityDelay: config.smartSecurityDelay,
      curveID: config.curveID,
      signingMethods: SigningMethodMaskSdk(config.SigningMethod),
      maxSignatures: config.MaxSignatures,
      isReusable: config.isReusable,
      allowSetPIN1: config.allowSetPIN1,
      allowSetPIN2: config.allowSetPIN2,
      useActivation: config.useActivation,
      useCvc: config.useCvc,
      useNDEF: config.useNDEF,
      useDynamicNDEF: config.useDynamicNDEF,
      useOneCommandAtTime: config.useOneCommandAtTime,
      useBlock: config.useBlock,
      allowSelectBlockchain: config.allowSelectBlockchain,
      prohibitPurgeWallet: config.prohibitPurgeWallet,
      allowUnencrypted: config.allowUnencrypted,
      allowFastEncryption: config.allowFastEncryption,
      protectIssuerDataAgainstReplay: config.protectIssuerDataAgainstReplay,
      prohibitDefaultPIN1: config.prohibitDefaultPIN1,
      disablePrecomputedNDEF: config.disablePrecomputedNDEF,
      skipSecurityDelayIfValidatedByIssuer: config.skipSecurityDelayIfValidatedByIssuer,
      skipCheckPIN2CVCIfValidatedByIssuer: config.skipCheckPIN2CVCIfValidatedByIssuer,
      skipSecurityDelayIfValidatedByLinkedTerminal: config.skipSecurityDelayIfValidatedByLinkedTerminal,
      restrictOverwriteIssuerExtraData: config.restrictOverwriteIssuerExtraData,
      requireTerminalTxSignature: config.requireTerminalTxSignature,
      requireTerminalCertSignature: config.requireTerminalCertSignature,
      checkPIN3OnCard: config.checkPIN3OnCard,
      createWallet: config.createWallet == 1,
      cardData: createCardDataSdk(config, issuer),
      ndefRecords: config.ndef,
    );
  }

  static ProductMaskSdk createProductMask(PersonalizationConfig config) {
    final isNote = config.cardData.productNote;
    final isTag = config.cardData.productTag;
    final isIdCard = config.cardData.productIdCard;
    final isIdIssuer = config.cardData.productIdIssuer;

    final productMaskBuilder = ProductMaskBuilder();
    if (isNote) productMaskBuilder.add(Product.Note);
    if (isTag) productMaskBuilder.add(Product.Tag);
    if (isIdCard) productMaskBuilder.add(Product.IdCard);
    if (isIdIssuer) productMaskBuilder.add(Product.IdIssuer);
    return productMaskBuilder.build();
  }
}
