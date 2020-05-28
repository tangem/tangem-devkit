import 'package:devkit/app/ui/widgets/specific/item_inner_widgets.dart';
import 'package:devkit/commons/extensions/widgets.dart';
import 'package:devkit/commons/global/show_description.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

import '../app_widgets.dart';

class SegmentHeader extends StatelessWidget {
  final String title;
  final String description;

  const SegmentHeader(this.title, {Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: AppDimen.itemMinHeight - 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextWidget(title, fontSize: AppDimen.itemTextSize),
          description == null || description.isEmpty
              ? StubWidget()
              : StreamBuilder<bool>(
                  stream: DescriptionState.listen(),
                  initialData: DescriptionState.state,
                  builder: (context, snapshot) => !snapshot.data ? StubWidget() : SizedBox(height: 3),
                ),
          DescriptionWidget(description),
        ],
      ),
    ).padding16().bg(AppColor.itemBgBlock);
  }
}