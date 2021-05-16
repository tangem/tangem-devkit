import 'dart:io';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:devkit/app/domain/model/command_data_models.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:rxdart/rxdart.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class ReadIssuerDataBloc extends ActionBloc<ReadIssuerDataResponse> {
  @override
  CommandDataModel? createCommandData() => ReadIssuerDataModel();
}

class ReadIssuerExDataBloc extends ActionBloc<ReadIssuerExDataResponse> {
  @override
  CommandDataModel? createCommandData() => ReadIssuerExDataModel();
}

class WriteIssuerDataBloc extends ActionBloc<WriteIssuerDataResponse> {
  final bsIssuerData = BehaviorSubject<String>();
  final bsIssuerDataCounter = BehaviorSubject<String>();

  String _issuerData = "";
  int _issuerDataCounter = 1;

  WriteIssuerDataBloc() {
    subscriptions.add(bsIssuerData.stream.listen((event) => _issuerData = event));
    subscriptions.add(
        bsIssuerDataCounter.stream.listen((event) => _issuerDataCounter = int.tryParse(event) ?? _issuerDataCounter));
    bsIssuerData.add("Data to be written on a card as issuer data");
    bsIssuerDataCounter.add("1");
  }

  @override
  CommandDataModel? createCommandData() {
    final issuerPrivateKey = Utils.createDefaultIssuer().dataKeyPair.privateKey;
    if (!hasCid()) {
      sendSnackbarMessage("To write an issuer data you must fill the CID field");
      return null;
    }
    return WriteIssuerDataModel("it will be changed in base class", _issuerData, issuerPrivateKey, _issuerDataCounter);
  }
}

class WriteIssuerExDataBloc extends ActionBloc<WriteIssuerExDataResponse> {
  final bsIssuerDataCounter = BehaviorSubject<String>();

  int _issuerDataCounter = 0;

  WriteIssuerExDataBloc() {
    subscriptions.add(
        bsIssuerDataCounter.stream.listen((event) => _issuerDataCounter = int.tryParse(event) ?? _issuerDataCounter));
    bsIssuerDataCounter.add("1");
  }

  @override
  CommandDataModel? createCommandData() {
    final issuerPrivateKey = Utils.createDefaultIssuer().dataKeyPair.privateKey;
    if (!hasCid()) {
      sendSnackbarMessage("To write an issuer extra data you must fill the CID field");
      return null;
    }
    return WriteIssuerExDataModel(Utils.cardId, "issuerData", issuerPrivateKey, _issuerDataCounter);
  }
}

class ReadUserDataBloc extends ActionBloc<ReadUserDataResponse> {
  @override
  CommandDataModel? createCommandData() {
    return ReadUserDataModel();
  }
}

class WriteUserDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserData = BehaviorSubject<String>();
  final bsUserCounter = BehaviorSubject<String>();

  String _userData = "";
  int? _userCounter;

  WriteUserDataBloc() {
    subscriptions.add(bsUserData.stream.listen((event) => _userData = event));
    subscriptions.add(bsUserCounter.stream.listen((event) => _userCounter = event.isEmpty ? null : int.parse(event)));
    bsUserData.add("User data to be written on a card");
    bsUserCounter.add("1");
  }

  @override
  CommandDataModel? createCommandData() {
    return WriteUserDataModel(_userData, _userCounter);
  }
}

class WriteUserProtectedDataBloc extends ActionBloc<WriteUserDataResponse> {
  final bsUserProtectedData = BehaviorSubject<String>();
  final bsUserProtectedCounter = BehaviorSubject<String>();

  String _userProtectedData = "";
  int? _userProtectedCounter;

  WriteUserProtectedDataBloc() {
    subscriptions.add(bsUserProtectedData.stream.listen((event) => _userProtectedData = event));
    subscriptions.add(bsUserProtectedCounter.stream
        .listen((event) => _userProtectedCounter = event.isEmpty ? null : int.parse(event)));
    bsUserProtectedData.add("Protected user data to be written on a card");
    bsUserProtectedCounter.add("1");
  }

  @override
  CommandDataModel? createCommandData() {
    return WriteUserProtectedDataModel(_userProtectedData, _userProtectedCounter);
  }
}

class CreateWalletBloc extends ActionBloc<CreateWalletResponse> {
  @override
  CommandDataModel? createCommandData() {
    return CreateWalletModel();
  }
}

class PurgeWalletBloc extends ActionBloc<PurgeWalletResponse> {
  @override
  CommandDataModel? createCommandData() {
    return PurgeWalletModel();
  }
}

class SetPinBlock extends ActionBloc<SetPinResponse> {
  final PinType pinType;
  final bsPinCode = BehaviorSubject<String>();

  String? _pinCode;

  SetPinBlock(this.pinType) {
    subscriptions.add(bsPinCode.stream.listen((event) => _pinCode = event));
  }

  @override
  CommandDataModel? createCommandData() {
    final code = _pinCode.isNullOrEmpty() ? null : _pinCode;
    return pinType == PinType.PIN1 ? SetPin1Model(code) : SetPin2Model(code);
  }
}

enum FileProtectionType { PASSCODE, ISSUER }

class FilesWriteBloc extends ActionBloc<WriteFilesResponse> {
  final protectionTypes = [
    Pair("Passcode", FileProtectionType.PASSCODE),
    Pair("Issuer", FileProtectionType.ISSUER),
  ];

