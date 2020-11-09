import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:devkit/app/domain/model/personalization/json.dart';
import 'package:intl/intl.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

import 'product_mask.dart';
import 'support_classes.dart';

class Utils {
  static String cardId = "BB03000000000004";

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

  static Issuer createDefaultIssuer() {
    final name = "TANGEM SDK";
    final dataPublic =
        "045f16bd1d2eafe463e62a335a09e6b2bbcbd04452526885cb679fc4d27af1bd22f553c7deefb54fd3d4f361d14e6dc3f11b7d4ea183250a60720ebdf9e110cd26";
    final dataPrivate = "11121314151617184771ED81F2BACF57479E4735EB1405083927372D40DA9E92";

    final transPublic =
        "0484c5192e9bfa6c528a344f442137a92b89ea835bfef1d04cb4362eb906b508c5889846cfea71ba6dc7b3120c2208df9c46127d3d85cb5cfbd1479e97133a39d8";
    final transPrivate = "11121314151617184771ED81F2BACF57479E4735EB1405081918171615141312";
    return Issuer(
      name,
      name + "\u0000",
      KeyPairHex(dataPublic, dataPrivate),
      KeyPairHex(transPublic, transPrivate),
    );
  }

  static Acquirer createDefaultAcquirer() {
    final name = "Smart Cash";
    final publicKey =
        "0456ad1a82b22bcb40c38fd08939f87e6b80e40dec5b3bdb351c55fcd709e47f9fb2ed00c2304d3a986f79c5ae0ac3c84e88da46dc8f513b7542c716af8c9a2daf";
    final privateKey = "21222324252627284771ED81F2BACF57479E4735EB1405083927372D40DA9E92";
    return Acquirer(
      name,
      name + "\u0000",
      KeyPairHex(publicKey, privateKey),
    );
  }

  static Manufacturer createDefaultManufacturer() {
    final publicKey =
        "04bab86d56298c996f564a84fc88e28aed38184b12f07e519113bef48c76f3df3adc303599b08ac05b55ec3df98d9338573a6242f76f5d28f4f0f364e87e8fca2f";
    final privateKey = "1b48cfd24bbb5b394771ed81f2bacf57479e4735eb1405083927372d40da9e92";
    return Manufacturer("Tangem", KeyPairHex(publicKey, privateKey));
  }
}

class CommandJsonTest {
  static String scan = "{\"commandType\":\"scanCard\"}";

  static String sign = '''{
      "commandType":"sign",
      "dataForHashing":[
        "some,data 1",
        "some data 2"
      ],
      "cid":"BB03000000000004",
      "initialMessage": {
        "body":"Body message",
        "header":"Header Message"
      }
  }''';

  static String depersonalize = "{\"commandType\":\"depersonalize\"}";
  static String createWallet = "{\"commandType\":\"createWallet\"}";
  static String purgeWallet = "{\"commandType\":\"purgeWallet\"}";

  static String readIssuerData = "{\"commandType\":\"readIssuerData\"}";
  static String writeIssuerData = '''{
      "cid":"${Utils.cardId}",
      "issuerData":"Some issuer data",
      "issuerDataCounter:1,
      "privateKey":"${Utils.createDefaultIssuer().dataKeyPair.privateKey}",
      "commandType":"writeIssuerData"
      }''';

  static String readIssuerExData = "{\"commandType\":\"readIssuerExData\"}";
  static String writeIssuerExData = '''{
      "cid":"${Utils.cardId}",
      "issuerData":"Some issuer extra data",
      "issuerDataCounter":1,"
      "privateKey":"${Utils.createDefaultIssuer().dataKeyPair.privateKey}",
      "commandType":"writeIssuerExData"
      }''';

  static String readUserData = "{\"commandType\":\"readUserData\"}";
  static String writeUserData = "{\"userData\":\"Some user data\",\"userCounter\":3,\"commandType\":\"writeUserData\"}";
  static String writeUserProtectedData =
      "{\"userProtectedData\":\"Some protected data\",\"userProtectedCounter\":3,\"commandType\":\"writeUserProtectedData\"}";

  static String personalize = '''{
    "config": ${DefaultPersonalizationJson.jsonString},
    "issuer":${jsonEncode(Utils.createDefaultIssuer().toJson())},
    "commandType":"${TangemSdk.cPersonalize}"
  }''';

  static String writeFilesPassCode = '''{
    "files": [
      {"fileData": "some file data 1"},
      {"fileData": "some file data 2"},
      {"fileData": "some file data 3"}
    ],
    "commandType":"writeFiles"
  }''';


  static String writeFilesIssuer = '''{
    "cid":"${Utils.cardId}",
    "issuer":${jsonEncode(Utils.createDefaultIssuer().toJson())},
    "files": [
      {
        "fileData": "some file data 1",
        "counter": 1
      },
      {
        "fileData": "some file data 2",
        "counter": 2
      },
      {
        "fileData": "some file data 3",
        "counter": 3
      }
    ],
    "commandType":"writeFiles"
  }''';

  static String readFiles = '''{
    "commandType":"readFiles"
  }''';

  static String readFiles2 = '''{
    "readPrivateFiles": false,
    "indices": [
      0
    ],
    "commandType":"readFiles"
  }''';

  static String deleteFiles = '''{
    "indices": [
      1
    ],
    "commandType":"deleteFiles"
  }''';

  static String deleteFiles2 = '''{
    "commandType":"deleteFiles"
  }''';

  static String changeFilesSettings = '''{
    "changes": [
      {
        "fileIndex": 0,
        "settings": "Public"
      },
      {
        "fileIndex": 1,
        "settings": "Private"
      }
    ],
    "commandType": "changeFilesSettings"
  }''';
}
