import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/personalize/repository/personalization_config_repository.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'preset_detail_screen.dart';

class PersonalPresetListFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersonalizationBloc bloc = context.read<PersonalizationBloc>();
    return StreamBuilder<List<String>>(
      initialData: [],
      stream: bloc.bsPersonalConfigNames.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return StubWidget();

        final itemList = snapshot.data!;
        return ListView.separated(
          itemCount: itemList.length,
          separatorBuilder: (context, index) => HorizontalDelimiter(),
          itemBuilder: (context, index) {
            final configName = itemList[index];
            return PersonalPresetListTile(bloc, PresetInfo(configName, bloc.getConfig(configName), true));
          },
        );
      },
    );
  }
}

class DefaultPresetListFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersonalizationBloc bloc = context.read<PersonalizationBloc>();
    return StreamBuilder<List<String>>(
      initialData: [],
      stream: bloc.bsDefaultConfigNames.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return StubWidget();

        final itemList = snapshot.data!;
        return ListView.separated(
          itemCount: itemList.length,
          separatorBuilder: (context, index) => HorizontalDelimiter(),
          itemBuilder: (context, index) {
            final configName = itemList[index];
            return PersonalPresetListTile(bloc, PresetInfo(configName, bloc.getConfig(configName), false));
          },
        );
      },
    );
  }
}

class PersonalPresetListTile extends StatelessWidget {
  final PersonalizationBloc _bloc;
  final PresetInfo _presetInfo;

  const PersonalPresetListTile(this._bloc, this._presetInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canBeDeleted = _bloc.isDefaultConfigName(_presetInfo.name) || !_presetInfo.isPersonal;
    return ListTile(
      onTap: () {
        _bloc.restoreConfig(_presetInfo.name);
        Navigator.of(context).pop();
      },
      title: TextWidget(_presetInfo.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: canBeDeleted ? 0 : 1,
            child: IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: canBeDeleted
                  ? null
                  : () {
                      _bloc.deleteConfig(_presetInfo.name);
                      _bloc.fetchPersonalConfigNames();
                    },
            ),
          ),
          ShareIconButton(() => _bloc.shareConfig(_presetInfo.name)),
          IconButton(
            icon: Icon(Icons.line_style),
            onPressed: () => PresetDetailScreen.navigate(context, _bloc, _presetInfo),
          ),
        ],
      ),
    );
  }
}
