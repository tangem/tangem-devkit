import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/model/command_signature_data.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class TestBlock extends ActionBloc<dynamic> {
  final _bsInputCommand = BehaviorSubject<String>();

  Map<String, dynamic> _command;
  String _commandType;
  String _inputedCommand;

  Subject<String> get inputCommandSubject => _bsInputCommand;

  TestBlock() {
    subscriptions.add(_bsInputCommand.stream.listen((event) => _inputedCommand = event));
  }

  invokeAction() {
    _clearFields();
    if (_inputedCommand == null || _inputedCommand.isEmpty) {
      sendError(TangemSdkError("Input a command first"));
      return;
    }

    try {
      _command = json.decode(_inputedCommand) as Map<String, dynamic>;
      _commandType = _command[TangemSdk.commandType];

      if (_commandType == null) {
        sendError(TangemSdkError("Missing the commandType attribute"));
        return;
      }
    } catch (e) {
      sendError(TangemSdkError("Json conversion error: $e"));
      return;
    }

    final commandData = createCommandData();
    if (commandData == null) {
      sendError(TangemSdkError("Command data signature not created"));
      return;
    }

    TangemSdk.runCommand(callback, commandData);
  }

  @override
  CommandSignatureData createCommandData() {
    if (_command == null || _commandType == null) return null;

    switch (_commandType) {
      case TangemSdk.cScanCard:
        return ScanModel();
      case TangemSdk.cSign:
        return SignModel.fromJson(_command);
      case TangemSdk.cPersonalize:
        return PersonalizationModel.fromJson(_command);
      case TangemSdk.cDepersonalize:
        return DepersonalizeModel.fromJson(_command);
      case TangemSdk.cCreateWallet:
        return CreateWalletModel.fromJson(_command);
      case TangemSdk.cPurgeWallet:
        return PurgeWalletModel.fromJson(_command);
      case TangemSdk.cReadIssuerData:
        return ReadUserDataModel.fromJson(_command);
      case TangemSdk.cWriteIssuerData:
        return WriteIssuerDataModel.fromJson(_command);
      case TangemSdk.cReadIssuerExData:
        return ReadIssuerExDataModel.fromJson(_command);
      case TangemSdk.cWriteIssuerExData:
        return WriteIssuerExDataModel.fromJson(_command);
      case TangemSdk.cReadUserData:
        return ReadUserDataModel.fromJson(_command);
      case TangemSdk.cWriteUserData:
        return WriteUserDataModel.fromJson(_command);
      case TangemSdk.cWriteUserProtectedData:
        return WriteUserProtectedDataModel.fromJson(_command);
      case TangemSdk.cSetPin1:
        return SetPin1Model.fromJson(_command);
      case TangemSdk.cSetPin2:
        return SetPin2Model.fromJson(_command);
      case TangemSdk.cWriteFiles:
        return WriteFilesModel.fromJson(_command);
      default:
        return null;
    }
  }

  _clearFields() {
    sendSuccess(null);
    sendError(null);
  }

  @override
  sendError(TangemSdkBaseError error) {
    if (error is UserCancelledError) return;

    super.sendError(error);
  }
}
