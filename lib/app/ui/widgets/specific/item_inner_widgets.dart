import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/extensions/widgets.dart';
import 'package:devkit/commons/global/show_description.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/extensions.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextWidget(
        title,
        fontSize: AppDimen.itemTitleTextSize,
        color: AppColor.itemTitle,
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String? description;
  final EdgeInsets? padding;

  DescriptionWidget(this.description, [this.padding]);

  @override
  Widget build(BuildContext context) {
    if (description.isNullOrEmpty()) return StubWidget();

    final desc = description!;
    return StreamBuilder<bool>(
      initialData: false,
      stream: DescriptionState.listen(),
      builder: (context, snapshot) {
        final data = snapshot.data ?? false;
        final widget = TextWidget(desc, fontSize: AppDimen.itemDescTextSize, color: AppColor.itemDescription);
        return AnimatedOpacity(
          opacity: data ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Visibility(
            visible: data,
            child: padding == null ? widget : widget.padding(padding!),
          ),
        );
      },
    );
  }
}
