import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class PresetDetailScreen extends StatelessWidget {
  final PersonalizationBloc _bloc;
  final PresetInfo _presetInfo;

  const PresetDetailScreen(this._bloc, this._presetInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final json = JsonEncoder.withIndent('  ').convert(_bloc.getConfig(_presetInfo.name)!.toJson());
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PresetDetailScreen(bloc, details);
    }));
  }
}

class PresetInfo {
  final String name;
  final String itemName;

  PresetInfo(this.name, this.itemName);
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
