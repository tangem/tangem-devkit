import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImportConfigDialog {
  final PersonalizationBloc _bloc;

  ImportConfigDialog(this._bloc);

  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBody(
          Padding(
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
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 5),
          TextField(
            key: ItemId.from(ItemName.personalizationImportInput),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              labelText: "Paste the configuration",
              isDense: true,
            ),
            minLines: 1,
            maxLines: 25,
            style: TextStyle(fontSize: AppDimen.itemTextSize),
            onSubmitted: _onSubmit,
            controller: _controller,
          ),
          SizedBox(height: 15),
          Row(
            children: [
              OutlinedButton(
                  onPressed: () async {
                    final data = await Clipboard.getData(Clipboard.kTextPlain);
                    final textData = data?.text ?? "";
                    if (textData.isEmpty) return;

                    _controller.value = TextEditingValue(text: textData);
                  },
                  child: Icon(Icons.paste)),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  key: ItemId.btnFrom(ItemName.personalizationImportInput),
                  child: TextWidget(Transl.of(context).menu_pers_import),
                  onPressed: _controller.text.isEmpty ? null : () => _onSubmit(_controller.text),
                ),
              )
            ],
          ),
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