  final bsProtectionType = BehaviorSubject<Pair<String, FileProtectionType>>();

  final _bsFilePhoto = BehaviorSubject<File>();
  final _bsFilePhotoSize = BehaviorSubject<int>();

  FileProtectionType _protectionType = FileProtectionType.PASSCODE;
  WriteFileData? _writeFileData;
  int _counter = 0;

  Stream<File> get photoStream => _bsFilePhoto.stream;

  Stream<int> get photoFileSizeStream => _bsFilePhotoSize.stream;

  FilesWriteBloc() {
    subscriptions.add(bsProtectionType.listen((value) => _protectionType = value.b));
  }

  setPhotoFile(File? file) async {
    if (file == null) return;

    file = await _reducePhotoFileSize(file);
    if (file == null) {
      sendSnackbarMessage("Image compressing failed");
      return;
    }
    _bsFilePhotoSize.add(await file.length());
    _bsFilePhoto.add(file);
    final fileData = await file.readAsBytes();
    _writeFileData = WriteFileData(fileData, _counter);
    _counter += 1;
  }

  Future<File?> _reducePhotoFileSize(File file) async {
    final dir = await PathProvider.getTemporaryDirectory();
    int fileLength = await file.length();
    while (fileLength > 15000) {
      final decodedImage = await decodeImageFromList(file.readAsBytesSync());
      final width = decodedImage.width;
      final height = decodedImage.height;
      File? reducedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        Path.join(dir.path, "temp_photo_${width}_$height.jpg"),
        minWidth: width ~/ 1.5,
        minHeight: height ~/ 1.5,
        quality: 80,
      );
      if (reducedFile == null) return null;

      fileLength = await reducedFile.length();
    }
    return file;
  }

  @override
  CommandDataModel? createCommandData() {
    if (_writeFileData == null) {
      sendSnackbarMessage("Writing data is empty");
      return null;
    }

    WriteFileData writeFileData = _writeFileData!;
    switch (_protectionType) {
      case FileProtectionType.ISSUER:
        if (!hasCid()) {
          sendSnackbarMessage("For Issuer protection you must fill the CID field");
          return null;
        }
        return FilesWriteModel([writeFileData], Utils.createDefaultIssuer());
      case FileProtectionType.PASSCODE:
        return FilesWriteModel([writeFileData]);
      default:
        return null;
    }
  }
}

class FilesReadBloc extends ActionBloc<ReadFilesResponse> {
  final bsReadProtectedFiles = BehaviorSubject<bool>();
  final bsIndices = BehaviorSubject<String>();

  bool? _readProtectionFiles;
  String? _indices;

  FilesReadBloc() {
    subscriptions.add(bsReadProtectedFiles.listen((value) => _readProtectionFiles = value));
    subscriptions.add(bsIndices.listen((value) => _indices = value));
  }

  @override
  CommandDataModel? createCommandData() {
    final indices = _indices?.splitToList().toIntList();
    return FilesReadModel(_readProtectionFiles ?? false, indices);
  }
}

class FilesDeleteBloc extends ActionBloc<DeleteFilesResponse> {
  final bsIndices = BehaviorSubject<String>();

  String? _indices;

  FilesDeleteBloc() {
    subscriptions.add(bsIndices.listen((value) => _indices = value));
  }

  @override
  CommandDataModel? createCommandData() {
    List<int>? indices = _indices?.splitToList().toIntList();
    return FilesDeleteModel(indices);
  }
}

class FilesChangeSettingsBloc extends ActionBloc<ChangeFilesSettingsResponse> {
  final fileSettings = [
    Pair("Public", FileSettings.Public),
    Pair("Private", FileSettings.Private),
  ];

  final bsIndices = BehaviorSubject<String>();
  final bsFileSettings = BehaviorSubject<Pair<String, FileSettings>>();

  String? _indices;
  FileSettings _fileSettings = FileSettings.Public;

  FilesChangeSettingsBloc() {
    subscriptions.add(bsIndices.listen((value) => _indices = value));
    subscriptions.add(bsFileSettings.listen((value) => _fileSettings = value.b));
  }

  @override
  CommandDataModel? createCommandData() {
    if (_indices == null) {
      sendSnackbarMessage("Indices is empty");
      return null;
    }

    List<int> indices = _indices!.splitToList().toIntList();
    final changes = indices.map((e) => ChangeFileSettings(e, _fileSettings)).toList();
    return FilesChangeSettingsModel(changes);
  }
}

class DepersonalizationBloc extends ActionBloc<DepersonalizeResponse> {
  @override
  CommandDataModel? createCommandData() => DepersonalizeModel();
}

class ScanBloc extends ActionBloc<CardResponse> {
  @override
  CommandDataModel? createCommandData() => ScanModel();
}

class SignBloc extends ActionBloc<SignResponse> {
  final bsDataForHashing = BehaviorSubject<String>();

  String _dataForHashing = "";

  SignBloc() {
    subscriptions.add(bsDataForHashing.stream.listen((event) => _dataForHashing = event));
    bsDataForHashing.add("Data used for hashing");
  }

  @override
  CommandDataModel? createCommandData() {
    final data = _dataForHashing.splitToList().toStringList();
    return SignModel(data);
  }
}