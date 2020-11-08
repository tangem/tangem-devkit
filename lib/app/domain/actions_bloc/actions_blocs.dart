import 'dart:io';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/domain/model/personalization/utils.dart';
import 'package:devkit/app/domain/model/signature_data_models.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart' as PathProvider;
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

enum FileProtectionType { PASSCODE, ISSUER }

class FilesWriteBloc extends ActionBloc<WriteFilesResponse> {
  final protectionTypes = [
    Pair("Passcode", FileProtectionType.PASSCODE),
    Pair("Issuer", FileProtectionType.ISSUER),
  ];

  final bsProtectionType = BehaviorSubject<Pair<String, FileProtectionType>>();

  final _bsFilePhoto = BehaviorSubject<File>();
  final _bsFilePhotoSize = BehaviorSubject<int>();

  FileProtectionType _protectionType;
  WriteFileData _writeFileData;
  int _counter = 1;

  Stream<File> get photoStream => _bsFilePhoto.stream;

  Stream<int> get photoFileSizeStream => _bsFilePhotoSize.stream;

  FilesWriteBloc() {
    subscriptions.add(bsProtectionType.listen((value) => _protectionType = value.b));
  }

  setPhotoFile(File file) async {
    if (file == null) return;

    file = await _reducePhotoFileSize(file);
    _bsFilePhotoSize.add(await file.length());
    _bsFilePhoto.add(file);
    final fileData = await file.readAsBytes();
    _writeFileData = WriteFileData(fileData, _counter);
    _counter += 1;
  }

  Future<File> _reducePhotoFileSize(File file) async {
    final dir = await PathProvider.getTemporaryDirectory();
    int fileLength = await file.length();
    while (fileLength > 15000) {
      final decodedImage = await decodeImageFromList(file.readAsBytesSync());
      final width = decodedImage.width;
      final height = decodedImage.height;
      file = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        Path.join(dir.path, "temp_photo_${width}_$height.jpg"),
        minWidth: width ~/ 1.5,
        minHeight: height ~/ 1.5,
        quality: 80,
      );
      fileLength = await file.length();
    }
    return file;
  }

  @override
  CommandSignatureData createCommandData() {
    if (_writeFileData == null) {
      sendSnackbarMessage("Writing data is empty");
      return null;
    }

    if (_protectionType == null) _protectionType = FileProtectionType.PASSCODE;
    switch (_protectionType) {
      case FileProtectionType.ISSUER:
        if (!hasCid()) {
          sendSnackbarMessage("For Issuer protection you must fill the CID field");
          return null;
        }
        return FilesWriteModel([_writeFileData], Utils.createDefaultIssuer());
      case FileProtectionType.PASSCODE:
        return FilesWriteModel([_writeFileData]);
      default:
        return null;
    }
  }
}

class FilesReadBloc extends ActionBloc<ReadFilesResponse> {
  final bsReadProtectedFiles = BehaviorSubject<bool>();
  final bsIndices = BehaviorSubject<String>();

  bool _readProtectionFiles;
  String _indices;

  Stream<String> get indicesStream => bsIndices.stream;

  FilesReadBloc() {
    subscriptions.add(bsReadProtectedFiles.listen((value) => _readProtectionFiles = value));
    subscriptions.add(bsIndices.listen((value) => _indices = value));
  }

  @override
  CommandSignatureData createCommandData() {
    final indices = _indices.toList()?.toIntList();
    return FilesReadModel(_readProtectionFiles ?? false, indices);
  }
}
