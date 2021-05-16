import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/basic/button.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'item_inner_widgets.dart';

class InputWidget extends StatelessWidget {
  final String keyName;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? hint;
  final String? description;
  final double minHeight;
  final EdgeInsets? padding;
  final Stream<bool>? scrollStream;

  const InputWidget(
    this.keyName,
    this.controller, {
    this.hint,
    this.description,
    this.inputType = TextInputType.text,
    this.minHeight = AppDimen.itemMinHeight,
    this.padding,
    this.scrollStream,
  });

  @override
  Widget build(BuildContext context) {
    final widget = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          scrollStream == null
              ? buildTextField(false)
              : StreamBuilder<bool>(
                  initialData: true,
                  stream: scrollStream!,
                  builder: (context, snapshot) => buildTextField(snapshot.data ?? true),
                ),
          DescriptionWidget(description, EdgeInsets.only(top: 10)),
        ],
      ),
    );
    return padding == null ? widget.padding16() : Padding(padding: padding!, child: widget);
  }

  // crutch! -> hide cursor while the widget is scrolling. If don't do this, the scroll jumps to the textField
  // when it receive a textValue through a textController
  TextField buildTextField(bool isScrolling) {
    return TextField(
      key: ItemId.from(keyName),
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5), labelText: hint, isDense: true),
      style: TextStyle(fontSize: AppDimen.itemTextSize),
      showCursor: !isScrolling,
    );
  }
}

class InputCidWidget extends StatefulWidget {
  final String keyName;
  final TextEditingController controller;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  InputCidWidget(this.keyName, this.controller, this.onTap, {this.padding});

  @override
  _InputCidWidgetState createState() => _InputCidWidgetState();
}

class _InputCidWidgetState extends State<InputCidWidget> {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: InputWidget(
                widget.keyName,
                widget.controller,
                hint: transl.card_id,
                description: transl.desc_card_id,
                minHeight: 0,
                padding: EdgeInsets.only(right: 10),
              ),
            ),
          ),
          Visibility(
            child: Button(
              Transl.of(context).action_scan,
              key: ItemId.btnFrom(widget.keyName),
              onPressed: widget.onTap,
            ),
          ),
        ],
      ),
    );
  }
}
