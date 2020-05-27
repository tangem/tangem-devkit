import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/global/show_description.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextWidget(
        title,
        fontSize: 12,
        color: AppColor.itemTitle,
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;

  DescriptionWidget(this.description);

  @override
  Widget build(BuildContext context) {
    return description == null
        ? StubWidget()
        : StreamBuilder<bool>(
            initialData: false,
            stream: DescriptionState.listen(),
            builder: (context, snapshot) {
              return AnimatedOpacity(
                opacity: snapshot.data ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: snapshot.data,
                  child: TextWidget(description, color: AppColor.itemDescription),
                ),
              );
            },
          );
  }
}
