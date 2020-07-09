import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/card_responses/other_responses.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class ReadIssuerDataBloc extends ActionBloc<ReadIssuerDataResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  ReadIssuerDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.readIssuerData(callback, {TangemSdk.cid: _cid});
  }
}

class ReadIssuerExDataBloc extends ActionBloc<ReadIssuerExDataResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  ReadIssuerExDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.readIssuerExData(callback, {TangemSdk.cid: _cid});
  }
}

class WriteIssuerDataBloc extends ActionBloc<WriteIssuerDataResponse> {
  final bsIssuerData = BehaviorSubject<String>();
  final bsIssuerDataCounter = BehaviorSubject<String>();

  String _cid;
  String _issuerData;
  int _issuerDataCounter;

  WriteIssuerDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
    subscriptions.add(bsIssuerData.stream.listen((event) => _issuerData = event));
    subscriptions.add(bsIssuerDataCounter.stream.listen((event) => _issuerDataCounter = event.isEmpty ? null : int.parse(event)));
    bsIssuerData.add("Data to be written on a card as issuer data");
    bsIssuerDataCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeIssuerData(callback, {
      TangemSdk.cid: _cid,
      TangemSdk.issuerDataHex: _issuerData.toHexString(),
      TangemSdk.issuerPrivateKeyHex: Issuer.def().dataKeyPair.privateKey,
      TangemSdk.issuerDataCounter: _issuerDataCounter,
    });
  }
}

class WriteIssuerExDataBloc extends ActionBloc<WriteIssuerExDataResponse> {
  final bsIssuerDataCounter = BehaviorSubject<String>();

  String _cid;
  int _issuerDataCounter;

  WriteIssuerExDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
    subscriptions.add(bsIssuerDataCounter.stream.listen((event) => _issuerDataCounter = event.isEmpty ? null : int.parse(event)));
    bsIssuerDataCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeIssuerExData(callback, {
      TangemSdk.cid: _cid,
      TangemSdk.issuerPrivateKeyHex: Issuer.def().dataKeyPair.privateKey,
      TangemSdk.issuerDataCounter: _issuerDataCounter,
    });
  }
}

class ReadUserDataBloc extends ActionBloc<ReadUserDataResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  ReadUserDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.readUserData(callback, {TangemSdk.cid: _cid});
  }
}

class WriteUserDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserData = BehaviorSubject<String>();
  final bsUserCounter = BehaviorSubject<String>();

  String _cid;
  String _userData;
  int _userCounter;

  WriteUserDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
    subscriptions.add(bsUserData.stream.listen((event) => _userData = event));
    subscriptions.add(bsUserCounter.stream.listen((event) => _userCounter = event.isEmpty ? null : int.parse(event)));
    bsUserData.add("User data to be written on a card");
    bsUserCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeUserData(callback, {
      TangemSdk.cid: _cid,
      TangemSdk.userDataHex: _userData.toHexString(),
      TangemSdk.userCounter: _userCounter,
    });
  }
}

class WriteUserProtectedDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserProtectedData = BehaviorSubject<String>();
  final bsUserProtectedCounter = BehaviorSubject<String>();

  String _cid;
  String _userProtectedData;
  int _userProtectedCounter;

  WriteUserProtectedDataBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
    subscriptions.add(bsUserProtectedData.stream.listen((event) => _userProtectedData = event));
    subscriptions.add(bsUserProtectedCounter.stream.listen((event) => _userProtectedCounter = event.isEmpty ? null : int.parse(event)));
    bsUserProtectedData.add("Protected user data to be written on a card");
    bsUserProtectedCounter.add("1");
  }

  @override
  invokeAction() {
    TangemSdk.writeUserProtectedData(callback, {
      TangemSdk.cid: _cid,
      TangemSdk.userProtectedDataHex: _userProtectedData.toHexString(),
      TangemSdk.userProtectedCounter: _userProtectedCounter,
    });
  }
}

class CreateWalletBloc extends ActionBloc<CreateWalletResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  CreateWalletBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.createWallet(callback, {TangemSdk.cid: _cid});
  }
}

class PurgeWalletBloc extends ActionBloc<PurgeWalletResponse> {
  final bsCid = BehaviorSubject<String>();

  String _cid;

  PurgeWalletBloc() {
    subscriptions.add(bsCid.stream.listen((event) => _cid = event));
  }

  @override
  invokeAction() {
    TangemSdk.purgeWallet(callback, {TangemSdk.cid: _cid});
  }
}
