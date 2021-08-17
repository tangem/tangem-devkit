import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/dialog/dialog.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class SaveConfigDialog {
  final PersonalizationBloc _bloc;

  SaveConfigDialog(this._bloc);

  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBody(
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SaveConfigWidget(_bloc),
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
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 5),
          TextField(
            key: ItemId.from(ItemName.personalizationConfigInput),
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              labelText: transl.hint_enter_config_name,
              isDense: true,
            ),
            style: TextStyle(fontSize: AppDimen.itemTextSize),
          ),
          SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: OutlinedButton(
              key: ItemId.btnFrom(ItemName.personalizationConfigInput),
              child: TextWidget(transl.btn_save),
              onPressed: _controller.text.isEmpty ? null : () => _onPressed(context),
            ),
          )
        ],
      ),
    );
  }

  _onPressed(BuildContext context) {
    widget._bloc.saveNewConfig(_controller.text);
    widget._bloc.fetchSavedConfigNames();
    widget._bloc.sendSnackbarMessage("'${_controller.text}' saved");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
