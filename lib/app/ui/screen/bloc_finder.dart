import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocFinder {
  static SignBloc sign(context) => BlocProvider.of<SignBloc>(context);

  static ScanBloc scan(context) => BlocProvider.of<ScanBloc>(context);

  static DepersonalizeBloc depersonalize(context) => BlocProvider.of<DepersonalizeBloc>(context);
}

