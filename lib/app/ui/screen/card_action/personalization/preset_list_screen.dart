import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

import 'preset_detail_screen.dart';

class PresetListScreen extends StatelessWidget {
  final PersonalizationBloc _bloc;

  const PresetListScreen(this._bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextWidget("Select preset")),
      body: PresetListFrame(_bloc),
    );
  }

  static void navigate(BuildContext context, PersonalizationBloc bloc) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      bloc.fetchSavedConfigNames();
      return PresetListScreen(bloc);
    }));
  }
}

class PresetListFrame extends StatelessWidget {
  final PersonalizationBloc _bloc;

  PresetListFrame(this._bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      initialData: [],
      stream: _bloc.bsSavedConfigNames.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return StubWidget();

        final itemList = snapshot.data!;
        return ListView.separated(
          itemCount: itemList.length,
          separatorBuilder: (context, index) => HorizontalDelimiter(),
          itemBuilder: (context, index) {
            final configName = itemList[index];
            return PresetListTile(_bloc, PresetInfo(configName, "${ItemName.personalizationConfigItems}.$index"));
          },
        );
      },
    );
  }
}

class PresetListTile extends StatelessWidget {
  final PersonalizationBloc _bloc;
  final PresetInfo _presetInfo;

  const PresetListTile(this._bloc, this._presetInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDefault = _bloc.isDefaultConfigName(_presetInfo.name);
    return ListTile(
      key: ItemId.from(_presetInfo.itemName),
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
            opacity: isDefault ? 0 : 1,
            child: IconButton(
              key: ItemId.btnFrom(_presetInfo.itemName),
              icon: Icon(Icons.delete_outline),
              onPressed: isDefault
                  ? null
                  : () {
                      _bloc.deleteConfig(_presetInfo.name);
                      _bloc.fetchSavedConfigNames();
                    },
            ),
          ),
          ShareIconButton(() => _bloc.shareConfig(_presetInfo.name)),
          IconButton(
            key: ItemId.from("info_${_presetInfo.itemName}"),
            icon: Icon(Icons.line_style),
            onPressed: () => PresetDetailScreen.navigate(context, _bloc, _presetInfo),
          ),
        ],
      ),
    );
  }
}
