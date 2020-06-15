import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseResponseWidget extends StatelessWidget {
  final String name;
  final dynamic value;

  const BaseResponseWidget({Key key, this.name, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: buildWidget(context),
      onTap: () {
        final data = "$name - ${stringOf(value)}";
        Clipboard.setData(ClipboardData(text: data));
        showSnackbar(context, "Copied to clipboard\n$data");
      },
    );
  }

  Widget buildWidget(BuildContext context);
}

class ResponseTextWidget extends BaseResponseWidget {
  final String description;
  final Color bgColor;

  const ResponseTextWidget({Key key, String name, dynamic value, this.description, this.bgColor}) : super(key: key, name: name, value: value);

  @override
  Widget buildWidget(BuildContext context) {
    if (value == null) return StubWidget();

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextWidget(name, fontSize: 16),
                  TextWidget(stringOf(value), fontSize: AppDimen.itemTitleTextSize, color: AppColor.itemDescription),
                  DescriptionWidget(description, EdgeInsets.only(top: 5)),
                ],
              ),
            ),
            HorizontalDelimiter(),
          ],
        ),
      ),
    );
  }
}

class ResponseCheckboxWidget extends BaseResponseWidget {
  final String description;
  final Color bgColor;

  const ResponseCheckboxWidget({Key key, String name, dynamic value, this.description, this.bgColor}) : super(key: key, name: name, value: value);

  @override
  Widget buildWidget(BuildContext context) {
    if (value == null) return StubWidget();

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            value: value,
            onChanged: null,
            title: TextWidget(stringOf(name), fontSize: AppDimen.itemTextSize, color: Colors.black),
          ),
          HorizontalDelimiter(),
        ],
      ),
    );
  }
}
