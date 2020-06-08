import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class ImportConfigDialog {
  final PersonalizationBloc _bloc;

  ImportConfigDialog(this._bloc);

  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBody(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImportConfigWidget(_bloc),
          ),
        );
      },
    );
  }
}

class ImportConfigWidget extends StatefulWidget {
  final PersonalizationBloc _bloc;

  const ImportConfigWidget(this._bloc);

  @override
  _ImportConfigWidgetState createState() => _ImportConfigWidgetState();
}

class _ImportConfigWidgetState extends State<ImportConfigWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            child: TextField(
              key: ItemId.from(ItemName.personalizationImportInput),
              decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5), labelText: "Paste the configuration", isDense: true),
              style: TextStyle(fontSize: AppDimen.itemTextSize),
              onSubmitted: _onSubmit,
              controller: _controller,
            ),
          ),
          SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: OutlineButton(
              key: ItemId.btnFrom(ItemName.personalizationImportInput),
              child: TextWidget(Transl.of(context).menu_pers_import),
              onPressed: () => _onSubmit(_controller.text),
            ),
          )
        ],
      ),
    );
  }

  _onSubmit(String text) {
    widget._bloc.importConfig(text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
