import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/repository/personalization_config_repository.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';

class PresetDetailScreen extends StatelessWidget {
  final PersonalizationBloc _bloc;
  final PresetInfo _presetInfo;

  PresetDetailScreen(RouteSettings settings, {Key? key})
      : this._bloc = settings.readArgument<PersonalizationBloc>("_bloc"),
        this._presetInfo = settings.readArgument<PresetInfo>("_presetInfo"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final json = JsonEncoder.withIndent('  ').convert(_presetInfo.config?.toJson() ?? "");
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(_presetInfo.name),
        actions: [
          ShareIconButton(() => _bloc.shareConfig(_presetInfo.name)),
        ],
      ),
      body: SingleChildScrollView(child: TextWidget(json)),
    );
  }

  static void navigate(BuildContext context, PersonalizationBloc bloc, PresetInfo details) {
    final args = createArguments("_bloc", bloc).addArgument("_presetInfo", details);
    Navigator.of(context).pushNamed(Routes.PERSONALIZE_PRESETS_DETAIL, arguments: args);
  }
}

class ShareIconButton extends StatelessWidget {
  final VoidCallback shareFunction;

  const ShareIconButton(this.shareFunction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: ItemId.btnFrom("share"),
      icon: Icon(Icons.share),
      onPressed: shareFunction,
    );
  }
}
