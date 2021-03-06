import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/test_bloc.dart';
import 'package:devkit/app/ui/screen/card_action/files_change_settings_screen.dart';
import 'package:devkit/app/ui/screen/card_action/files_delete_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocFinder {
  static SignBloc sign(context) => BlocProvider.of<SignBloc>(context);

  static ScanBloc scan(context) => BlocProvider.of<ScanBloc>(context);

  static DepersonalizeBloc depersonalize(context) => BlocProvider.of<DepersonalizeBloc>(context);
}

class RepoFinder {
  static TestBlock createTestBloc(context) => RepositoryProvider.of<TestBlock>(context);

  static PersonalizationBloc personalizationBloc(context) => RepositoryProvider.of<PersonalizationBloc>(context);

  static CreateWalletBloc createWalletBloc(context) => RepositoryProvider.of<CreateWalletBloc>(context);

  static PurgeWalletBloc purgeWalletBloc(context) => RepositoryProvider.of<PurgeWalletBloc>(context);

  static ReadIssuerDataBloc readIssuerDataBloc(context) => RepositoryProvider.of<ReadIssuerDataBloc>(context);

  static WriteIssuerDataBloc writeIssuerDataBloc(context) => RepositoryProvider.of<WriteIssuerDataBloc>(context);

  static ReadIssuerExDataBloc readIssuerExDataBloc(context) => RepositoryProvider.of<ReadIssuerExDataBloc>(context);

  static WriteIssuerExDataBloc writeIssuerExDataBloc(context) => RepositoryProvider.of<WriteIssuerExDataBloc>(context);

  static ReadUserDataBloc readUserDataBloc(context) => RepositoryProvider.of<ReadUserDataBloc>(context);

  static WriteUserDataBloc writeUserDataBloc(context) => RepositoryProvider.of<WriteUserDataBloc>(context);

  static WriteUserProtectedDataBloc writeUserProtectedDataBloc(context) =>
      RepositoryProvider.of<WriteUserProtectedDataBloc>(context);

  static SetPinBlock setPinBloc(context) => RepositoryProvider.of<SetPinBlock>(context);

  static FilesWriteBloc setFilesWriteBloc(context) => RepositoryProvider.of<FilesWriteBloc>(context);

  static FilesReadBloc setFilesReadBloc(context) => RepositoryProvider.of<FilesReadBloc>(context);

  static FilesDeleteBloc setFilesDeleteBloc(context) => RepositoryProvider.of<FilesDeleteBloc>(context);

  static FilesChangeSettingsBloc setFilesChangeSettingsBloc(context) =>
      RepositoryProvider.of<FilesChangeSettingsBloc>(context);
}
