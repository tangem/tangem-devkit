import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/model/command_data_models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/model/command_data.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class TestBlock extends ActionBloc<dynamic> {
  final _bsInputCommand = BehaviorSubject<String>();

  Map<String, dynamic>? _command;
  String? _commandType;
  String? _inputedCommand;

  Subject<String> get inputCommandSubject => _bsInputCommand;

  TestBlock() {
    addSubscription(_bsInputCommand.stream.listen((event) => _inputedCommand = event));
  }

  invokeAction() async {
    _clearFields();
    if (_inputedCommand.isNullOrEmpty()) {
      sendError(PluginFlutterError("Input the command json first"));
      return;
    }

    try {
      _command = json.decode(_inputedCommand!) as Map<String, dynamic>;
      _commandType = _command![TangemSdk.commandType];

      if (_commandType == null) {
        sendError(PluginFlutterError("Missing the commandType attribute"));
        return;
      }
    } catch (e) {
      sendError(PluginFlutterError("Json conversion error: $e"));
      return;
    }

    try {
      createCommandData((commandData) {
        TangemSdk.runCommand(callback, commandData);
      }, (errorMessage) {
        sendError(PluginFlutterError("Command data signature not created. Cause: $errorMessage"));
      });
    } catch (e) {
      sendError(PluginFlutterError("Can't create the command data: $e"));
    }
  }

  @override
  void createCommandData(Function(CommandDataModel) onSuccess, Function(String) onError) {
    if (_command == null || _commandType == null) {
      onError("Command or command type is missed");
      return;
    }

    final model = createCommandByType(_commandType!, _command!);
    if (model == null) {
      onError("Can't create a CommandDataModel. Realization is missed for type: $_commandType");
    } else {
      onSuccess(model);
    }
  }

  CommandDataModel? createCommandByType(String type, Map<String, dynamic> command) {
    switch (_commandType) {
      case TangemSdk.cScanCard:
        return ScanModel();
      case TangemSdk.cSign:
        return SignModel.fromJson(command);
      case TangemSdk.cPersonalize:
        return PersonalizationModel.fromJson(command);
      case TangemSdk.cDepersonalize:
        return DepersonalizeModel.fromJson(command);
      case TangemSdk.cCreateWallet:
        return CreateWalletModel.fromJson(command);
      case TangemSdk.cPurgeWallet:
        return PurgeWalletModel.fromJson(command);
      case TangemSdk.cReadIssuerData:
        return ReadUserDataModel.fromJson(command);
      case TangemSdk.cWriteIssuerData:
        return WriteIssuerDataModel.fromJson(command);
      case TangemSdk.cReadIssuerExData:
        return ReadIssuerExDataModel.fromJson(command);
      case TangemSdk.cWriteIssuerExData:
        return WriteIssuerExDataModel.fromJson(command);
      case TangemSdk.cReadUserData:
        return ReadUserDataModel.fromJson(command);
      case TangemSdk.cWriteUserData:
        return WriteUserDataModel.fromJson(command);
      case TangemSdk.cWriteUserProtectedData:
        return WriteUserProtectedDataModel.fromJson(command);
      case TangemSdk.cSetPin1:
        return SetPin1Model.fromJson(command);
      case TangemSdk.cSetPin2:
        return SetPin2Model.fromJson(command);
      case TangemSdk.cWriteFiles:
        return FilesWriteModel.fromJson(command);
      case TangemSdk.cReadFiles:
        return FilesReadModel.fromJson(command);
      case TangemSdk.cDeleteFiles:
        return FilesDeleteModel.fromJson(command);
      case TangemSdk.cChangeFilesSettings:
        return FilesChangeSettingsModel.fromJson(command);
      default:
        return null;
    }
  }

  _clearFields() {
    sendSuccess(null);
    sendError(null);
  }

  @override
  sendError(TangemSdkPluginError? error) {
    if (error?.isUserCancelledError() == true) return;

    super.sendError(error);
  }
}
