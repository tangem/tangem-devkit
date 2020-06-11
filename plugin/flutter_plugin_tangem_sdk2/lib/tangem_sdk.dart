import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tangem_sdk/card_responses/card_response.dart';
import 'package:tangem_sdk/extensions.dart';

import 'card_responses/other_responses.dart';

/// Flutter TangemSdk is an interface which provides access to platform specific TangemSdk library.
/// The response from the successfully completed execution of the 'channel method' is expected in the json.
/// If an error occurs within the 'channel method', it is expected PlatformException converter to the json.
class TangemSdk {
  static const cScanCard = 'scanCard';
  static const cSign = 'sign';
  static const cPersonalize = 'personalize';
  static const cDepersonalize = 'depersonalize';
  static const cCreateWallet = 'createWallet';
  static const cPurgeWallet = 'purgeWallet';
  static const cReadIssuerData = 'readIssuerData';
  static const cWriteIssuerData = 'writeIssuerData';
  static const cReadIssuerExData = 'readIssuerExData';
  static const cWriteIssuerExData = 'writeIssuerExData';
  static const cReadUserData = 'readUserData';
  static const cWriteUserData = 'writeUserData';
  static const cWriteUserProtectedData = 'writeUserProtectedData';

  static const cid = "cid";
  static const initialMessage = "initialMessage";
  static const initialMessageHeader = "header";
  static const initialMessageBody = "body";
  static const hashesHex = "hashes";
  static const cardConfig = "cardConfig";
  static const issuer = "issuer";
  static const manufacturer = "manufacturer";
  static const acquirer = "acquirer";
  static const issuerDataHex = "issuerData";
  static const issuerDataCounter = "issuerDataCounter";
  static const issuerPrivateKeyHex = "issuerPrivateKey";
  static const userDataHex = "userData";
  static const userCounter = "userCounter";
  static const userProtectedDataHex = "userProtectedData";
  static const userProtectedCounter = "userProtectedCounter";

  static const MethodChannel _channel = const MethodChannel('tangemSdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future scanCard(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cScanCard, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cScanCard, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future sign(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cSign, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cSign, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future personalize(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cPersonalize, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cPersonalize, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future depersonalize(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cDepersonalize, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cDepersonalize, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future createWallet(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cCreateWallet, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cCreateWallet, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future purgeWallet(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cPurgeWallet, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cPurgeWallet, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readIssuerData(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cReadIssuerData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadIssuerData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeIssuerData(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cWriteIssuerData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteIssuerData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readUserData(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cReadUserData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadUserData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeUserData(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cWriteUserData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteUserData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future writeUserProtectedData(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cWriteUserProtectedData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cWriteUserData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  static Future readIssuerExData(Callback callback, [Map<String, dynamic> valuesToExport]) async {
    _channel
        .invokeMethod(cReadIssuerExData, valuesToExport)
        .then((result) => callback.onSuccess(_createResponse(cReadIssuerExData, result)))
        .catchError((error) => _sendBackError(callback, error));
  }

  /*
  readIssuerExtraData: function (callback, cid, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    exec(callback.success, callback.error, name, 'readIssuerExtraData', [valuesToExport]);
  },

  writeIssuerExtraData: function (callback, cid, issuerData, startingSignature, finalizingSignature, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    valuesToExport.issuerData = issuerData;
    valuesToExport.startingSignature = startingSignature;
    valuesToExport.finalizingSignature = finalizingSignature;
    valuesToExport.issuerDataCounter = optional.issuerDataCounter;

    exec(callback.success, callback.error, name, 'writeIssuerExtraData', [valuesToExport]);
  },



  writeUserData: function (callback, cid, userData, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    valuesToExport.userData = userData;
    valuesToExport.userCounter = optional.userCounter;

    exec(callback.success, callback.error, name, 'writeUserData', [valuesToExport]);
  },

  writeUserProtectedData: function (callback, cid, userProtectedData, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    valuesToExport.userProtectedData = userProtectedData;
    valuesToExport.userProtectedCounter = optional.userProtectedCounter;

    exec(callback.success, callback.error, name, 'writeUserProtectedData', [valuesToExport]);
  },

  createWallet: function (callback, cid, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    exec(callback.success, callback.error, name, 'createWallet', [valuesToExport]);
  },

  purgeWallet: function (callback, cid, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    exec(callback.success, callback.error, name, 'purgeWallet', [valuesToExport]);
  }
   */

