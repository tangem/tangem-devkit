import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:devkit/app/domain/model/personalization/json.dart';
import 'package:devkit/app/domain/model/personalization/support_classes.dart';
import 'package:intl/intl.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class Utils {
  static String cardId = "BB03000000000004";

  static CardData createCardData(PersonalizationConfig config, Issuer issuer) {
    final cardData = config.cardData;
    final date = cardData.date.isNullOrEmpty() ? _createCardDate() : cardData.date!;
    return CardData(
      cardData.batch,
      cardData.blockchain,
      issuer.name,
      null,
      date,
      createProductMask(config),
      tokenSymbol: cardData.tokenSymbol,
      tokenContractAddress: cardData.tokenContractAddress,
      tokenDecimal: cardData.tokenDecimal,
    );
  }

  static String _createCardDate() => DateFormat("yyyy-MM-dd").format(DateTime.now());

  static List<String>? createProductMask(PersonalizationConfig config) {
    final productMaskList = <Product>[];
    if (config.cardData.productNote) productMaskList.add(Product.Note);
    if (config.cardData.productTag) productMaskList.add(Product.Tag);
    if (config.cardData.productIdCard) productMaskList.add(Product.IdCard);
    if (config.cardData.productIdIssuer) productMaskList.add(Product.IdIssuer);
    if (config.cardData.productTwinCard) productMaskList.add(Product.TwinCard);

    return productMaskList.enumToStringList();
  }

  static Map<String, dynamic> createPersonalizationCommandConfig(
    PersonalizationConfig config, [
    Issuer? issuer,
    Acquirer? acquirer,
    Manufacturer? manufacturer,
  ]) {
    final safeIssuer = issuer ?? createDefaultIssuer();
    final safeAcquirer = acquirer ?? createDefaultAcquirer();
    final safeManufacturer = manufacturer ?? createDefaultManufacturer();
    return {
      TangemSdk.cardConfig: createCardConfig(config, safeIssuer, safeAcquirer).toJson(),
      TangemSdk.issuer: safeIssuer.toJson(),
      TangemSdk.acquirer: safeAcquirer.toJson(),
      TangemSdk.manufacturer: safeManufacturer.toJson(),
    };
  }

  static CardConfigSdk createCardConfig(PersonalizationConfig config, Issuer issuer, Acquirer acquirer) {
    List<int> convertToSha256(String code) {
      return sha256.convert(utf8.encode(code)).bytes;
    }

    return CardConfigSdk(
      config.PIN,
      config.PIN2,
      config.PIN3,
      config.hexCrExKey,
      config.CVC,
      config.pauseBeforePIN2,
      config.smartSecurityDelay,
      config.curveID,
      config.SigningMethod.toList().enumToStringList(),
      config.MaxSignatures,
      config.isReusable,
      config.allowSetPIN1,
      config.allowSetPIN2,
      config.useActivation,
      config.useCvc,
      config.useNDEF,
      config.useDynamicNDEF,
      config.useOneCommandAtTime,
      config.useBlock,
      config.allowSelectBlockchain,
      config.prohibitPurgeWallet,
      config.allowUnencrypted,
      config.allowFastEncryption,
      config.protectIssuerDataAgainstReplay,
      config.prohibitDefaultPIN1,
      config.disablePrecomputedNDEF,
      config.skipSecurityDelayIfValidatedByIssuer,
      config.skipCheckPIN2CVCIfValidatedByIssuer,
      config.skipSecurityDelayIfValidatedByLinkedTerminal,
      config.restrictOverwriteIssuerExtraData,
      config.requireTerminalTxSignature,
      config.requireTerminalCertSignature,
      config.checkPIN3OnCard,
      config.createWallet == 1,
      config.walletsCount,
      createCardData(config, issuer),
      config.ndef,
      issuerName: issuer.name,
      acquirerName: acquirer.name,
      series: config.series,
      startNumber: config.startNumber,
      count: config.count,
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
      "cardId":"BB03000000000004",
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
      "cardId":"${Utils.cardId}",
      "issuerData":"Some issuer data",
      "issuerDataCounter:1,
      "privateKey":"${Utils.createDefaultIssuer().dataKeyPair.privateKey}",
      "commandType":"writeIssuerData"
      }''';

  static String readIssuerExData = "{\"commandType\":\"readIssuerExData\"}";
  static String writeIssuerExData = '''{
      "cardId":"${Utils.cardId}",
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
    "cardId":"${Utils.cardId}",
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
