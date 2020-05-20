import 'dart:async';

import 'package:flutter/services.dart';

class TangemSdk {
  static const cid = "cid";
  static const initialMessage = "initialMessage";
  static const hashes = "hashes";
  static const _ = "";

  static const MethodChannel _channel = const MethodChannel('tangemSdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future scanCard(Callback callback) async {
    _channel.invokeMethod('scanCard').then((result) {
      callback.onSuccess(result);
    }).catchError((error) {
      callback.onError(error);
    });
  }

  static Future sign(Callback callback, String cid, List<String> listOfHexHashes, [Map<String, dynamic> optional]) async {
    final valuesToExport = _createExportingValues(optional, cid);
    valuesToExport[hashes] = listOfHexHashes;

    _channel.invokeMethod('sign', valuesToExport).then((result) {
      callback.onSuccess(result);
    }).catchError((error) {
      callback.onError(error);
    });
  }

  static Future depersonalize(Callback callback, String cid, Map<String, dynamic> optional) async {
    var valuesToExport = _createExportingValues(optional, cid);
    _channel.invokeMethod('depersonalize', valuesToExport).then((result) {
      callback.onSuccess(result);
    }).catchError((error) {
      callback.onError(error);
    });
  }

  /*

  readIssuerData: function (callback, cid, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    exec(callback.success, callback.error, name, 'readIssuerData', [valuesToExport]);
  },

  writeIssuerData: function (callback, cid, issuerData, issuerDataSignature, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    valuesToExport.issuerData = issuerData;
    valuesToExport.issuerDataSignature = issuerDataSignature;
    valuesToExport.issuerDataCounter = optional.issuerDataCounter;

    exec(callback.success, callback.error, name, 'writeIssuerData', [valuesToExport]);
  },

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

  readUserData: function (callback, cid, optional) {
    var valuesToExport = createExportingValues(optional, cid)
    exec(callback.success, callback.error, name, 'readUserData', [valuesToExport]);
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

  static Map<String, dynamic> _createExportingValues(Map<String, dynamic> optional, String optionalCid) {
    var valuesToExport = <String, dynamic>{};
    if (optionalCid != null) valuesToExport[cid] = optionalCid;
    if (optional == null) return valuesToExport;

    valuesToExport[initialMessage] = optional[initialMessage];
    return valuesToExport;
  }
}

typedef Success = Function(dynamic error);
typedef Error = Function(dynamic response);

class Callback {
  final Success onSuccess;
  final Error onError;

  Callback(this.onSuccess, this.onError);
}
