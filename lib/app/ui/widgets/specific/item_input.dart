import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;

  const InputWidget(Key key, this.controller, this.inputType, this.hint) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 3),
        labelText: hint,
        isDense: true,
      ),
      style: TextStyle(fontSize: AppDimen.itemTextSize),
    );
  }
}

class InputCidWidget extends StatefulWidget {
  final Key key;
  final TextEditingController controller;
  final Function onTap;

  InputCidWidget(this.key, this.controller, this.onTap);

  @override
  _InputCidWidgetState createState() => _InputCidWidgetState();
}

class _InputCidWidgetState extends State<InputCidWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_updateOuterController);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: InputWidget(widget.key, _controller, TextInputType.text, transl.card_id),
          ),
        ),
        SizedBox(width: 10),
        Visibility(
          visible: _controller.text.isEmpty,
          child: RaisedButton(
            key: stringKey("${widget.key}.btn"),
            child: TextWidget(Transl.of(context).action_scan),
            onPressed: widget.onTap,
          ),
        ),
      ],
    );
  }

  _updateOuterController() {
    widget.controller.text = _controller.text;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
