import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/dialog/dialog.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class SaveLoadConfigsDialog {
  final PersonalizationBloc _bloc;

  SaveLoadConfigsDialog(this._bloc);

  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBody(
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SaveConfigWidget(_bloc),
                SizedBox(height: 5),
                ConfigListWidget(_bloc),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SaveConfigWidget extends StatefulWidget {
  final PersonalizationBloc _bloc;

  SaveConfigWidget(this._bloc);

  @override
  _SaveConfigWidgetState createState() => _SaveConfigWidgetState();
}

class _SaveConfigWidgetState extends State<SaveConfigWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
            fit: FlexFit.tight,
            child: TextField(
              key: ItemId.from(ItemName.personalizationConfigInput),
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                labelText: transl.hint_enter_config_name,
                isDense: true,
              ),
              style: TextStyle(fontSize: AppDimen.itemTextSize),
            )),
        SizedBox(width: 10),
        OutlineButton(
          key: ItemId.btnFrom(ItemName.personalizationConfigInput),
          child: TextWidget(transl.btn_save),
          onPressed: _controller.text.isEmpty ? null : _onPressed,
        ),
      ],
    );
  }

  _onPressed() {
    widget._bloc.saveNewConfig(_controller.text);
    widget._bloc.fetchSavedConfigNames();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ConfigListWidget extends StatelessWidget {
  final PersonalizationBloc _bloc;

  const ConfigListWidget(this._bloc);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: StreamBuilder<List<String>>(
          initialData: [],
          stream: _bloc.bsSavedConfigNames.stream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(border: Border.all(color: AppColor.border)),
              child: ListBody(children: _generateTileList(context, snapshot.data!)),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _generateTileList(BuildContext context, List<String> itemList) {
    return itemList.map((configName) {
      final itemName = "${ItemName.personalizationConfigItems}.${itemList.indexOf(configName)}";
      return _bloc.isDefaultConfigName(configName) ? _defaultTile(context, configName, itemName) : _usualTile(context, configName, itemName);
    }).toList();
  }

  Widget _defaultTile(BuildContext context, String configName, String itemName) {
    return ListTile(
      key: ItemId.from(itemName),
      onTap: () {
        _bloc.restoreDefaultConfig();
        Navigator.of(context).pop();
      },
      title: TextWidget(configName, color: AppColor.itemDescription),
      trailing: IconButton(
        key: ItemId.btnFrom(itemName),
        icon: Icon(Icons.delete_outline),
        onPressed: null,
      ),
    );
  }

  Widget _usualTile(BuildContext context, String configName, String itemName) {
    return ListTile(
      key: ItemId.from(itemName),
      onTap: () {
        _bloc.restoreConfig(configName);
        Navigator.of(context).pop();
      },
      title: TextWidget(configName),
      trailing: IconButton(
        key: ItemId.btnFrom(itemName),
        icon: Icon(Icons.delete),
        onPressed: () {
          _bloc.deleteConfig(configName);
          _bloc.fetchSavedConfigNames();
        },
      ),
    );
  }
}
