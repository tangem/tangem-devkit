import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class ReadIssuerDataBloc extends ActionBloc<ReadIssuerDataResponse> {
  @override
  CommandSignatureData createCommandData() {
    return ReadIssuerDataModel();
  }
}

class ReadIssuerExDataBloc extends ActionBloc<ReadIssuerExDataResponse> {
  @override
  CommandSignatureData createCommandData() {
    return ReadIssuerExDataModel();
  }
}

class WriteIssuerDataBloc extends ActionBloc<WriteIssuerDataResponse> {
  final bsIssuerData = BehaviorSubject<String>();
  final bsIssuerDataCounter = BehaviorSubject<String>();

  String _issuerData;
  int _issuerDataCounter;

  WriteIssuerDataBloc() {
    subscriptions.add(bsIssuerData.stream.listen((event) => _issuerData = event));
    subscriptions.add(
        bsIssuerDataCounter.stream.listen((event) => _issuerDataCounter = event.isEmpty ? null : int.parse(event)));
    bsIssuerData.add("Data to be written on a card as issuer data");
    bsIssuerDataCounter.add("1");
  }

  @override
  CommandSignatureData createCommandData() {
    final issuerPrivateKey = Utils.createDefaultIssuer().dataKeyPair.privateKey;
    return WriteIssuerDataModel(Utils.cardId, _issuerData, issuerPrivateKey, _issuerDataCounter);
  }
}

class WriteIssuerExDataBloc extends ActionBloc<WriteIssuerExDataResponse> {
  final bsIssuerDataCounter = BehaviorSubject<String>();

  int _issuerDataCounter;

  WriteIssuerExDataBloc() {
    subscriptions.add(
        bsIssuerDataCounter.stream.listen((event) => _issuerDataCounter = event.isEmpty ? null : int.parse(event)));
    bsIssuerDataCounter.add("1");
  }

  @override
  CommandSignatureData createCommandData() {
    final issuerPrivateKey = Utils.createDefaultIssuer().dataKeyPair.privateKey;
    return WriteIssuerExDataModel(Utils.cardId, "issuerData", issuerPrivateKey, _issuerDataCounter);
  }
}

class ReadUserDataBloc extends ActionBloc<ReadUserDataResponse> {
  @override
  CommandSignatureData createCommandData() {
    return ReadUserDataModel();
  }
}

class WriteUserDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserData = BehaviorSubject<String>();
  final bsUserCounter = BehaviorSubject<String>();

  String _userData;
  int _userCounter;

  WriteUserDataBloc() {
    subscriptions.add(bsUserData.stream.listen((event) => _userData = event));
    subscriptions.add(bsUserCounter.stream.listen((event) => _userCounter = event.isEmpty ? null : int.parse(event)));
    bsUserData.add("User data to be written on a card");
    bsUserCounter.add("1");
  }

  @override
  CommandSignatureData createCommandData() {
    return WriteUserDataModel(_userData, _userCounter);
  }
}

class WriteUserProtectedDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserProtectedData = BehaviorSubject<String>();
  final bsUserProtectedCounter = BehaviorSubject<String>();

  String _userProtectedData;
  int _userProtectedCounter;

  WriteUserProtectedDataBloc() {
    subscriptions.add(bsUserProtectedData.stream.listen((event) => _userProtectedData = event));
    subscriptions.add(bsUserProtectedCounter.stream
        .listen((event) => _userProtectedCounter = event.isEmpty ? null : int.parse(event)));
    bsUserProtectedData.add("Protected user data to be written on a card");
    bsUserProtectedCounter.add("1");
  }

  @override
  CommandSignatureData createCommandData() {
    return WriteUserProtectedDataModel(_userProtectedData, _userProtectedCounter);
  }
}

class CreateWalletBloc extends ActionBloc<CreateWalletResponse> {
  @override
  CommandSignatureData createCommandData() {
    return CreateWalletModel();
  }
}

class PurgeWalletBloc extends ActionBloc<PurgeWalletResponse> {
  @override
  CommandSignatureData createCommandData() {
    return PurgeWalletModel();
  }
}

class SetPinBlock extends ActionBloc<SetPinResponse> {
  final PinType pinType;
  final bsPinCode = BehaviorSubject<String>();

  String _pinCode;

  SetPinBlock(this.pinType) {
    subscriptions.add(bsPinCode.stream.listen((event) => _pinCode = event));
  }

  @override
  CommandSignatureData createCommandData() {
    final code = _pinCode == null || _pinCode.isEmpty ? null : _pinCode;
    return pinType == PinType.PIN1 ? SetPin1Model(code) : SetPin2Model(code);
  }
}
