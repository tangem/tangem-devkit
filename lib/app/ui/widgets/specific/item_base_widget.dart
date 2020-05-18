import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/global/show_description.dart';
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
            child: Align(alignment: Alignment.centerLeft, child: item),
          ),
          description,
        ],
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;

  DescriptionWidget(this.description);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: DescriptionState.streamShowDescription,
      builder: (context, snapshot) {
        return AnimatedOpacity(
          opacity: snapshot.data ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Visibility(
            visible: snapshot.data,
            child: TextWidget(description, color: AppColor.textHintDescription),
          ),
        );
      },
    );
  }
}
