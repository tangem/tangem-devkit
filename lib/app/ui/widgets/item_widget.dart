import 'package:devkit/app/ui/widgets/semi_widget.dart';
import 'package:devkit/app/ui/widgets/text_widget.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Widget item;
  final Widget description;

  const ItemWidget({Key key, @required this.item, @required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: AppDimen.itemBaseHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: item,
            ),
          ),
          description,
        ],
      ),
    );
  }

  factory ItemWidget.input(Key key, TextEditingController controller, TextInputType inputType, [String hint = "", String description = ""]) {
    return ItemWidget(
      item: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 3),
          labelText: hint,
          isDense: true,
        ),
        style: TextStyle(fontSize: AppDimen.itemTextSize),
      ),
      description: DescriptionWidget(
        description: description,
        isDescriptionEnabled: App.streamShowDescription,
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;
  final Stream<bool> isDescriptionEnabled;

  const DescriptionWidget({Key key, this.description, this.isDescriptionEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: isDescriptionEnabled,
      builder: (context, snapshot) {
        if (snapshot == null || !snapshot.data) return StubWidget();

        return Container(
          child: TextWidget(description, color: AppColor.textHintDescription),
        );
      },
    );
  }
}
