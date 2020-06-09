import 'package:tangem_sdk/model/sdk.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'product_mask.dart';
import 'support_classes.dart';

class Utils {

  static CardDataSdk createCardDataSdk(PersonalizationConfig config, Issuer issuer) {
    final cardData = config.cardData;
    cardData.date = cardData.date != null && cardData.date.isEmpty ? null : cardData.date;
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

  static CardConfigSdk createCardConfig(PersonalizationConfig config, Issuer issuer, Acquirer acquirer) {
    return CardConfigSdk(
      issuerName: issuer.name,
      acquirerName: acquirer.name,
      series: config.series,
      startNumber: config.startNumber,
      count: config.count,
      pin: config.PIN,
      pin2: config.PIN2,
      pin3: config.PIN3,
      hexCrExKey: config.hexCrExKey,
      cvc: config.CVC,
      pauseBeforePin2: config.pauseBeforePIN2,
      smartSecurityDelay: config.smartSecurityDelay,
      curveID: config.curveID,
      signingMethods: SigningMethodMaskSdk(config.SigningMethod),
      maxSignatures: config.MaxSignatures,
      isReusable: config.isReusable,
      allowSwapPin: config.allowSwapPIN,
      allowSwapPin2: config.allowSwapPIN2,
      useActivation: config.useActivation,
      useCvc: config.useCVC,
      useNdef: config.useNDEF,
      useDynamicNdef: config.useDynamicNDEF,
      useOneCommandAtTime: config.useOneCommandAtTime,
      useBlock: config.useBlock,
      allowSelectBlockchain: config.allowSelectBlockchain,
      forbidPurgeWallet: config.forbidPurgeWallet,
      protocolAllowUnencrypted: config.protocolAllowUnencrypted,
      protocolAllowStaticEncryption: config.protocolAllowStaticEncryption,
      protectIssuerDataAgainstReplay: config.protectIssuerDataAgainstReplay,
      forbidDefaultPin: config.forbidDefaultPIN,
      disablePrecomputedNdef: config.disablePrecomputedNDEF,
      skipSecurityDelayIfValidatedByIssuer: config.skipSecurityDelayIfValidatedByIssuer,
      skipCheckPIN2andCVCIfValidatedByIssuer: config.skipCheckPIN2andCVCIfValidatedByIssuer,
      skipSecurityDelayIfValidatedByLinkedTerminal: config.skipSecurityDelayIfValidatedByLinkedTerminal,
      restrictOverwriteIssuerDataEx: config.restrictOverwriteIssuerDataEx,
      requireTerminalTxSignature: config.requireTerminalTxSignature,
      requireTerminalCertSignature: config.requireTerminalCertSignature,
      checkPin3onCard: config.checkPIN3onCard,
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
