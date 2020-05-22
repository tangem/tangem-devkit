import 'dart:async';

import 'package:flutter/services.dart';

class TangemSdk {
  static const cid = "cid";
  static const initialMessage = "initialMessage";
  static const initialMessageHeader = "header";
  static const initialMessageBody = "body";
  static const hashes = "hashes";
  static const _ = "";

  static const MethodChannel _channel = const MethodChannel('tangemSdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future scanCard(Callback callback, [Map<String, dynamic> optional]) async {
    final valuesToExport = _createExportingValues(optional);
    _channel.invokeMethod('scanCard', valuesToExport).then((result) {
      callback.onSuccess(result);
    }).catchError((error) {
      callback.onError(error);
    });
  }

  static Future sign(Callback callback, List<String> listOfHexHashes, [Map<String, dynamic> optional]) async {
    final valuesToExport = _createExportingValues(optional);
    valuesToExport[hashes] = listOfHexHashes;

    _channel.invokeMethod('sign', valuesToExport).then((result) {
      callback.onSuccess(result);
    }).catchError((error) {
      callback.onError(error);
    });
  }

  static Future depersonalize(Callback callback, [Map<String, dynamic> optional]) async {
    var valuesToExport = _createExportingValues(optional);
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

  static Map<String, dynamic> _createExportingValues(Map<String, dynamic> optional) {
    var valuesToExport = <String, dynamic>{};
    if (optional == null || optional.isEmpty) return valuesToExport;

    valuesToExport[cid] = optional[cid];
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