  static dynamic _createResponse(String name, dynamic response) {
    print("onSuccess: $name with response: $response");
    final jsonResponse = jsonDecode(response);

    switch (name) {
      case cScanCard:
        return CardResponse.fromJson(jsonResponse);
      case cSign:
        return SignResponse.fromJson(jsonResponse);
      case cPersonalize:
        return CardResponse.fromJson(jsonResponse);
      case cDepersonalize:
        return DepersonalizeResponse.fromJson(jsonResponse);
      case cCreateWallet:
        return CreateWalletResponse.fromJson(jsonResponse);
      case cPurgeWallet:
        return PurgeWalletResponse.fromJson(jsonResponse);
      case cReadIssuerData:
        return ReadIssuerDataResponse.fromJson(jsonResponse);
      case cWriteIssuerData:
        return WriteIssuerDataResponse.fromJson(jsonResponse);
      case cReadIssuerExData:
        return ReadIssuerExDataResponse.fromJson(jsonResponse);


      case cReadUserData:
        return ReadUserDataResponse.fromJson(jsonResponse);
      case cWriteUserData:
        return WriteUserDataResponse.fromJson(jsonResponse);
      case cWriteUserProtectedData:
        return WriteUserDataResponse.fromJson(jsonResponse);
    }
    return response;
  }

  static _sendBackError(Callback callback, PlatformException ex) {
    final error = ErrorResponse.fromException(ex);
    print("onError: $error");
    callback.onError(error);
  }
}

class Callback {
  final Function(dynamic success) onSuccess;
  final Function(dynamic error) onError;

  Callback(this.onSuccess, this.onError);
}

class Issuer {
  static final String dataPublic =
      "045f16bd1d2eafe463e62a335a09e6b2bbcbd04452526885cb679fc4d27af1bd22f553c7deefb54fd3d4f361d14e6dc3f11b7d4ea183250a60720ebdf9e110cd26";
  static final String dataPrivate = "11121314151617184771ED81F2BACF57479E4735EB1405083927372D40DA9E92";

  static final String transPublic =
      "0484c5192e9bfa6c528a344f442137a92b89ea835bfef1d04cb4362eb906b508c5889846cfea71ba6dc7b3120c2208df9c46127d3d85cb5cfbd1479e97133a39d8";
  static final String transPrivate = "11121314151617184771ED81F2BACF57479E4735EB1405081918171615141312";

  final String name;
  final String id;
  final KeyPair dataKeyPair;
  final KeyPair transactionKeyPair;

  Issuer(this.name, this.id, this.dataKeyPair, this.transactionKeyPair);

  factory Issuer.def() {
    final name = "Tangem SDK";
    return Issuer(
      name,
      name + "\u0000",
      KeyPair(dataPublic.hexToBytes(), dataPrivate.hexToBytes()),
      KeyPair(transPublic.hexToBytes(), transPrivate.hexToBytes()),
    );
  }

  factory Issuer.fromJson(Map<String, dynamic> json) {
    return Issuer(
      json["name"],
      json["id"],
      KeyPair.fromJson(json["dataKeyPair"]),
      KeyPair.fromJson(json["transactionKeyPair"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "id": id, "dataKeyPair": dataKeyPair.toJson(), "transactionKeyPair": transactionKeyPair.toJson()};
  }
}

class Acquirer {
  static final publicKey =
      "0456ad1a82b22bcb40c38fd08939f87e6b80e40dec5b3bdb351c55fcd709e47f9fb2ed00c2304d3a986f79c5ae0ac3c84e88da46dc8f513b7542c716af8c9a2daf";
  static final privateKey = "21222324252627284771ED81F2BACF57479E4735EB1405083927372D40DA9E92";

  final String name;
  final String id;
  final KeyPair keyPair;

  Acquirer(this.name, this.id, this.keyPair);

  factory Acquirer.def() {
    final name = "Smart Cash";
    return Acquirer(
      name,
      name + "\u0000",
      KeyPair(publicKey.hexToBytes(), privateKey.hexToBytes()),
    );
  }

  factory Acquirer.fromJson(Map<String, dynamic> json) {
    return Acquirer(json["name"], json["id"], KeyPair.fromJson(json["keyPair"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "keyPair": keyPair.toJson(),
    };
  }
}

class Manufacturer {
  static final publicKey =
      "04bab86d56298c996f564a84fc88e28aed38184b12f07e519113bef48c76f3df3adc303599b08ac05b55ec3df98d9338573a6242f76f5d28f4f0f364e87e8fca2f";
  static final privateKey = "1b48cfd24bbb5b394771ed81f2bacf57479e4735eb1405083927372d40da9e92";

  final String name;
  final KeyPair keyPair;

  Manufacturer(this.name, this.keyPair);

  factory Manufacturer.def() => Manufacturer("Tangem", KeyPair(publicKey.hexToBytes(), privateKey.hexToBytes()));

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      json["name"],
      KeyPair.fromJson(json["keyPair"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "keyPair": keyPair.toJson(),
    };
  }
}

class KeyPair {
  final List<int> publicKey;
  final List<int> privateKey;

  KeyPair(this.publicKey, this.privateKey);

  factory KeyPair.fromJson(Map<String, dynamic> json) {
    return KeyPair(
      json["publicKey"],
      json["privateKey"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "publicKey": publicKey,
      "privateKey": privateKey,
    };
  }
}
